from fastapi import APIRouter, Depends, HTTPException, Header
from pydantic import BaseModel, EmailStr
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime

from database import get_db
from dependencies import get_current_user

from models.user import User, UserStatus
from models.document_activation import DocumentActivation
from models.document_version import DocumentVersion
from models.user_device import UserDevice
from models.document_device_access import DocumentDeviceAccess

from utils.hashing import hash_password


# ==========================================================
# ROUTER
# ==========================================================

router = APIRouter(
    prefix="/api/document-access",
    tags=["document-access"],
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

class DeviceActivationRequest(BaseModel):
    activation_code: str
    document_name: str
    device_id: str
    device_type: str = "android"

    buyer_email: EmailStr
    beneficiary_email: EmailStr

    activation_type: str = "self"

    nom: str | None = None
    prenom: str | None = None
    telephone: str | None = None
    pays_residence: str | None = None
    password: str | None = None


# ==========================================================
# UTILITAIRES
# ==========================================================

def validate_document_name(document_name: str):
    document_name = document_name.strip()

    if document_name not in SUPPORTED_DOCUMENTS:
        raise HTTPException(
            status_code=404,
            detail="DOCUMENT_NOT_SUPPORTED",
        )

    return document_name


def get_current_document_version(
    db: Session,
    document_name: str,
):
    return (
        db.query(DocumentVersion)
        .filter(
            DocumentVersion.document_name == document_name,
            DocumentVersion.is_current == True,
        )
        .order_by(
            DocumentVersion.version_code.desc()
        )
        .first()
    )


def normalize_email(value: str) -> str:
    return value.strip().lower()


# ==========================================================
# 1. ACTIVATION SÉCURISÉE DU DOCUMENT SUR L'APPAREIL
# ==========================================================

@router.post("/activate-device")
def activate_device(
    data: DeviceActivationRequest,
    db: Session = Depends(get_db),
):
    """
    Active CODE Maths sur l'appareil actuel.

    IMPORTANT :
    - aucun PDF n'est généré ;
    - aucun PDF n'est téléchargé ;
    - aucun e-mail n'est envoyé ;
    - aucune pièce jointe n'est créée.

    Cette route réalise également la première activation
    du code et associe le document au bénéficiaire.
    """

    document_name = validate_document_name(
        data.document_name
    )

    activation_code = data.activation_code.strip()
    device_id = data.device_id.strip()

    buyer_email = normalize_email(
        str(data.buyer_email)
    )

    beneficiary_email = normalize_email(
        str(data.beneficiary_email)
    )

    activation_type = data.activation_type.strip()

    # ------------------------------------------------------
    # VALIDATIONS
    # ------------------------------------------------------

    if not activation_code:
        raise HTTPException(
            status_code=400,
            detail="ACTIVATION_CODE_REQUIRED",
        )

    if not device_id:
        raise HTTPException(
            status_code=400,
            detail="DEVICE_ID_REQUIRED",
        )

    if activation_type not in {
        "self",
        "other",
    }:
        raise HTTPException(
            status_code=400,
            detail="ACTIVATION_TYPE_INVALID",
        )

    if activation_type == "self":
        if beneficiary_email != buyer_email:
            raise HTTPException(
                status_code=400,
                detail="SELF_ACTIVATION_EMAIL_MISMATCH",
            )

    # ------------------------------------------------------
    # RECHERCHE DU CODE AVEC VERROU
    # ------------------------------------------------------

    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.activation_code
            == activation_code
        )
        .with_for_update()
        .first()
    )

    if not activation:
        raise HTTPException(
            status_code=404,
            detail="ACTIVATION_CODE_INVALID",
        )

    if activation.document_name != document_name:
        raise HTTPException(
            status_code=400,
            detail="ACTIVATION_DOCUMENT_MISMATCH",
        )

    # ------------------------------------------------------
    # VÉRIFICATION DE L'ACHETEUR
    # ------------------------------------------------------

    if activation.buyer_email:

        stored_buyer_email = normalize_email(
            activation.buyer_email
        )

        if stored_buyer_email != buyer_email:
            raise HTTPException(
                status_code=403,
                detail="EMAIL_CODE_MISMATCH",
            )

    # ------------------------------------------------------
    # VERSION ACTUELLE
    # ------------------------------------------------------

    current_version = get_current_document_version(
        db,
        document_name,
    )

    if not current_version:
        raise HTTPException(
            status_code=404,
            detail="NO_VERSION_AVAILABLE",
        )

    # ------------------------------------------------------
    # RECHERCHE DU BÉNÉFICIAIRE
    # ------------------------------------------------------

    user = (
        db.query(User)
        .filter(
            func.lower(User.email)
            == beneficiary_email
        )
        .first()
    )

    # ======================================================
    # COMPTE EXISTANT
    # ======================================================

    if user:

        activation.user_id = user.id

    # ======================================================
    # NOUVEAU COMPTE
    # ======================================================

    else:

        nom = (
            data.nom.strip()
            if data.nom
            else ""
        )

        prenom = (
            data.prenom.strip()
            if data.prenom
            else ""
        )

        telephone = (
            data.telephone.strip()
            if data.telephone
            else ""
        )

        pays_residence = (
            data.pays_residence.strip()
            if data.pays_residence
            else ""
        )

        password = (
            data.password
            if data.password
            else ""
        )

        if not nom:
            raise HTTPException(
                status_code=400,
                detail="NOM_REQUIRED",
            )

        if not prenom:
            raise HTTPException(
                status_code=400,
                detail="PRENOM_REQUIRED",
            )

        if not pays_residence:
            raise HTTPException(
                status_code=400,
                detail="PAYS_RESIDENCE_REQUIRED",
            )

        if not password:
            raise HTTPException(
                status_code=400,
                detail="PASSWORD_REQUIRED",
            )

        if len(password) < 6:
            raise HTTPException(
                status_code=400,
                detail="PASSWORD_TOO_SHORT",
            )

        # --------------------------------------------------
        # Sécurité contre une création concurrente
        # --------------------------------------------------

        existing_user = (
            db.query(User)
            .filter(
                func.lower(User.email)
                == beneficiary_email
            )
            .first()
        )

        if existing_user:

            user = existing_user

        else:

            user = User(
                nom=nom,
                prenom=prenom,
                email=beneficiary_email,
                telephone=(
                    telephone
                    if telephone
                    else None
                ),
                pays_residence=(
                    pays_residence
                    if pays_residence
                    else None
                ),
                hashed_password=hash_password(
                    password
                ),
                is_validated=True,
                is_active=True,
                is_blocked=False,
                is_admin=False,
                is_verified=False,
                status=UserStatus.VALIDATED.value,
                date_inscription=datetime.utcnow(),
                created_at=datetime.utcnow(),
            )

            db.add(user)
            db.flush()

        activation.user_id = user.id

    # ======================================================
    # ACTIVATION DU DOCUMENT
    # ======================================================

    activation.activation_type = activation_type

    activation.beneficiary_email = (
        beneficiary_email
    )

    activation.is_activated = True

    if activation.activated_at is None:
        activation.activated_at = datetime.utcnow()

    # ======================================================
    # RECHERCHE / CRÉATION DU DEVICE
    # ======================================================

    device = (
        db.query(UserDevice)
        .filter(
            UserDevice.device_id == device_id
        )
        .first()
    )

    if device:

        if device.user_id != user.id:
            raise HTTPException(
                status_code=403,
                detail="DEVICE_ALREADY_ASSOCIATED",
            )

        device.is_active = True
        device.is_mobile = True
        device.device_type = (
            data.device_type or "android"
        )
        device.last_seen = datetime.utcnow()

    else:

        device = UserDevice(
            user_id=user.id,
            device_id=device_id,
            device_type=(
                data.device_type or "android"
            ),
            is_mobile=True,
            is_active=True,
            created_at=datetime.utcnow(),
            last_seen=datetime.utcnow(),
        )

        db.add(device)
        db.flush()

    # ======================================================
    # UN SEUL APPAREIL ACTIF POUR CE CODE
    # ======================================================

    db.query(DocumentDeviceAccess).filter(
        DocumentDeviceAccess.activation_id
        == activation.id,

        DocumentDeviceAccess.device_id
        != device.id,

        DocumentDeviceAccess.is_active
        == True,
    ).update(
        {
            DocumentDeviceAccess.is_active: False
        },
        synchronize_session=False,
    )

    # ======================================================
    # ACCÈS EXISTANT ?
    # ======================================================

    access = (
        db.query(DocumentDeviceAccess)
        .filter(
            DocumentDeviceAccess.activation_id
            == activation.id,

            DocumentDeviceAccess.device_id
            == device.id,
        )
        .first()
    )

    if access:

        access.user_id = user.id
        access.is_active = True
        access.last_access = datetime.utcnow()
        access.last_version = (
            current_version.version_code
        )

    else:

        access = DocumentDeviceAccess(
            activation_id=activation.id,
            user_id=user.id,
            device_id=device.id,
            is_active=True,
            activated_at=datetime.utcnow(),
            last_access=datetime.utcnow(),
            last_version=current_version.version_code,
        )

        db.add(access)

    # ======================================================
    # ENREGISTREMENT
    # ======================================================

    try:

        db.commit()

    except Exception:

        db.rollback()

        raise HTTPException(
            status_code=500,
            detail="DEVICE_ACTIVATION_FAILED",
        )

    db.refresh(access)

    return {
        "success": True,
        "authorized": True,

        "document_name": document_name,

        "device_id": device.device_id,

        "user_id": user.id,

        "version_code": (
            current_version.version_code
        ),

        "version_label": (
            current_version.version_label
        ),

        "message": (
            "CODE Maths est maintenant activé "
            "sur cet appareil."
        ),
    }


