from utils.device_types import normalize_device_type, is_supported_device
from fastapi import APIRouter, Depends, HTTPException, Header
from fastapi.responses import FileResponse
from pathlib import Path
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import desc
from datetime import datetime
from dependencies import get_current_user
from models.user import User


from database import get_db
from models.document_version import DocumentVersion
from models.user_device import UserDevice
from models.document_device_access import DocumentDeviceAccess
from models.document_activation import DocumentActivation


# ==========================================================
# ROUTER
# ==========================================================

router = APIRouter(
    prefix="/api/document-versions",
    tags=["document-versions"],
)


# ==========================================================
# DOCUMENTS AUTORISÉS
# ==========================================================

SUPPORTED_DOCUMENTS = {
    "CODE Maths 1er cycle Tome I",
}


# ==========================================================
# SCHÉMAS
# ==========================================================

class PublishVersionRequest(BaseModel):
    document_name: str
    version_label: str

    title: str | None = None
    description: str | None = None

    content_path: str | None = None
    content_hash: str | None = None


# ==========================================================
# UTILITAIRE
# ==========================================================

def validate_document_name(document_name: str):
    """
    Vérifie que le document est connu par CODE.
    """

    document_name = document_name.strip()

    if document_name not in SUPPORTED_DOCUMENTS:
        raise HTTPException(
            status_code=404,
            detail="DOCUMENT_NOT_SUPPORTED",
        )

    return document_name


# ==========================================================
# 1. VERSION ACTUELLE
# ==========================================================

@router.get("/current/{document_name}")
def get_current_version(
    document_name: str,
    db: Session = Depends(get_db),
):
    """
    Retourne la version actuellement publiée
    pour un document.
    """

    document_name = validate_document_name(
        document_name
    )

    version = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.document_name
            == document_name,
            DocumentVersion.is_current
            == True,
        )
        .order_by(
            desc(DocumentVersion.version_code)
        )
        .first()
    )

    if not version:
        raise HTTPException(
            status_code=404,
            detail="NO_VERSION_AVAILABLE",
        )

    return {
        "document_name": version.document_name,
        "version_code": version.version_code,
        "version_label": version.version_label,
        "title": version.title,
        "description": version.description,
        "published_at": (
            version.published_at.isoformat()
            if version.published_at
            else None
        ),
    }


# ==========================================================
# CATALOGUE PUBLIC DES DOCUMENTS
# ==========================================================

@router.get("/catalog")
def get_document_catalog(
    db: Session = Depends(get_db),
):
    """
    Retourne les documents actuellement publiés.
    Les chemins internes des fichiers ne sont jamais exposés.
    """

    versions = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.is_current.is_(True),
            DocumentVersion.document_name.in_(
                SUPPORTED_DOCUMENTS
            ),
        )
        .order_by(DocumentVersion.document_name.asc())
        .all()
    )

    return {
        "documents": [
            {
                "id": version.id,
                "document_name": version.document_name,
                "version_code": version.version_code,
                "version_label": version.version_label,
                "title": version.title,
                "description": version.description,
                "published_at": (
                    version.published_at.isoformat()
                    if version.published_at
                    else None
                ),
                "allow_download": bool(version.allow_download),
            }
            for version in versions
        ]
    }


# ==========================================================
class DownloadPermissionRequest(BaseModel):
    allow_download: bool


@router.put("/{version_id}/download-permission")
def update_download_permission(
    version_id: int,
    data: DownloadPermissionRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Autorise ou interdit le téléchargement pour une version publiée.
    Réservé aux administrateurs.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="ADMIN_ACCESS_REQUIRED",
        )

    version = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.id == version_id,
            DocumentVersion.is_current.is_(True),
            DocumentVersion.document_name.in_(SUPPORTED_DOCUMENTS),
        )
        .first()
    )

    if version is None:
        raise HTTPException(
            status_code=404,
            detail="CURRENT_DOCUMENT_VERSION_NOT_FOUND",
        )

    version.allow_download = data.allow_download

    db.commit()
    db.refresh(version)

    return {
        "success": True,
        "version_id": version.id,
        "document_name": version.document_name,
        "allow_download": bool(version.allow_download),
    }


# 2. HISTORIQUE DES VERSIONS
# ==========================================================

@router.get("/all/{document_name}")
def get_all_versions(
    document_name: str,
    db: Session = Depends(get_db),
):
    """
    Retourne toutes les versions d'un document.
    """

    document_name = validate_document_name(
        document_name
    )

    versions = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.document_name
            == document_name
        )
        .order_by(
            desc(DocumentVersion.version_code)
        )
        .all()
    )

    return {
        "document_name": document_name,
        "versions": [
            {
                "id": version.id,
                "version_code": version.version_code,
                "version_label": version.version_label,
                "title": version.title,
                "description": version.description,
                "published_at": (
                    version.published_at.isoformat()
                    if version.published_at
                    else None
                ),
                "is_current": version.is_current,
            }
            for version in versions
        ],
    }



# ==========================================================
# LECTURE PUBLIQUE DE L'ORIGINAL
# ==========================================================

