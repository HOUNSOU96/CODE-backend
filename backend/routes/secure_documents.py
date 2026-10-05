from datetime import datetime
from pathlib import Path

from fastapi import (
    APIRouter,
    Depends,
    Header,
    HTTPException,
)
from fastapi.responses import FileResponse
from sqlalchemy.orm import Session

from database import get_db

from models.user_device import UserDevice
from models.document_device_access import (
    DocumentDeviceAccess,
)
from models.document_activation import (
    DocumentActivation,
)


router = APIRouter(
    prefix="/api",
    tags=["secure-documents"],
)


# ============================================================
# CHEMIN DU BACKEND
# ============================================================

BACKEND_DIR = (
    Path(__file__).resolve().parent.parent
)


# ============================================================
# OUTIL : RÉCUPÉRER L'APPAREIL
# ============================================================

def get_device(
    device_id: str | None,
    db: Session,
) -> UserDevice:
    """
    Récupère l'appareil à partir du X-Device-ID.

    IMPORTANT :
    Le device_id n'est pas considéré comme une
    autorisation en lui-même.

    L'autorisation du document est ensuite vérifiée
    dans DocumentDeviceAccess.
    """

    if not device_id:
        raise HTTPException(
            status_code=400,
            detail="DEVICE_ID_MISSING",
        )

    device = (
        db.query(UserDevice)
        .filter(
            UserDevice.device_id == device_id,
            UserDevice.is_active == True,
        )
        .first()
    )

    if not device:
        raise HTTPException(
            status_code=404,
            detail="DEVICE_NOT_REGISTERED",
        )

    return device


# ============================================================
# VÉRIFICATION : APPAREIL AUTORISÉ
# ============================================================

def require_mobile_device(
    device: UserDevice,
) -> UserDevice:
    """
    Autorise uniquement les appareils mobiles/tablettes.

    Les ordinateurs de bureau sont explicitement refusés.

    Cela constitue une protection côté serveur :
    même si quelqu'un tente d'appeler directement
    l'URL du document depuis un PC, le backend refuse
    l'accès avant de rechercher/envoyer le PDF.
    """

    device_type = (
        (device.device_type or "")
        .strip()
        .lower()
    )

    if device_type == "desktop":
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_MOBILE_ONLY",
        )

    # --------------------------------------------------------
    # On autorise :
    #   mobile
    #   tablet
    #
    # On refuse également les types inconnus.
    #
    # Cela évite qu'un appareil non identifié bénéficie
    # accidentellement de l'accès au document.
    # --------------------------------------------------------

    if device_type not in {
        "mobile",
        "tablet",
    }:
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_MOBILE_ONLY",
        )

    return device


# ============================================================
# MES DOCUMENTS
# ============================================================

@router.get(
    "/my-secure-documents"
)
def get_my_secure_documents(
    x_device_id: str | None = Header(
        default=None,
        alias="X-Device-ID",
    ),
    db: Session = Depends(get_db),
):
    """
    Retourne les documents sécurisés auxquels
    l'appareil courant possède encore accès.

    Cette route fonctionne SANS authentification
    utilisateur.

    Le serveur vérifie :

      1. que l'appareil existe ;
      2. qu'il est actif ;
      3. que l'appareil est mobile/tablette ;
      4. qu'une autorisation existe ;
      5. que cette autorisation est active ;
      6. que le document correspondant est activé.
    """

    # ========================================================
    # 1. RÉCUPÉRATION DE L'APPAREIL
    # ========================================================

    device = get_device(
        x_device_id,
        db,
    )

    # ========================================================
    # 2. BLOQUER LES PC
    # ========================================================

    require_mobile_device(
        device
    )

    # ========================================================
    # 3. MISE À JOUR DE LA PRÉSENCE
    # ========================================================

    device.last_seen = datetime.utcnow()

    # ========================================================
    # 4. RECHERCHE DES AUTORISATIONS
    # ========================================================

    accesses = (
        db.query(
            DocumentDeviceAccess
        )
        .filter(
            DocumentDeviceAccess.device_id
            == device.id,
            DocumentDeviceAccess.is_active
            == True,
        )
        .all()
    )

    documents = []

    # ========================================================
    # 5. RÉCUPÉRATION DES DOCUMENTS AUTORISÉS
    # ========================================================

    for access in accesses:

        activation = (
            db.query(
                DocumentActivation
            )
            .filter(
                DocumentActivation.id
                == access.activation_id,

                DocumentActivation.is_activated
                == True,
            )
            .first()
        )

        if not activation:
            continue

        # ----------------------------------------------------
        # IMPORTANT :
        # Le chemin physique du PDF n'est jamais envoyé
        # au frontend.
        # ----------------------------------------------------

        documents.append(
            {
                "id": activation.id,
                "document_id": activation.id,
                "document_name": activation.document_name,
                "name": activation.document_name,
                "title": activation.document_name,
                "authorized": True,
                "access_id": access.id,
            }
        )

    # ========================================================
    # 6. ENREGISTRER LA DERNIÈRE ACTIVITÉ
    # ========================================================

    db.commit()

    return {
        "documents": documents,
        "mobile_only": True,
    }