# ==========================================================
# 2. ÉTAT DE L'ACCÈS
# ==========================================================

@router.get("/status/{document_name}")
def get_document_access_status(
    document_name: str,
    x_device_id: str | None = Header(default=None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """
    Vérifie l'autorisation du téléphone actuel.
    """

    document_name = validate_document_name(
        document_name
    )

    if not x_device_id:
        return {
            "authorized": False,
            "reason": "DEVICE_ID_REQUIRED",
            "document_name": document_name,
        }

    x_device_id = x_device_id.strip()

    current_version = get_current_document_version(
        db,
        document_name,
    )

    if not current_version:
        return {
            "authorized": False,
            "reason": "NO_VERSION_AVAILABLE",
            "document_name": document_name,
        }

    # ------------------------------------------------------
    # APPAREIL
    # ------------------------------------------------------

    device = (
        db.query(UserDevice)
        .filter(
            UserDevice.user_id == current_user.id,
            UserDevice.device_id == x_device_id,
            UserDevice.is_active == True,
        )
        .first()
    )

    if not device:

        return {
            "authorized": False,
            "reason": "DEVICE_NOT_AUTHORIZED",
            "document_name": document_name,
            "current_version": (
                current_version.version_code
            ),
            "current_version_label": (
                current_version.version_label
            ),
        }

    # ------------------------------------------------------
    # ACTIVATION
    # ------------------------------------------------------

    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.user_id
            == current_user.id,

            DocumentActivation.document_name
            == document_name,

            DocumentActivation.is_activated
            == True,
        )
        .first()
    )

    if not activation:

        return {
            "authorized": False,
            "reason": "DOCUMENT_NOT_ACTIVATED",
            "document_name": document_name,
        }

    # ------------------------------------------------------
    # ACCÈS
    # ------------------------------------------------------

    access = (
        db.query(DocumentDeviceAccess)
        .filter(
            DocumentDeviceAccess.activation_id
            == activation.id,

            DocumentDeviceAccess.user_id
            == current_user.id,

            DocumentDeviceAccess.device_id
            == device.id,

            DocumentDeviceAccess.is_active
            == True,
        )
        .first()
    )

    if not access:

        return {
            "authorized": False,
            "reason": "DEVICE_ACCESS_NOT_AUTHORIZED",
            "document_name": document_name,
            "current_version": (
                current_version.version_code
            ),
            "current_version_label": (
                current_version.version_label
            ),
        }

    # ------------------------------------------------------
    # PRÉSENCE
    # ------------------------------------------------------

    now = datetime.utcnow()

    device.last_seen = now
    access.last_access = now

    update_available = (
        access.last_version
        < current_version.version_code
    )

    db.commit()

    return {
        "authorized": True,

        "document_name": document_name,

        "current_version": (
            current_version.version_code
        ),

        "current_version_label": (
            current_version.version_label
        ),

        "user_version": (
            access.last_version
        ),

        "update_available": update_available,

        "device_id": device.device_id,
    }


