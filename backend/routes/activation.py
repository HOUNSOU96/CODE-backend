from fastapi import (

    APIRouter,

    Depends,

    HTTPException,

    File,

    Form,

    UploadFile,

)



from sqlalchemy.orm import Session, defer

from sqlalchemy import func



from pydantic import BaseModel, EmailStr



from typing import Optional

from datetime import datetime



from pathlib import Path

import os

import tempfile


import shutil

import logging

import re

import time

import httpx


from database import get_db

from models.user import User, UserStatus

from models.document_activation import DocumentActivation

from models.user_device import UserDevice

from models.document_device_access import DocumentDeviceAccess



from utils.hashing import hash_password





# ==========================================================

# ROUTER

# ==========================================================



router = APIRouter(

    prefix="/api/activation",

    tags=["activation"],

)





# ==========================================================

# LOGGING

# ==========================================================



logger = logging.getLogger(__name__)





# ==========================================================

# CHEMIN DU PROJET

# ==========================================================



BACKEND_DIR = Path(__file__).resolve().parent.parent


# ============================================================
# SERVICE DE GÉNÉRATION DES DOCUMENTS
# ============================================================

CODE_DOCUMENTS_URL = os.getenv(
    "CODE_DOCUMENTS_URL",
    "",
).rstrip("/")

CODE_DOCUMENTS_SERVICE_KEY = os.getenv(
    "CODE_DOCUMENTS_SERVICE_KEY",
)

CODE_DOCUMENTS_TIMEOUT_SECONDS = int(
    os.getenv(
        "CODE_DOCUMENTS_TIMEOUT_SECONDS",
        "660",
    )
)



# ============================================================

# STOCKAGE SÉCURISÉ DES PDF PERSONNALISÉS

# ============================================================



SECURE_DOCUMENTS_DIR = (

    BACKEND_DIR / "secure_documents"

)



SECURE_DOCUMENTS_DIR.mkdir(

    parents=True,

    exist_ok=True,

)





# ============================================================

# REGISTRE DES MODÈLES PDF DES DOCUMENTS

# ============================================================



DOCUMENT_TEMPLATES = {
    "CODE Maths 1er cycle Tome I": {
        "type": "documents_service",
    },
}





# ============================================================

# NOM DE FICHIER PDF

# ============================================================



def safe_filename_part(value: str) -> str:

    """

    Transforme le nom du document en partie de nom de fichier

    sûre pour le stockage du PDF.

    """



    value = re.sub(

        r"[^\w\s-]",

        "",

        value,

        flags=re.UNICODE,

    )



    value = re.sub(

        r"\s+",

        "-",

        value.strip(),

    )



    return value or "document"





# ==========================================================

# LIMITES PHOTO

# ==========================================================



MAX_PHOTO_SIZE = 5 * 1024 * 1024  # 5 Mo



ALLOWED_PHOTO_TYPES = {

    "image/jpeg": ".jpg",

    "image/png": ".png",

}





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





# ==========================================================

# 1. VÉRIFICATION DU CODE ET DE L'EMAIL

# ==========================================================



@router.post("/verify")

def verify_activation(

    data: ActivationVerifyRequest,

    db: Session = Depends(get_db),

):

    """

    Vérifie que :



    - le CODE existe ;

    - le CODE appartient bien à l'email fourni ;

    - le CODE n'a pas déjà été utilisé.



    Cette route ne réalise PAS encore l'activation.

    """



    activation_code = data.activation_code.strip()



    logger.info(

        "🔎 VERIFY — requête reçue | code_present=%s",

        bool(activation_code),

    )



    if not activation_code:

        logger.warning(

            "❌ VERIFY — code vide"

        )



        raise HTTPException(

            status_code=400,

            detail="CODE_DOCUMENT_INVALID",

        )



    logger.info(

        "🔵 VERIFY — recherche du code en base"

    )



    activation = (

    db.query(DocumentActivation)

    .options(

        defer(DocumentActivation.pdf_data)

    )

    .filter(

        DocumentActivation.activation_code

        == activation_code

    )

    .first()

)



    if not activation:

        logger.warning(

            "❌ VERIFY — code introuvable"

        )



        raise HTTPException(

            status_code=404,

            detail="CODE_DOCUMENT_INVALID",

        )



    logger.info(

        "🟢 VERIFY — code trouvé | "

        "activation_id=%s | document=%s | activated=%s",

        activation.id,

        activation.document_name,

        activation.is_activated,

    )



    if activation.is_activated:

        logger.warning(

            "❌ VERIFY — document déjà activé | "

            "activation_id=%s",

            activation.id,

        )



        raise HTTPException(

            status_code=400,

            detail="DOCUMENT_ALREADY_ACTIVATED",

        )



    if activation.buyer_email:



        buyer_email = (

            activation.buyer_email

            .strip()

            .lower()

        )



        provided_email = (

            str(data.email)

            .strip()

            .lower()

        )



        logger.info(

            "🔵 VERIFY — comparaison emails | "

            "activation_id=%s",

            activation.id,

        )



        if buyer_email != provided_email:



            logger.warning(

                "❌ VERIFY — email/code incompatibles | "

                "activation_id=%s",

                activation.id,

            )



            raise HTTPException(

                status_code=403,

                detail="EMAIL_CODE_MISMATCH",

            )



    logger.info(

        "🟢 VERIFY — vérification réussie | "

        "activation_id=%s",

        activation.id,

    )



    return {

        "valid": True,

        "message": "CODE vérifié avec succès.",

        "document": {

            "id": activation.id,

            "name": activation.document_name,

        },

        "buyer_email": activation.buyer_email,

    }





