from datetime import datetime

from fastapi import (
    APIRouter,
    Depends,
    Header,
    HTTPException,
)
from fastapi.responses import Response
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
            UserDevice.device_id
            == device_id,
            UserDevice.is_active
            == True,
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

    La seule information technique reçue du frontend
    est X-Device-ID.

    Le serveur vérifie ensuite :
      1. que l'appareil existe ;
      2. qu'il est actif ;
      3. qu'une autorisation existe ;
      4. que cette autorisation est active ;
      5. que le document correspondant est activé.
    """

    device = get_device(
        x_device_id,
        db,
    )

    # Mise à jour de la présence de l'appareil.
    device.last_seen = datetime.utcnow()

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

    db.commit()

    return {
        "documents": documents
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

    L'accès est accordé uniquement si le X-Device-ID
    correspond à un UserDevice actif et que ce device
    possède une DocumentDeviceAccess active pour
    cette activation.
    """

    # --------------------------------------------------------
    # 1. Vérification de l'appareil
    # --------------------------------------------------------

    device = get_device(
        x_device_id,
        db,
    )

    # --------------------------------------------------------
    # 2. Recherche du document
    # --------------------------------------------------------

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

    # --------------------------------------------------------
    # 3. Vérification de l'autorisation
    # --------------------------------------------------------

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

    # --------------------------------------------------------
    # 4. Vérification du PDF enregistré
    # --------------------------------------------------------

    if not activation.pdf_data:
        raise HTTPException(
            status_code=404,
            detail="PDF_NOT_AVAILABLE",
        )

    # --------------------------------------------------------
    # 5. Mise à jour des accès
    # --------------------------------------------------------

    now = datetime.utcnow()

    access.last_access = now
    device.last_seen = now

    db.commit()

    # --------------------------------------------------------
    # 6. Préparation du nom de fichier
    # --------------------------------------------------------

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

    # --------------------------------------------------------
    # 7. Retour du PDF
    # --------------------------------------------------------

    return Response(
        content=activation.pdf_data,
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