# ==========================================================
# 3. METTRE À JOUR LA VERSION
# ==========================================================

@router.post("/update/{document_name}")
def update_document_version(
    document_name: str,
    x_device_id: str | None = Header(default=None),
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user),
):
    """
    Enregistre que l'utilisateur dispose de la version
    actuelle de CODE Maths.

    Aucun nouvel achat n'est nécessaire.
    """

    document_name = validate_document_name(
        document_name
    )

    if not x_device_id:
        raise HTTPException(
            status_code=400,
            detail="DEVICE_ID_REQUIRED",
        )

    x_device_id = x_device_id.strip()

    current_version = get_current_document_version(
        db,
        document_name,
    )

    if not current_version:
        raise HTTPException(
            status_code=404,
            detail="NO_VERSION_AVAILABLE",
        )

    # ------------------------------------------------------
    # DEVICE
    # ------------------------------------------------------

    device = (
        db.query(UserDevice)
        .filter(
            UserDevice.user_id == current_user.id,
            UserDevice.device_id == x_device_id,
            UserDevice.is_active == True,
        )
        .first()
    )

    if not device:
        raise HTTPException(
            status_code=403,
            detail="DEVICE_NOT_AUTHORIZED",
        )

    # ------------------------------------------------------
    # ACTIVATION
    # ------------------------------------------------------

    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.user_id
            == current_user.id,

            DocumentActivation.document_name
            == document_name,

            DocumentActivation.is_activated
            == True,
        )
        .first()
    )

    if not activation:
        raise HTTPException(
            status_code=403,
            detail="DOCUMENT_NOT_ACTIVATED",
        )

    # ------------------------------------------------------
    # ACCÈS
    # ------------------------------------------------------

    access = (
        db.query(DocumentDeviceAccess)
        .filter(
            DocumentDeviceAccess.activation_id
            == activation.id,

            DocumentDeviceAccess.user_id
            == current_user.id,

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
            detail="DEVICE_ACCESS_NOT_AUTHORIZED",
        )

    # ------------------------------------------------------
    # NOUVELLE VERSION
    # ------------------------------------------------------

    access.last_version = (
        current_version.version_code
    )

    access.last_access = datetime.utcnow()
    device.last_seen = datetime.utcnow()

    try:

        db.commit()

    except Exception:

        db.rollback()

        raise HTTPException(
            status_code=500,
            detail="VERSION_UPDATE_FAILED",
        )

    return {
        "success": True,
        "authorized": True,

        "document_name": document_name,

        "version_code": (
            current_version.version_code
        ),

        "version_label": (
            current_version.version_label
        ),

        "update_available": False,
    }