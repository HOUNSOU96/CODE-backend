from fastapi import (
    APIRouter,
    Depends,
    HTTPException,
    File,
    Form,
    UploadFile,
)

from sqlalchemy.orm import Session
from sqlalchemy import func

from pydantic import BaseModel, EmailStr

from typing import Optional
from datetime import datetime

from pathlib import Path
import os
import tempfile
import subprocess
import shutil
import logging
import re

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
        "type": "typst",
        "directory": BACKEND_DIR / "CODE-MathsI",
        "main": BACKEND_DIR / "CODE-MathsI" / "main.typ",
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
            .filter(
                DocumentActivation.activation_code
                == activation_code
            )
            .with_for_update()
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
        # COMPTE EXISTANT
        # ==================================================

        if user:

            activation.user_id = user.id

            logger.info(
                "🟢 ACTIVATION — compte existant | "
                "user_id=%s | email=%s",
                user.id,
                user.email,
            )

        # ==================================================
        # NOUVEAU COMPTE
        # ==================================================

        else:

            logger.info(
                "🔵 ACTIVATION — création nouveau compte | "
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

            existing_user = (
                db.query(User)
                .filter(
                    func.lower(User.email)
                    == beneficiary_email_value
                )
                .first()
            )

            if existing_user:

                user = existing_user

                activation.user_id = user.id

                logger.info(
                    "🟢 ACTIVATION — utilisateur trouvé "
                    "lors de la seconde vérification | user_id=%s",
                    user.id,
                )

            else:

                logger.info(
                    "🔵 ACTIVATION — hachage du mot de passe"
                )

                hashed_password = hash_password(
                    password
                )

                logger.info(
                    "🔵 ACTIVATION — création objet User"
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
                    "🔵 ACTIVATION — flush nouveau User"
                )

                db.flush()

                activation.user_id = user.id

                logger.info(
                    "🟢 ACTIVATION — nouveau compte créé | "
                    "user_id=%s | email=%s",
                    user.id,
                    user.email,
                )

        logger.info(
            "🟢 ACTIVATION — bénéficiaire prêt | "
            "user_id=%s",
            user.id,
        )

        # ==================================================
        # ÉTAPE 5 — MODÈLE PDF
        # ==================================================

        logger.info(
            "🔵 ACTIVATION — recherche configuration document | "
            "document='%s'",
            document_name,
        )

        document_config = DOCUMENT_TEMPLATES.get(
            document_name
        )

        if not document_config:

            logger.error(
                "❌ ACTIVATION — document non configuré | "
                "document='%s'",
                document_name,
            )

            raise HTTPException(
                status_code=400,
                detail="DOCUMENT_PDF_NOT_CONFIGURED",
            )

        logger.info(
            "🟢 ACTIVATION — configuration trouvée | "
            "type=%s | directory=%s | main=%s",
            document_config["type"],
            document_config["directory"],
            document_config["main"],
        )

        if document_config["type"] != "typst":

            logger.error(
                "❌ ACTIVATION — générateur non supporté | "
                "type=%s",
                document_config["type"],
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_GENERATOR_NOT_SUPPORTED",
            )

        # ==================================================
        # ÉTAPE 6 — MODÈLE TYPOGRAPHIQUE
        # ==================================================

        document_directory = Path(
            document_config["directory"]
        )

        document_main = Path(
            document_config["main"]
        )

        logger.info(
            "🔵 ACTIVATION — vérification main.typ | "
            "path=%s | exists=%s | is_file=%s",
            document_main,
            document_main.exists(),
            document_main.is_file(),
        )

        if not document_main.exists():

            logger.error(
                "❌ ACTIVATION — main.typ introuvable | "
                "path=%s",
                document_main,
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_TEMPLATE_NOT_FOUND",
            )

        logger.info(
            "🟢 ACTIVATION — main.typ disponible"
        )

        # ==================================================
        # ÉTAPE 7 — DOSSIER TEMPORAIRE
        # ==================================================

        temporary_root = (
            document_directory / "tmp"
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
            "🟢 ACTIVATION — dossier temporaire créé | "
            "directory=%s | pdf=%s",
            temporary_directory,
            pdf_path,
        )

        # ==================================================
        # ÉTAPE 8 — PHOTO
        # ==================================================

        photo_path = ""

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

            extension = ALLOWED_PHOTO_TYPES[
                photo.content_type
            ]

            temporary_photo = (
                temporary_directory
                / f"photo{extension}"
            )

            temporary_photo.write_bytes(
                photo_content
            )

            photo_path = str(
                temporary_photo.relative_to(
                    document_directory
                )
            )

            logger.info(
                "🟢 ACTIVATION — photo temporaire enregistrée | "
                "relative_path=%s | exists=%s",
                photo_path,
                temporary_photo.exists(),
            )

        else:

            logger.info(
                "📷 ACTIVATION — aucune photo fournie"
            )

        # ==================================================
        # ÉTAPE 9 — RECHERCHE TYPOST
        # ==================================================

        typst_candidates = []

        configured_typst_path = os.getenv(
            "TYPST_PATH"
        )

        if configured_typst_path:

            typst_candidates.append(
                Path(
                    configured_typst_path
                ).expanduser()
            )

        typst_candidates.append(
            BACKEND_DIR
            / ".tools"
            / "typst"
        )

        typst_candidates.append(
            Path.home()
            / ".local"
            / "bin"
            / "typst"
        )

        typst_from_path = shutil.which(
            "typst"
        )

        if typst_from_path:

            typst_candidates.append(
                Path(typst_from_path)
            )

        logger.info(
            "🔵 ACTIVATION — recherche Typst | "
            "TYPST_PATH=%s | PATH=%s",
            os.getenv("TYPST_PATH"),
            os.getenv("PATH"),
        )

        logger.info(
            "🔵 ACTIVATION — candidats Typst | %s",
            [str(path) for path in typst_candidates],
        )

        typst_path = None

        seen_typst_paths = set()

        for candidate in typst_candidates:

            try:

                candidate = (
                    candidate
                    .expanduser()
                    .resolve()
                )

            except OSError as error:

                logger.warning(
                    "⚠️ ACTIVATION — candidat Typst "
                    "impossible à résoudre | candidate=%s | error=%s",
                    candidate,
                    error,
                )

                continue

            candidate_string = str(
                candidate
            )

            if candidate_string in seen_typst_paths:
                continue

            seen_typst_paths.add(
                candidate_string
            )

            logger.info(
                "🔎 ACTIVATION — test Typst | "
                "path=%s | exists=%s | file=%s | executable=%s",
                candidate,
                candidate.exists(),
                candidate.is_file(),
                (
                    os.access(
                        candidate,
                        os.X_OK,
                    )
                    if candidate.exists()
                    else False
                ),
            )

            if (
                candidate.is_file()
                and os.access(
                    candidate,
                    os.X_OK,
                )
            ):

                typst_path = candidate_string

                break

        if not typst_path:

            logger.error(
                "❌ ACTIVATION — Typst introuvable ou "
                "non exécutable | "
                "TYPST_PATH=%s | HOME=%s | PATH=%s | "
                "candidats=%s",
                os.getenv("TYPST_PATH"),
                Path.home(),
                os.getenv("PATH"),
                [str(path) for path in typst_candidates],
            )

            raise HTTPException(
                status_code=500,
                detail="TYPST_NOT_AVAILABLE",
            )

        logger.info(
            "🟢 ACTIVATION — Typst disponible | path=%s",
            typst_path,
        )

        # ==================================================
        # ENVIRONNEMENT TYPOGRAPH
        # ==================================================

        typst_env = os.environ.copy()

        typst_directory = str(
            Path(typst_path).parent
        )

        current_path = typst_env.get(
            "PATH",
            "",
        )

        typst_env["PATH"] = (
            f"{typst_directory}:{current_path}"
            if current_path
            else typst_directory
        )

        # ==================================================
        # COMMANDE TYPOGRAPHIQUE
        # ==================================================

        typst_command = [
            typst_path,
            "compile",

            "--input",
            f"nom={nom_value or user.nom}",

            "--input",
            f"prenom={prenom_value or user.prenom}",

            "--input",
            f"pays={pays_value or user.pays_residence or ''}",

            "--input",
            f"etablissement={etablissement_value}",

            "--input",
            f"ville={ville_value}",

            "--input",
            f"annee_scolaire={annee_scolaire_value}",

            "--input",
            f"photo_path={photo_path}",

            "--input",
            f"code={activation.activation_code}",

            str(document_main),

            str(pdf_path),
        ]

        logger.info(
            "🔵 ACTIVATION — commande Typst préparée | "
            "activation_id=%s",
            activation.id,
        )

        logger.info(
            "📄 ACTIVATION — document='%s' | bénéficiaire=%s %s",
            document_name,
            prenom_value or user.prenom,
            nom_value or user.nom,
        )

        # ==================================================
        # DIAGNOSTIC TYPOST
        # ==================================================

        logger.info(
            "🚨 PDF DEBUG — AVANT subprocess.run | "
            "activation_id=%s | typst=%s | cwd=%s | "
            "main=%s | output=%s",
            activation.id,
            typst_path,
            document_directory,
            document_main,
            pdf_path,
        )

        logger.info(
            "🚨 PDF DEBUG — commande Typst | %s",
            typst_command,
        )

        logger.info(
            "🚨 PDF DEBUG — output existe AVANT Typst | %s",
            pdf_path.exists(),
        )

        logger.info(
            "🚨 PDF DEBUG — cwd existe | %s",
            document_directory.exists(),
        )

        logger.info(
            "🚨 PDF DEBUG — main existe | %s",
            document_main.exists(),
        )

        # ==================================================
        # SUBPROCESS TYPOST
        # ==================================================

        try:

            # --------------------------------------------------
            # TIMEOUT DE GÉNÉRATION PDF
            # --------------------------------------------------
            #
            # Render peut être plus lent que l'environnement local.
            # La valeur est configurable avec :
            #
            # PDF_GENERATION_TIMEOUT_SECONDS
            #
            # Valeur par défaut : 600 secondes = 10 minutes.
            #

            pdf_timeout = int(
                os.getenv(
                    "PDF_GENERATION_TIMEOUT_SECONDS",
                    "600",
                )
            )

            if pdf_timeout <= 0:

                logger.warning(
                    "⚠️ PDF DEBUG — valeur de timeout invalide | "
                    "value=%s | utilisation de 600 secondes",
                    pdf_timeout,
                )

                pdf_timeout = 600

            logger.info(
                "⏱️ PDF DEBUG — timeout génération Typst=%s secondes",
                pdf_timeout,
            )

            result = subprocess.run(
                typst_command,
                cwd=str(document_directory),
                env=typst_env,
                capture_output=True,
                text=True,
                timeout=pdf_timeout,
                check=False,
            )

        except FileNotFoundError:

            logger.exception(
                "❌ ACTIVATION — Typst inaccessible | "
                "path=%s | document=%s",
                typst_path,
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="TYPST_NOT_AVAILABLE",
            )

        except ValueError:

            logger.exception(
                "❌ ACTIVATION — valeur de timeout PDF invalide | "
                "PDF_GENERATION_TIMEOUT_SECONDS=%s",
                os.getenv(
                    "PDF_GENERATION_TIMEOUT_SECONDS"
                ),
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_TIMEOUT",
            )

        except subprocess.TimeoutExpired:

            logger.exception(
                "❌ ACTIVATION — génération Typst dépassée "
                "après %s secondes | document=%s",
                pdf_timeout,
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_TIMEOUT",
            )

        # ==================================================
        # TYPOGRAPH TERMINÉ
        # ==================================================

        logger.info(
            "🚨 PDF DEBUG — APRÈS subprocess.run | "
            "returncode=%s | pdf_exists=%s",
            result.returncode,
            pdf_path.exists(),
        )

        logger.info(
            "🚨 PDF DEBUG — stdout Typst | %s",
            (
                result.stdout[-5000:]
                if result.stdout
                else "(vide)"
            ),
        )

        logger.info(
            "🚨 PDF DEBUG — stderr Typst | %s",
            (
                result.stderr[-5000:]
                if result.stderr
                else "(vide)"
            ),
        )

        logger.info(
            "🏁 ACTIVATION — Typst terminé | "
            "returncode=%s | activation_id=%s",
            result.returncode,
            activation.id,
        )

        if result.returncode != 0:

            logger.error(
                "❌ ACTIVATION — erreur Typst | "
                "document='%s' | code_retour=%s | "
                "stderr=%s | stdout=%s",
                document_name,
                result.returncode,
                result.stderr,
                result.stdout,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_FAILED",
            )

        # ==================================================
        # ÉTAPE 10 — PDF GÉNÉRÉ
        # ==================================================

        logger.info(
            "🔵 ACTIVATION — vérification PDF | "
            "path=%s | exists=%s",
            pdf_path,
            pdf_path.exists(),
        )

        if not pdf_path.exists():

            logger.error(
                "❌ ACTIVATION — Typst terminé sans PDF | "
                "path=%s",
                pdf_path,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_NOT_GENERATED",
            )

        pdf_size = pdf_path.stat().st_size

        logger.info(
            "🔵 ACTIVATION — taille PDF temporaire=%s octets",
            pdf_size,
        )

        if pdf_size == 0:

            logger.error(
                "❌ ACTIVATION — PDF vide | path=%s",
                pdf_path,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_EMPTY",
            )

        logger.info(
            "🟢 ACTIVATION — PDF généré avec succès | "
            "taille=%s octets",
            pdf_size,
        )

        # ==================================================
        # ÉTAPE 11 — STOCKAGE SÉCURISÉ
        # ==================================================

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

        # ==================================================
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