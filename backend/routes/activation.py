from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

from database import get_db
from models.user import User, UserStatus
from models.document_activation import DocumentActivation


router = APIRouter(
    prefix="/api/activation",
    tags=["activation"]
)


# ==========================================================
# MODÈLES PYDANTIC
# ==========================================================

class ActivationVerifyRequest(BaseModel):
    """
    Première étape :
    l'utilisateur fournit son email et le CODE du document.
    """

    email: EmailStr
    activation_code: str


class CheckUserRequest(BaseModel):
    """
    Vérification de l'existence du compte du bénéficiaire.
    """

    email: EmailStr


class ActivateRequest(BaseModel):
    """
    Données finales nécessaires pour activer le document.
    """

    activation_code: str

    # Email de la personne qui a acheté le document
    buyer_email: EmailStr

    # self = pour soi-même
    # other = pour autrui
    activation_type: str

    # Email de la personne qui bénéficiera du document
    beneficiary_email: EmailStr

    # ------------------------------------------------------
    # Informations utilisées uniquement si le bénéficiaire
    # ne possède pas encore de compte
    # ------------------------------------------------------

    nom: Optional[str] = None
    prenom: Optional[str] = None
    telephone: Optional[str] = None
    pays_residence: Optional[str] = None

    password: Optional[str] = None

    # Date d'achat fournie lors de l'activation
    date_achat: Optional[str] = None


# ==========================================================
# 1. VÉRIFICATION DU CODE ET DE L'EMAIL
# ==========================================================

@router.post("/verify")
def verify_activation(
    data: ActivationVerifyRequest,
    db: Session = Depends(get_db)
):
    """
    Vérifie que :

    - le CODE existe ;
    - le CODE appartient bien à l'email fourni ;
    - le CODE n'a pas déjà été utilisé.

    Cette route NE réalise PAS encore l'activation.
    """

    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.activation_code
            == data.activation_code.strip()
        )
        .first()
    )

    # ------------------------------------------------------
    # CODE inexistant
    # ------------------------------------------------------

    if not activation:
        raise HTTPException(
            status_code=404,
            detail="CODE_DOCUMENT_INVALID"
        )

    # ------------------------------------------------------
    # CODE déjà utilisé
    # ------------------------------------------------------

    if activation.is_activated:
        raise HTTPException(
            status_code=400,
            detail="DOCUMENT_ALREADY_ACTIVATED"
        )

    # ------------------------------------------------------
    # Vérification de l'acheteur
    # ------------------------------------------------------

    if activation.buyer_email:
        if activation.buyer_email.lower() != data.email.lower():
         raise HTTPException(
            status_code=403,
            detail="EMAIL_CODE_MISMATCH"
        )

    # ------------------------------------------------------
    # Tout est correct
    # ------------------------------------------------------

    return {
        "valid": True,
        "message": "CODE vérifié avec succès.",
        "document": {
            "id": activation.id,
            "name": activation.document_name
        },
        "buyer_email": activation.buyer_email
    }


# ==========================================================
# 2. VÉRIFIER SI LE BÉNÉFICIAIRE POSSÈDE DÉJÀ UN COMPTE
# ==========================================================

@router.post("/check-user")
def check_user(
    data: CheckUserRequest,
    db: Session = Depends(get_db)
):
    """
    Vérifie si l'adresse email correspond déjà à un
    utilisateur enregistré dans la base.
    """

    user = (
        db.query(User)
        .filter(
            User.email == data.email
        )
        .first()
    )

    # ------------------------------------------------------
    # Aucun compte
    # ------------------------------------------------------

    if not user:

        return {
            "exists": False,
            "message": "Aucun compte associé à cette adresse email."
        }

    # ------------------------------------------------------
    # Compte trouvé
    # ------------------------------------------------------

    return {
        "exists": True,
        "user": {
            "id": user.id,
            "nom": user.nom,
            "prenom": user.prenom,
            "email": user.email,
            "telephone": user.telephone,
            "sexe": user.sexe,
            "date_naissance": (
                user.date_naissance.isoformat()
                if user.date_naissance
                else None
            ),
            "lieu_naissance": user.lieu_naissance,
            "nationalite": user.nationalite,
            "pays_residence": user.pays_residence
        }
    }


