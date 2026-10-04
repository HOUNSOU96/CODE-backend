from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session
from sqlalchemy import desc
from datetime import datetime

from database import get_db
from models.document_version import DocumentVersion


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
                "content_path": version.content_path,
                "content_hash": version.content_hash,
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
# 3. PUBLIER UNE NOUVELLE VERSION
# ==========================================================

@router.post("/publish")
def publish_version(
    data: PublishVersionRequest,
    db: Session = Depends(get_db),
):
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