@router.get("/{activation_id}/original")
def read_original_document(
    activation_id: int,
    x_device_id: str | None = Header(
        default=None,
        alias="X-Device-ID",
    ),
    db: Session = Depends(get_db),
):
    """
    Sert le PDF original correspondant à une activation valide.
    L'identifiant reçu dans l'URL est celui de DocumentActivation,
    et non celui de DocumentVersion.
    """

    if not x_device_id:
        raise HTTPException(
            status_code=403,
            detail="DEVICE_ID_MISSING",
        )

    device = (
        db.query(UserDevice)
        .filter(
            UserDevice.device_id == x_device_id,
            UserDevice.is_active.is_(True),
        )
        .first()
    )

    if not device:
        raise HTTPException(
            status_code=403,
            detail="DEVICE_NOT_REGISTERED",
        )

    device_type = normalize_device_type(device.device_type)
    if not is_supported_device(device_type):
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_MOBILE_ONLY",
        )

    # L'identifiant reçu depuis MesDocuments.tsx est un ID d'activation.
    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.id == activation_id,
            DocumentActivation.user_id == device.user_id,
            DocumentActivation.is_activated.is_(True),
            DocumentActivation.globally_revoked_at.is_(None),
            DocumentActivation.document_name.in_(SUPPORTED_DOCUMENTS),
        )
        .first()
    )

    if not activation:
        raise HTTPException(
            status_code=404,
            detail="ACTIVE_DOCUMENT_ACTIVATION_NOT_FOUND",
        )

    # Retrouver la version courante à partir du nom du document activé.
    version = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.document_name == activation.document_name,
            DocumentVersion.is_current.is_(True),
        )
        .order_by(desc(DocumentVersion.id))
        .first()
    )

    if not version:
        raise HTTPException(
            status_code=404,
            detail="PUBLISHED_VERSION_NOT_FOUND",
        )

    # L'appareil doit avoir un accès actif à cette activation précise.
    access = (
        db.query(DocumentDeviceAccess)
        .filter(
            DocumentDeviceAccess.activation_id == activation.id,
            DocumentDeviceAccess.device_id == device.id,
            DocumentDeviceAccess.user_id == device.user_id,
            DocumentDeviceAccess.is_active.is_(True),
        )
        .first()
    )

    if not access:
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_ACCESS_DENIED",
        )

    original_path = (
        Path(__file__).resolve().parent.parent
        / "public_documents"
        / "CODE-MathsI-original.pdf"
    )

    if not original_path.is_file() or original_path.stat().st_size == 0:
        raise HTTPException(
            status_code=404,
            detail="ORIGINAL_PDF_NOT_FOUND",
        )

    return FileResponse(
        path=str(original_path),
        media_type="application/pdf",
        headers={
            "Content-Disposition": 'inline; filename="CODE-MathsI-original.pdf"',
            "X-Content-Type-Options": "nosniff",
            "Cache-Control": (
                "no-store, no-cache, must-revalidate, max-age=0"
            ),
            "Pragma": "no-cache",
            "Expires": "0",
        },
    )


# 3. PUBLIER UNE NOUVELLE VERSION
# ==========================================================

@router.post("/publish")
def publish_version(
    data: PublishVersionRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="ADMIN_ACCESS_REQUIRED",
        )
    """
    Publie une nouvelle version d'un document.

    Le serveur calcule automatiquement version_code.

    Exemple :

        première publication → 1
        deuxième publication → 2
        troisième publication → 3
    """

    document_name = validate_document_name(
        data.document_name
    )

    version_label = data.version_label.strip()

    if not version_label:
        raise HTTPException(
            status_code=400,
            detail="VERSION_LABEL_REQUIRED",
        )

    # ------------------------------------------------------
    # Recherche de la dernière version
    # ------------------------------------------------------

    latest_version = (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.document_name
            == document_name
        )
        .order_by(
            desc(DocumentVersion.version_code)
        )
        .first()
    )

    if latest_version:

        next_version_code = (
            latest_version.version_code + 1
        )

    else:

        next_version_code = 1

    # ------------------------------------------------------
    # Désactiver les anciennes versions
    # ------------------------------------------------------

    db.query(DocumentVersion).filter(
        DocumentVersion.document_name
        == document_name,
        DocumentVersion.is_current
        == True,
    ).update(
        {
            DocumentVersion.is_current: False
        },
        synchronize_session=False,
    )

    # ------------------------------------------------------
    # Nouvelle version
    # ------------------------------------------------------

    version = DocumentVersion(
        document_name=document_name,
        version_code=next_version_code,
        version_label=version_label,
        title=data.title,
        description=data.description,
        content_path=data.content_path,
        content_hash=data.content_hash,
        published_at=datetime.utcnow(),
        is_current=True,
    )

    db.add(version)

    try:

        db.commit()

    except Exception:

        db.rollback()

        raise HTTPException(
            status_code=500,
            detail="VERSION_PUBLICATION_FAILED",
        )

    db.refresh(version)

    return {
        "success": True,
        "message": "Nouvelle version publiée avec succès.",
        "version": {
            "id": version.id,
            "document_name": version.document_name,
            "version_code": version.version_code,
            "version_label": version.version_label,
            "title": version.title,
            "description": version.description,
            "content_path": version.content_path,
            "content_hash": version.content_hash,
            "published_at": (
                version.published_at.isoformat()
            ),
            "is_current": version.is_current,
        },
    }