# ==========================================================
# 3. ACTIVATION DU DOCUMENT
# ==========================================================

@router.post("/activate")
def activate_document(
    data: ActivateRequest,
    db: Session = Depends(get_db)
):
    """
    Activation définitive du document.

    Deux possibilités :

    1. Le bénéficiaire possède déjà un compte :
       → on utilise son compte.

    2. Le bénéficiaire ne possède pas de compte :
       → on crée son compte à partir des informations fournies.
    """

    # ======================================================
    # ÉTAPE 1 — RETROUVER LE CODE
    # ======================================================

    activation = (
        db.query(DocumentActivation)
        .filter(
            DocumentActivation.activation_code
            == data.activation_code.strip()
        )
        .first()
    )

    if not activation:
        raise HTTPException(
            status_code=404,
            detail="CODE_DOCUMENT_INVALID"
        )

    # ======================================================
    # ÉTAPE 2 — VÉRIFIER SI LE CODE A DÉJÀ ÉTÉ UTILISÉ
    # ======================================================

    if activation.is_activated:
        raise HTTPException(
            status_code=400,
            detail="DOCUMENT_ALREADY_ACTIVATED"
        )


    # ======================================================
    # ÉTAPE 4 — VÉRIFIER LE TYPE D'ACTIVATION
    # ======================================================

    if data.activation_type not in ["self", "other"]:

        raise HTTPException(
            status_code=400,
            detail="ACTIVATION_TYPE_INVALID"
        )

    # ======================================================
    # ÉTAPE 5 — RECHERCHER LE BÉNÉFICIAIRE
    # ======================================================

    user = (
        db.query(User)
        .filter(
            User.email == data.beneficiary_email
        )
        .first()
    )

    # ======================================================
    # CAS 1 — LE COMPTE EXISTE DÉJÀ
    # ======================================================

    if user:

        # Associer directement le document
        activation.user_id = user.id

    # ======================================================
    # CAS 2 — LE COMPTE N'EXISTE PAS
    # ======================================================

    else:

        # --------------------------------------------------
        # Vérification des informations obligatoires
        # --------------------------------------------------

        if not data.nom:
            raise HTTPException(
                status_code=400,
                detail="NOM_REQUIRED"
            )

        if not data.prenom:
            raise HTTPException(
                status_code=400,
                detail="PRENOM_REQUIRED"
            )

        # --------------------------------------------------
        # Création du nouvel utilisateur
        # --------------------------------------------------

        user = User(
            nom=data.nom,
            prenom=data.prenom,
            email=data.beneficiary_email,
            telephone=data.telephone,
            pays_residence=data.pays_residence,

            # Le compte créé par activation ne possède
            # pas encore de mot de passe.
            #
            # Cette partie devra être réglée selon le
            # mécanisme de connexion que nous choisirons.
            hashed_password= "",

            is_validated=True,
            is_active=True,
            is_blocked=False,
            is_admin=False,
            is_verified=False,

            status=UserStatus.VALIDATED.value,

            date_inscription=datetime.utcnow(),
            created_at=datetime.utcnow()
        )

        db.add(user)
        db.flush()

        activation.user_id = user.id

    # ======================================================
    # ÉTAPE 6 — ENREGISTRER LES INFORMATIONS D'ACTIVATION
    # ======================================================

    activation.activation_type = data.activation_type
    activation.beneficiary_email = data.beneficiary_email
    activation.is_activated = True
    activation.activated_at = datetime.utcnow()

    # ======================================================
    # ÉTAPE 7 — ENREGISTRER
    # ======================================================

    db.commit()

    db.refresh(activation)

    # ======================================================
    # RÉPONSE
    # ======================================================

    return {
        "success": True,
        "message": "Document activé avec succès.",
        "activation": {
            "id": activation.id,
            "document_name": activation.document_name,
            "activation_code": activation.activation_code,
            "activated_at": (
                activation.activated_at.isoformat()
                if activation.activated_at
                else None
            )
        },
        "user": {
            "id": user.id,
            "nom": user.nom,
            "prenom": user.prenom,
            "email": user.email
        }
    }