# ==========================================================

# 2. VÉRIFIER SI LE BÉNÉFICIAIRE POSSÈDE DÉJÀ UN COMPTE

# ==========================================================



@router.post("/check-user")

def check_user(

    data: CheckUserRequest,

    db: Session = Depends(get_db),

):

    """

    Vérifie si l'adresse email correspond déjà à un

    utilisateur enregistré dans la base.

    """



    email = (

        str(data.email)

        .strip()

        .lower()

    )



    print("")

    print("==========================================================")

    print("🔎 CHECK-USER — REQUÊTE REÇUE")

    print("📧 Email reçu :", email)

    print("==========================================================")



    logger.info(

        "🔎 CHECK-USER — requête reçue | email=%s",

        email,

    )



    print(

        "⏳ CHECK-USER — début de la recherche SQL..."

    )



    logger.info(

        "⏳ CHECK-USER — exécution recherche SQL | email=%s",

        email,

    )



    try:



        user = (

            db.query(User)

            .filter(

                func.lower(User.email) == email

            )

            .first()

        )



    except Exception as e:



        print("")

        print("❌❌❌ CHECK-USER — ERREUR SQL ❌❌❌")

        print("📧 Email :", email)

        print("⚠️ Type :", type(e).__name__)

        print("⚠️ Erreur :", repr(e))

        print("==========================================================")



        logger.exception(

            "❌ CHECK-USER — erreur SQL | email=%s",

            email,

        )



        raise



    print("")

    print("✅ CHECK-USER — recherche SQL TERMINÉE")

    print(

        "👤 Utilisateur trouvé :",

        bool(user),

    )



    logger.info(

        "✅ CHECK-USER — recherche SQL terminée | trouvé=%s",

        bool(user),

    )



    if not user:



        print("")

        print("❌ CHECK-USER — AUCUN COMPTE TROUVÉ")

        print("📧 Email recherché :", email)

        print("==========================================================")



        logger.info(

            "❌ CHECK-USER — aucun compte trouvé | email=%s",

            email,

        )



        return {

            "exists": False,

            "message": (

                "Aucun compte associé à cette "

                "adresse email."

            ),

        }



    print("")

    print("✅ CHECK-USER — UTILISATEUR TROUVÉ")

    print("🆔 ID :", user.id)

    print("📧 Email :", user.email)

    print("👤 Nom :", user.nom)

    print("👤 Prénom :", user.prenom)

    print("==========================================================")



    logger.info(

        "✅ CHECK-USER — utilisateur trouvé | "

        "id=%s | email=%s | nom=%s | prenom=%s",

        user.id,

        user.email,

        user.nom,

        user.prenom,

    )



    response = {

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

            "pays_residence": user.pays_residence,

        },

    }



    print(

        "📤 CHECK-USER — réponse envoyée au frontend"

    )



    logger.info(

        "📤 CHECK-USER — réponse envoyée | user_id=%s",

        user.id,

    )



    return response





# ==========================================================

# 3. ACTIVATION + GÉNÉRATION DU PDF

# ==========================================================



@router.post("/activate")