# ============================================================
# OUVRIR UN DOCUMENT SÉCURISÉ
# ============================================================

@router.get(
    "/secure-documents/{document_id}"
)
def get_secure_document(
    document_id: int,
    x_device_id: str | None = Header(
        default=None,
        alias="X-Device-ID",
    ),
    db: Session = Depends(get_db),
):
    """
    Retourne le PDF personnalisé correspondant
    au document demandé.

    AUCUN JWT n'est nécessaire.

    L'accès est accordé uniquement si :

      1. le X-Device-ID correspond à un UserDevice actif ;
      2. l'appareil est mobile ou tablette ;
      3. le document existe et est activé ;
      4. le device possède une DocumentDeviceAccess active ;
      5. le fichier PDF sécurisé existe réellement ;
      6. le chemin enregistré reste à l'intérieur du
         dossier backend autorisé.

    Le PDF n'est jamais récupéré depuis pdf_data.
    """

    # ========================================================
    # 1. VÉRIFICATION DE L'APPAREIL
    # ========================================================

    device = get_device(
        x_device_id,
        db,
    )

    # ========================================================
    # 2. BLOQUER LES PC
    # ========================================================

    require_mobile_device(
        device
    )

    # ========================================================
    # 3. RECHERCHE DU DOCUMENT
    # ========================================================

    activation = (
        db.query(
            DocumentActivation
        )
        .filter(
            DocumentActivation.id
            == document_id,

            DocumentActivation.is_activated
            == True,
        )
        .first()
    )

    if not activation:
        raise HTTPException(
            status_code=404,
            detail="DOCUMENT_NOT_FOUND",
        )

    # ========================================================
    # 4. VÉRIFICATION DE L'AUTORISATION
    # ========================================================

    access = (
        db.query(
            DocumentDeviceAccess
        )
        .filter(
            DocumentDeviceAccess.activation_id
            == activation.id,

            DocumentDeviceAccess.device_id
            == device.id,

            DocumentDeviceAccess.is_active
            == True,
        )
        .first()
    )

    if not access:
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_ACCESS_DENIED",
        )

    # ========================================================
    # 5. VÉRIFICATION DU CHEMIN PDF
    # ========================================================

    if not activation.pdf_path:
        raise HTTPException(
            status_code=404,
            detail="PDF_NOT_AVAILABLE",
        )

    try:

        secure_pdf_path = (
            BACKEND_DIR
            / activation.pdf_path
        ).resolve()

    except Exception:

        raise HTTPException(
            status_code=404,
            detail="PDF_PATH_INVALID",
        )

    # ========================================================
    # 6. PROTECTION CONTRE LE PATH TRAVERSAL
    # ========================================================

    try:

        secure_pdf_path.relative_to(
            BACKEND_DIR.resolve()
        )

    except ValueError:

        raise HTTPException(
            status_code=403,
            detail="PDF_PATH_INVALID",
        )

    # ========================================================
    # 7. VÉRIFICATION DU FICHIER
    # ========================================================

    if not secure_pdf_path.exists():

        raise HTTPException(
            status_code=404,
            detail="PDF_FILE_NOT_FOUND",
        )

    if not secure_pdf_path.is_file():

        raise HTTPException(
            status_code=404,
            detail="PDF_FILE_INVALID",
        )

    if secure_pdf_path.stat().st_size == 0:

        raise HTTPException(
            status_code=404,
            detail="PDF_FILE_EMPTY",
        )

    # ========================================================
    # 8. MISE À JOUR DES ACCÈS
    # ========================================================

    now = datetime.utcnow()

    access.last_access = now
    device.last_seen = now

    db.commit()

    # ========================================================
    # 9. PRÉPARATION DU NOM DU DOCUMENT
    # ========================================================

    filename = (
        activation.pdf_filename
        or activation.document_name
        or "document-code.pdf"
    )

    if not filename.lower().endswith(
        ".pdf"
    ):
        filename = (
            f"{filename}.pdf"
        )

    # ========================================================
    # 10. RETOUR DU PDF
    # ========================================================
    #
    # IMPORTANT :
    #
    # Le PDF est envoyé uniquement APRÈS toutes les
    # vérifications précédentes.
    #
    # Il n'est pas stocké dans pdf_data.
    #
    # FileResponse permet au serveur de lire le fichier
    # depuis le stockage sécurisé.
    # ========================================================

    return FileResponse(
        path=str(secure_pdf_path),

        media_type="application/pdf",

        headers={
            "Content-Disposition": (
                f'inline; filename="{filename}"'
            ),

            "Cache-Control": (
                "no-store, no-cache, "
                "must-revalidate, max-age=0"
            ),

            "Pragma": "no-cache",

            "Expires": "0",

            "X-Document-Name": (
                activation.document_name
                or "Document sécurisé"
            ),
        },
    )