async def activate_document(



    activation_code: str = Form(...),



    buyer_email: EmailStr = Form(...),



    activation_type: str = Form(...),



    beneficiary_email: EmailStr = Form(...),



    device_id: Optional[str] = Form(None),



    device_type: Optional[str] = Form("unknown"),



    nom: Optional[str] = Form(None),



    prenom: Optional[str] = Form(None),



    telephone: Optional[str] = Form(None),



    pays_residence: Optional[str] = Form(None),



    password: Optional[str] = Form(None),



    etablissement: Optional[str] = Form(None),



    ville: Optional[str] = Form(None),



    annee_scolaire: Optional[str] = Form(None),



    photo: Optional[UploadFile] = File(None),



    date_achat: Optional[str] = Form(None),



    db: Session = Depends(get_db),

):

    """

    Activation définitive du document.



    Le PDF est généré côté serveur puis stocké dans le

    dossier sécurisé. Le PDF n'est jamais retourné directement

    au navigateur.

    """



    # ======================================================

    # LOG — ENTRÉE BRUTE DE LA REQUÊTE

    # ======================================================



    logger.info(

        "🚀 ACTIVATION — requête reçue | "

        "activation_type=%s | "

        "device_type=%s | "

        "device_id_present=%s | "

        "photo_present=%s",

        activation_type,

        device_type,

        bool(device_id),

        bool(photo),

    )



    # ======================================================

    # NORMALISATION

    # ======================================================



    activation_code = activation_code.strip()



    buyer_email_value = (

        str(buyer_email)

        .strip()

        .lower()

    )



    beneficiary_email_value = (

        str(beneficiary_email)

        .strip()

        .lower()

    )



    activation_type = activation_type.strip()



    device_id_value = (

        device_id.strip()

        if device_id

        else ""

    )



    device_type_value = (

        device_type.strip().lower()

        if device_type

        else "unknown"

    )



    nom_value = (

        nom.strip()

        if nom

        else ""

    )



    prenom_value = (

        prenom.strip()

        if prenom

        else ""

    )



    telephone_value = (

        telephone.strip()

        if telephone

        else ""

    )



    pays_value = (

        pays_residence.strip()

        if pays_residence

        else ""

    )



    etablissement_value = (

        etablissement.strip()

        if etablissement

        else ""

    )



    ville_value = (

        ville.strip()

        if ville

        else ""

    )



    annee_scolaire_value = (

        annee_scolaire.strip()

        if annee_scolaire

        else ""

    )



    logger.info(

        "🔵 ACTIVATION — données normalisées | "

        "buyer=%s | beneficiary=%s | "

        "type=%s | device_type=%s | "

        "device_id_length=%s",

        buyer_email_value,

        beneficiary_email_value,

        activation_type,

        device_type_value,

        len(device_id_value),

    )



    # ======================================================

    # VALIDATIONS

    # ======================================================



    if not activation_code:



        logger.warning(

            "❌ ACTIVATION — code vide"

        )



        raise HTTPException(

            status_code=400,

            detail="CODE_DOCUMENT_INVALID",

        )



    if not device_id_value:



        logger.warning(

            "❌ ACTIVATION — device_id absent"

        )



        raise HTTPException(

            status_code=400,

            detail="DEVICE_ID_REQUIRED",

        )



    if len(device_id_value) > 255:



        logger.warning(

            "❌ ACTIVATION — device_id trop long | length=%s",

            len(device_id_value),

        )



        raise HTTPException(

            status_code=400,

            detail="DEVICE_ID_INVALID",

        )



    if activation_type not in [

        "self",

        "other",

    ]:



        logger.warning(

            "❌ ACTIVATION — type invalide | type=%s",

            activation_type,

        )



        raise HTTPException(

            status_code=400,

            detail="ACTIVATION_TYPE_INVALID",

        )



    if activation_type == "self":



        if beneficiary_email_value != buyer_email_value:



            logger.warning(

                "❌ ACTIVATION — self activation : "

                "emails différents"

            )



            raise HTTPException(

                status_code=400,

                detail="SELF_ACTIVATION_EMAIL_MISMATCH",

            )



    # ======================================================

    # VARIABLES DE TRANSACTION

    # ======================================================



    temporary_directory = None



    secure_pdf_path = None



    transaction_committed = False



    # ======================================================

    # TRY PRINCIPAL

    # ======================================================



    try:



        # ==================================================

        # ÉTAPE 1 — VERROUILLAGE + RECHERCHE DU CODE

        # ==================================================



        logger.info(

            "🔵 ACTIVATION — recherche du code | code_present=%s",

            bool(activation_code),

        )



        activation = (

            db.query(DocumentActivation)

            .options(

                defer(DocumentActivation.pdf_data)

            )

            .filter(

                DocumentActivation.activation_code

                == activation_code

            )

            .first()

        )



        if not activation:



            logger.warning(

                "❌ ACTIVATION — code introuvable"

            )



            raise HTTPException(

                status_code=404,

                detail="CODE_DOCUMENT_INVALID",

            )



        logger.info(

            "🔵 ACTIVATION — code trouvé | "

            "activation_id=%s | document=%s | is_activated=%s",

            activation.id,

            activation.document_name,

            activation.is_activated,

        )



        document_name = activation.document_name



        # ==================================================

        # ÉTAPE 2 — CODE DÉJÀ UTILISÉ

        # ==================================================



        if activation.is_activated:



            logger.warning(

                "❌ ACTIVATION — document déjà activé | "

                "activation_id=%s",

                activation.id,

            )



            raise HTTPException(

                status_code=400,

                detail="DOCUMENT_ALREADY_ACTIVATED",

            )



        # ==================================================

        # ÉTAPE 3 — VÉRIFICATION ACHETEUR

        # ==================================================



        if activation.buyer_email:



            stored_buyer_email = (

                activation.buyer_email

                .strip()

                .lower()

            )



            if stored_buyer_email != buyer_email_value:



                logger.warning(

                    "❌ ACTIVATION — email acheteur incorrect | "

                    "activation_id=%s",

                    activation.id,

                )



                raise HTTPException(

                    status_code=403,

                    detail="EMAIL_CODE_MISMATCH",

                )



        logger.info(

            "🟢 ACTIVATION — email acheteur vérifié | "

            "activation_id=%s",

            activation.id,

        )



        # ==================================================

        # ÉTAPE 4 — RECHERCHE BÉNÉFICIAIRE

        # ==================================================



        logger.info(

            "🔵 ACTIVATION — AVANT requête SQL bénéficiaire | "

            "email=%s",

            beneficiary_email_value,

        )



        user = (

            db.query(User)

            .filter(

                func.lower(User.email)

                == beneficiary_email_value

            )

            .first()

        )



        logger.info(

            "🟢 ACTIVATION — APRÈS requête SQL bénéficiaire | "

            "email=%s | trouvé=%s",

            beneficiary_email_value,

            bool(user),

        )



        # ==================================================

        # ==================================================
        # COMPTE EXISTANT / NOUVEAU COMPTE
        # ==================================================

        # IMPORTANT :
        # Aucun utilisateur n'est créé/modifié définitivement
        # avant la génération du PDF. La transaction DB sera
        # libérée avant le traitement PDF, puis reprise dans
        # une transaction courte après génération.

        if user:

            logger.info(
                "🟢 ACTIVATION — compte existant | "
                "user_id=%s | email=%s",
                user.id,
                user.email,
            )

            document_nom = (
                nom_value
                or user.nom
                or ""
            )

            document_prenom = (
                prenom_value
                or user.prenom
                or ""
            )

            document_pays = (
                pays_value
                or user.pays_residence
                or ""
            )

        else:

            logger.info(
                "🔵 ACTIVATION — nouveau compte à créer après génération PDF | "
                "email=%s",
                beneficiary_email_value,
            )

            if not nom_value:
                raise HTTPException(
                    status_code=400,
                    detail="NOM_REQUIRED",
                )

            if not prenom_value:
                raise HTTPException(
                    status_code=400,
                    detail="PRENOM_REQUIRED",
                )

            if not pays_value:
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

            document_nom = nom_value
            document_prenom = prenom_value
            document_pays = pays_value

        # Capture des valeurs simples avant rollback.
        activation_id = activation.id
        activation_code_value = activation.activation_code
        document_name = activation.document_name

        logger.info(
            "🟢 ACTIVATION — bénéficiaire prêt pour génération PDF | "
            "user_exists=%s | activation_id=%s",
            bool(user),
            activation_id,
        )

        # ==================================================
        # LIBÉRATION DE LA TRANSACTION AVANT GÉNÉRATION DU PDF
        # ==================================================

        logger.info(
            "🔓 ACTIVATION — libération de la transaction DB "
            "avant génération PDF | activation_id=%s",
            activation_id,
        )

        db.rollback()

        logger.info(
            "🟢 ACTIVATION — transaction DB libérée avant CODE_Documents | "
            "activation_id=%s",
            activation_id,
        )

        # ÉTAPE 5 — MODÈLE PDF

        # ==================================================



        logger.info(

            "🔵 ACTIVATION — recherche configuration document | "

            "document='%s'",

            document_name,

        )



        document_config = DOCUMENT_TEMPLATES.get(document_name)

        if not document_config:
            raise HTTPException(
                status_code=400,
                detail="DOCUMENT_PDF_NOT_CONFIGURED",
            )

        logger.info(
            "🟢 ACTIVATION — configuration trouvée | type=%s",
            document_config["type"],
        )

        if document_config["type"] != "documents_service":
            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_GENERATOR_NOT_SUPPORTED",
            )



            raise HTTPException(

                status_code=500,

                detail="DOCUMENT_GENERATOR_NOT_SUPPORTED",

            )



        # ==================================================
        # ÉTAPE 6 — SERVICE DE DOCUMENTS
        # ==================================================

        logger.info(
            "ACTIVATION — génération externalisée vers "
            "CODE_Documents | document=%s",
            document_name,
        )

        # ==================================================
        # ÉTAPE 7 — PRÉPARATION DU SERVICE DOCUMENTS
        # ==================================================

        if not CODE_DOCUMENTS_URL:
            logger.error(
                "❌ ACTIVATION — CODE_DOCUMENTS_URL non configurée"
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_SERVICE_URL_NOT_CONFIGURED",
            )

        if not CODE_DOCUMENTS_SERVICE_KEY:
            logger.error(
                "❌ ACTIVATION — CODE_DOCUMENTS_SERVICE_KEY "
                "non configurée"
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_SERVICE_KEY_NOT_CONFIGURED",
            )

        temporary_root = (
            BACKEND_DIR / "tmp"
        )

        temporary_root.mkdir(
            parents=True,
            exist_ok=True,
        )

        temporary_directory = Path(
            tempfile.mkdtemp(
                prefix="document_activation_",
                dir=str(temporary_root),
            )
        )

        document_filename = (
            safe_filename_part(
                document_name
            )
            + "-personnalise.pdf"
        )

        pdf_path = (
            temporary_directory
            / document_filename
        )

        logger.info(
            "🟢 ACTIVATION — dossier temporaire backend créé | "
            "directory=%s | pdf=%s",
            temporary_directory,
            pdf_path,
        )

        # ==================================================
        # ÉTAPE 8 — PHOTO
        # ==================================================

        photo_content = None
        photo_content_type = None
        photo_filename = "photo"

        if photo:

            logger.info(
                "📷 ACTIVATION — photo reçue | "
                "filename=%s | content_type=%s",
                photo.filename,
                photo.content_type,
            )

            if photo.content_type not in ALLOWED_PHOTO_TYPES:

                logger.warning(
                    "❌ ACTIVATION — format photo invalide | "
                    "content_type=%s",
                    photo.content_type,
                )

                raise HTTPException(
                    status_code=400,
                    detail="PHOTO_FORMAT_INVALID",
                )

            photo_content = await photo.read()

            logger.info(
                "📷 ACTIVATION — photo lue | taille=%s octets",
                len(photo_content),
            )

            if len(photo_content) > MAX_PHOTO_SIZE:

                logger.warning(
                    "❌ ACTIVATION — photo trop volumineuse | "
                    "taille=%s",
                    len(photo_content),
                )

                raise HTTPException(
                    status_code=400,
                    detail="PHOTO_TOO_LARGE",
                )

            photo_content_type = photo.content_type

            extension = ALLOWED_PHOTO_TYPES[
                photo.content_type
            ]

            photo_filename = f"photo{extension}"

        else:

            logger.info(
                "📷 ACTIVATION — aucune photo fournie"
            )

        # ==================================================
        # ÉTAPE 9 — APPEL DU SERVICE CODE_DOCUMENTS
        # ==================================================

        service_url = (
            f"{CODE_DOCUMENTS_URL}/generate"
        )

        service_headers = {
            "X-CODE-SERVICE-KEY":
                CODE_DOCUMENTS_SERVICE_KEY,
        }

        service_data = {
            "nom": document_nom,
            "prenom": document_prenom,
            "pays": document_pays,
            "etablissement": etablissement_value,
            "ville": ville_value,
            "annee_scolaire": annee_scolaire_value,
            "code": activation_code_value,
        }

        service_files = None

        if photo_content is not None:

            service_files = {
                "photo": (
                    photo_filename,
                    photo_content,
                    photo_content_type,
                ),
            }

        logger.info(
            "🔵 ACTIVATION — appel CODE_Documents | "
            "url=%s | activation_id=%s",
            service_url,
            activation_id,
        )

        pdf_start_time = time.monotonic()

        try:

            timeout = httpx.Timeout(
                CODE_DOCUMENTS_TIMEOUT_SECONDS,
                connect=30.0,
            )

            async with httpx.AsyncClient(
                timeout=timeout
            ) as client:

                response = await client.post(
                    service_url,
                    headers=service_headers,
                    data=service_data,
                    files=service_files,
                )

            pdf_duration = (
                time.monotonic()
                - pdf_start_time
            )

            logger.info(
                "🟢 ACTIVATION — réponse CODE_Documents | "
                "status=%s | durée=%.3f secondes | "
                "content_type=%s | taille=%s",
                response.status_code,
                pdf_duration,
                response.headers.get(
                    "content-type"
                ),
                len(response.content),
            )

        except httpx.TimeoutException:

            logger.exception(
                "❌ ACTIVATION — timeout CODE_Documents | "
                "timeout=%s secondes | activation_id=%s",
                CODE_DOCUMENTS_TIMEOUT_SECONDS,
                activation_id,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_TIMEOUT",
            )

        except httpx.RequestError:

            logger.exception(
                "❌ ACTIVATION — impossible de joindre "
                "CODE_Documents | url=%s | activation_id=%s",
                service_url,
                activation_id,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_SERVICE_UNAVAILABLE",
            )

        # ==================================================
        # VÉRIFICATION DE LA RÉPONSE
        # ==================================================

        if response.status_code != 200:

            logger.error(
                "❌ ACTIVATION — CODE_Documents a refusé "
                "la génération | status=%s | body=%s",
                response.status_code,
                response.text[-5000:],
            )

            db.rollback()

            if response.status_code == 401:
                detail = "DOCUMENT_SERVICE_UNAUTHORIZED"

            elif response.status_code == 403:
                detail = "DOCUMENT_SERVICE_FORBIDDEN"

            elif response.status_code == 400:
                detail = "PDF_GENERATION_INVALID_REQUEST"

            else:
                detail = "PDF_GENERATION_FAILED"

            raise HTTPException(
                status_code=500,
                detail=detail,
            )

        content_type = (
            response.headers.get(
                "content-type",
                "",
            ).lower()
        )

        if "application/pdf" not in content_type:

            logger.error(
                "❌ ACTIVATION — CODE_Documents "
                "n'a pas retourné un PDF | "
                "content_type=%s",
                content_type,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_INVALID_RESPONSE",
            )

        # ==================================================
        # ÉTAPE 10 — ENREGISTREMENT DU PDF REÇU
        # ==================================================

        try:

            pdf_path.write_bytes(
                response.content
            )

        except Exception:

            logger.exception(
                "❌ ACTIVATION — impossible "
                "d'enregistrer le PDF reçu"
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_TEMPORARY_STORAGE_FAILED",
            )

        logger.info(
            "🔵 ACTIVATION — PDF reçu | "
            "path=%s | exists=%s",
            pdf_path,
            pdf_path.exists(),
        )

        if not pdf_path.exists():

            logger.error(
                "❌ ACTIVATION — PDF absent après "
                "réception du service"
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_NOT_GENERATED",
            )

        pdf_size = pdf_path.stat().st_size

        logger.info(
            "🟢 ACTIVATION — PDF généré par "
            "CODE_Documents | taille=%s octets",
            pdf_size,
        )

        if pdf_size == 0:

            logger.error(
                "❌ ACTIVATION — PDF vide"
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_EMPTY",
            )

        # ÉTAPE 11 — TRANSACTION FINALE + STOCKAGE SÉCURISÉ
        # ==================================================

        logger.info(
            "🔵 DB DEBUG — reprise transaction finale | "
            "activation_id=%s",
            activation_id,
        )

        # Nouveau verrou : il est pris seulement maintenant,
        # après la génération Typst.
        activation = (
            db.query(DocumentActivation)
            .options(
                defer(DocumentActivation.pdf_data)
            )
            .filter(
                DocumentActivation.id == activation_id
            )
            .with_for_update()
            .first()
        )

        if not activation:

            logger.error(
                "❌ ACTIVATION — activation introuvable lors "
                "de la transaction finale | activation_id=%s",
                activation_id,
            )

            raise HTTPException(
                status_code=404,
                detail="CODE_DOCUMENT_INVALID",
            )

        logger.info(
            "🟢 DB DEBUG — verrou final obtenu | "
            "activation_id=%s | is_activated=%s",
            activation.id,
            activation.is_activated,
        )

        if activation.is_activated:

            logger.warning(
                "❌ ACTIVATION — document activé entre-temps | "
                "activation_id=%s",
                activation.id,
            )

            raise HTTPException(
                status_code=400,
                detail="DOCUMENT_ALREADY_ACTIVATED",
            )

        # --------------------------------------------------
        # RECHERCHE / CRÉATION FINALE DU BÉNÉFICIAIRE
        # --------------------------------------------------

        logger.info(
            "🔵 ACTIVATION — recherche finale du bénéficiaire | "
            "email=%s",
            beneficiary_email_value,
        )

        user = (
            db.query(User)
            .filter(
                func.lower(User.email)
                == beneficiary_email_value
            )
            .first()
        )

        if user:

            logger.info(
                "🟢 ACTIVATION — utilisateur existant confirmé | "
                "user_id=%s | email=%s",
                user.id,
                user.email,
            )

            activation.user_id = user.id

        else:

            logger.info(
                "🔵 ACTIVATION — création finale du nouveau compte | "
                "email=%s",
                beneficiary_email_value,
            )

            if not nom_value:
                raise HTTPException(
                    status_code=400,
                    detail="NOM_REQUIRED",
                )

            if not prenom_value:
                raise HTTPException(
                    status_code=400,
                    detail="PRENOM_REQUIRED",
                )

            if not pays_value:
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

            hashed_password = hash_password(
                password
            )

            user = User(
                nom=nom_value,
                prenom=prenom_value,
                email=beneficiary_email_value,
                telephone=(
                    telephone_value
                    if telephone_value
                    else None
                ),
                pays_residence=pays_value,
                hashed_password=hashed_password,
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

            logger.info(
                "🔵 ACTIVATION — flush nouveau User final"
            )

            db.flush()

            logger.info(
                "🟢 ACTIVATION — nouveau compte créé | "
                "user_id=%s | email=%s",
                user.id,
                user.email,
            )

            activation.user_id = user.id

        # --------------------------------------------------
        # STOCKAGE SÉCURISÉ
        # --------------------------------------------------
        #
        # Le PDF n'est copié vers son emplacement définitif
        # qu'après obtention du verrou final. Cela évite qu'une
        # tentative concurrente puisse supprimer le PDF d'une
        # activation déjà validée.

        secure_document_directory = (
            SECURE_DOCUMENTS_DIR
            / str(activation.id)
        )

        logger.info(
            "🔵 ACTIVATION — création dossier sécurisé | "
            "directory=%s",
            secure_document_directory,
        )

        secure_document_directory.mkdir(
            parents=True,
            exist_ok=True,
        )

        secure_pdf_path = (
            secure_document_directory
            / document_filename
        )

        logger.info(
            "🔵 ACTIVATION — copie PDF sécurisé | "
            "source=%s | destination=%s",
            pdf_path,
            secure_pdf_path,
        )

        try:

            shutil.copy2(
                pdf_path,
                secure_pdf_path,
            )

        except Exception:

            logger.exception(
                "❌ ACTIVATION — erreur copie PDF sécurisé"
            )

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_STORAGE_FAILED",
            )

        logger.info(
            "🟢 ACTIVATION — copie PDF terminée | "
            "exists=%s",
            secure_pdf_path.exists(),
        )

        if not secure_pdf_path.exists():

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_NOT_FOUND",
            )

        if not secure_pdf_path.is_file():

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_INVALID",
            )

        secure_pdf_size = (
            secure_pdf_path.stat().st_size
        )

        logger.info(
            "🔵 ACTIVATION — taille PDF sécurisé=%s octets",
            secure_pdf_size,
        )

        if secure_pdf_size == 0:

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_EMPTY",
            )

        activation.pdf_path = str(
            secure_pdf_path.relative_to(
                BACKEND_DIR
            )
        )

        activation.pdf_data = None

        activation.pdf_filename = (
            document_filename
        )

        activation.activation_type = (
            activation_type
        )

        activation.beneficiary_email = (
            beneficiary_email_value
        )

        activation.is_activated = True

        activation.activated_at = (
            datetime.utcnow()
        )

        logger.info(
            "🟢 ACTIVATION — données activation préparées | "
            "activation_id=%s | user_id=%s | "
            "pdf_path=%s",
            activation.id,
            user.id,
            activation.pdf_path,
        )

        # ÉTAPE 12 — DEVICE

        # ==================================================



        now = datetime.utcnow()



        logger.info(

            "🔵 DEVICE DEBUG — AVANT recherche device | "

            "device_id_present=%s | device_type=%s",

            bool(device_id_value),

            device_type_value,

        )



        device = (

            db.query(UserDevice)

            .filter(

                UserDevice.device_id

                == device_id_value

            )

            .first()

        )



        logger.info(

            "🔵 DEVICE DEBUG — APRÈS recherche device | "

            "trouvé=%s",

            bool(device),

        )



        if not device:



            device = UserDevice(

                user_id=user.id,

                device_id=device_id_value,

                device_type=device_type_value,

                is_mobile=(

                    device_type_value

                    in ["mobile", "tablet"]

                ),

                is_active=True,

                created_at=now,

                last_seen=now,

            )



            db.add(device)



            logger.info(

                "🔵 DEVICE DEBUG — flush nouveau device"

            )



            db.flush()



            logger.info(

                "🟢 DEVICE DEBUG — nouveau device enregistré | "

                "device_db_id=%s | user_id=%s",

                device.id,

                user.id,

            )



        else:



            logger.info(

                "🟢 DEVICE DEBUG — device existant | "

                "device_db_id=%s | device_user_id=%s",

                device.id,

                device.user_id,

            )



            if device.user_id != user.id:



                logger.warning(

                    "❌ DEVICE_ALREADY_ASSOCIATED | "

                    "device_user=%s | requested_user=%s",

                    device.user_id,

                    user.id,

                )



                db.rollback()



                raise HTTPException(

                    status_code=409,

                    detail="DEVICE_ALREADY_ASSOCIATED",

                )



            device.is_active = True



            device.last_seen = now



            if device_type_value:



                device.device_type = (

                    device_type_value

                )



            device.is_mobile = (

                device_type_value

                in ["mobile", "tablet"]

            )



            logger.info(

                "🟢 DEVICE DEBUG — device mis à jour | "

                "device_db_id=%s",

                device.id,

            )



        # ==================================================

        # ÉTAPE 13 — ACCÈS DOCUMENT

        # ==================================================



        logger.info(

            "🔵 ACCESS DEBUG — recherche accès | "

            "activation_id=%s | device_id=%s",

            activation.id,

            device.id,

        )



        document_access = (

            db.query(DocumentDeviceAccess)

            .filter(

                DocumentDeviceAccess.activation_id

                == activation.id,

                DocumentDeviceAccess.device_id

                == device.id,

            )

            .first()

        )



        logger.info(

            "🔵 ACCESS DEBUG — résultat recherche | "

            "found=%s",

            bool(document_access),

        )



        if not document_access:



            document_access = DocumentDeviceAccess(

                activation_id=activation.id,

                user_id=user.id,

                device_id=device.id,

                is_active=True,

                activated_at=now,

                last_access=now,

                last_version=1,

            )



            db.add(document_access)



            logger.info(

                "🟢 ACCESS DEBUG — nouvel accès créé"

            )



        else:



            document_access.user_id = user.id



            document_access.is_active = True



            document_access.last_access = now



            document_access.last_version = 1



            logger.info(

                "🟢 ACCESS DEBUG — accès existant mis à jour | "

                "access_id=%s",

                document_access.id,

            )



        # ==================================================

        # ÉTAPE 14 — COMMIT

        # ==================================================



        logger.info(

            "🚨 DB DEBUG — AVANT db.commit() | "

            "activation_id=%s | user_id=%s | "

            "device_id=%s",

            activation.id,

            user.id,

            device.id,

        )



        db.commit()



        transaction_committed = True



        logger.info(

            "🚨 DB DEBUG — APRÈS db.commit() | "

            "activation_id=%s",

            activation.id,

        )



        # ==================================================

        # REFRESH

        # ==================================================



        logger.info(

            "🔵 DB DEBUG — refresh activation"

        )



        db.refresh(activation)



        logger.info(

            "🔵 DB DEBUG — refresh device"

        )



        db.refresh(device)



        logger.info(

            "🟢 DB DEBUG — refresh terminé"

        )



        # ==================================================

        # RÉPONSE

        # ==================================================



        response = {

            "success": True,

            "message": (

                "Document activé avec succès. "

                "Votre document est disponible dans "

                "« Mes documents »."

            ),

            "activation_id": activation.id,

            "document": {

                "id": activation.id,

                "name": activation.document_name,

            },

        }



        logger.info(

            "📤 ACTIVATION — réponse JSON prête | "

            "activation_id=%s",

            activation.id,

        )



        logger.info(

            "🟢 ACTIVATION — SUCCÈS COMPLET | "

            "activation_id=%s | user_id=%s | device_id=%s",

            activation.id,

            user.id,

            device.id,

        )



        return response



    # ======================================================

    # ERREUR HTTP

    # ======================================================



    except HTTPException as exc:



        logger.warning(

            "⚠️ ACTIVATION — HTTPException | "

            "status=%s | detail=%s",

            exc.status_code,

            exc.detail,

        )



        try:

            db.rollback()



            logger.info(

                "🔄 ACTIVATION — rollback effectué après HTTPException"

            )



        except Exception:



            logger.exception(

                "❌ ACTIVATION — erreur pendant rollback"

            )



        raise



    # ======================================================

    # ERREUR INATTENDUE

    # ======================================================



    except Exception:



        logger.exception(

            "❌❌❌ ACTIVATION — ERREUR INATTENDUE ❌❌❌"

        )



        try:



            db.rollback()



            logger.info(

                "🔄 ACTIVATION — rollback effectué après erreur"

            )



        except Exception:



            logger.exception(

                "❌ ACTIVATION — erreur pendant rollback"

            )



        raise HTTPException(

            status_code=500,

            detail="ACTIVATION_FAILED",

        )



    # ======================================================

    # NETTOYAGE FINAL

    # ======================================================



    finally:



        logger.info(

            "🧹 ACTIVATION — entrée dans finally | "

            "committed=%s | temporary=%s | secure_pdf=%s",

            transaction_committed,

            temporary_directory,

            secure_pdf_path,

        )



        # --------------------------------------------------

        # Dossier temporaire

        # --------------------------------------------------



        if temporary_directory:



            try:



                if temporary_directory.exists():



                    shutil.rmtree(

                        temporary_directory,

                        ignore_errors=True,

                    )



                    logger.info(

                        "🧹 ACTIVATION — dossier temporaire supprimé | %s",

                        temporary_directory,

                    )



            except Exception:



                logger.exception(

                    "❌ ACTIVATION — impossible de supprimer "

                    "le dossier temporaire | path=%s",

                    temporary_directory,

                )



        # --------------------------------------------------

        # PDF sécurisé en cas d'échec

        # --------------------------------------------------



        if (

            secure_pdf_path

            and not transaction_committed

        ):



            try:



                if secure_pdf_path.exists():



                    secure_pdf_path.unlink()



                    logger.info(

                        "🧹 ACTIVATION — PDF sécurisé supprimé "

                        "après échec | path=%s",

                        secure_pdf_path,

                    )



            except Exception:



                logger.exception(

                    "❌ ACTIVATION — impossible de supprimer "

                    "le PDF sécurisé après échec | path=%s",

                    secure_pdf_path,

                )



        logger.info(

            "🏁 ACTIVATION — FIN DU TRAITEMENT | "

            "committed=%s",

            transaction_committed,

        )