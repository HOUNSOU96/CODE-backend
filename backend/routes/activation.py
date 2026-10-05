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
#
# Les PDF personnalisés ne sont PLUS enregistrés dans
# document_activations.pdf_data.
#
# Ils sont conservés dans ce dossier sécurisé.
#
# La base de données conserve uniquement le chemin relatif
# dans document_activations.pdf_path.
#
# IMPORTANT :
# Ce dossier ne doit PAS être exposé comme dossier statique
# publiquement par FastAPI, Nginx ou le frontend.
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

    if not activation_code:
        raise HTTPException(
            status_code=400,
            detail="CODE_DOCUMENT_INVALID",
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
        raise HTTPException(
            status_code=404,
            detail="CODE_DOCUMENT_INVALID",
        )

    if activation.is_activated:
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

        if buyer_email != provided_email:
            raise HTTPException(
                status_code=403,
                detail="EMAIL_CODE_MISMATCH",
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

    user = (
        db.query(User)
        .filter(
            func.lower(User.email) == email
        )
        .first()
    )

    if not user:

        return {
            "exists": False,
            "message": (
                "Aucun compte associé à cette "
                "adresse email."
            ),
        }

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
            "pays_residence": user.pays_residence,
        },
    }


# ==========================================================
# 3. ACTIVATION + GÉNÉRATION DU PDF
# ==========================================================

@router.post("/activate")
async def activate_document(

    # ------------------------------------------------------
    # Informations principales
    # ------------------------------------------------------

    activation_code: str = Form(...),

    buyer_email: EmailStr = Form(...),

    activation_type: str = Form(...),

    beneficiary_email: EmailStr = Form(...),

    # ------------------------------------------------------
    # IDENTIFIANT DU NAVIGATEUR / APPAREIL
    # ------------------------------------------------------

    device_id: Optional[str] = Form(None),

    device_type: Optional[str] = Form("unknown"),

    # ------------------------------------------------------
    # Identité nouveau compte
    # ------------------------------------------------------

    nom: Optional[str] = Form(None),

    prenom: Optional[str] = Form(None),

    telephone: Optional[str] = Form(None),

    pays_residence: Optional[str] = Form(None),

    password: Optional[str] = Form(None),

    # ------------------------------------------------------
    # Personnalisation du document
    # ------------------------------------------------------

    etablissement: Optional[str] = Form(None),

    ville: Optional[str] = Form(None),

    annee_scolaire: Optional[str] = Form(None),

    # ------------------------------------------------------
    # Photo facultative
    # ------------------------------------------------------

    photo: Optional[UploadFile] = File(None),

    # ------------------------------------------------------
    # Date achat conservée pour compatibilité éventuelle
    # ------------------------------------------------------

    date_achat: Optional[str] = Form(None),

    # ------------------------------------------------------
    # Base de données
    # ------------------------------------------------------

    db: Session = Depends(get_db),
):
    """
    Activation définitive du document.

    Le processus est :

    1. Vérifier le code.
    2. Vérifier l'email acheteur.
    3. Vérifier que le code n'est pas déjà utilisé.
    4. Trouver ou créer le bénéficiaire.
    5. Vérifier que le modèle du document existe.
    6. Générer le PDF personnalisé.
    7. Enregistrer le PDF dans le stockage sécurisé.
    8. Enregistrer son chemin dans DocumentActivation.pdf_path.
    9. Enregistrer le navigateur dans UserDevice.
    10. Autoriser ce navigateur avec DocumentDeviceAccess.
    11. Enregistrer l'activation.
    12. NE PAS envoyer le PDF par email.
    13. NE PAS retourner le PDF au navigateur.
    14. Retourner uniquement une confirmation JSON.
    15. Supprimer les fichiers temporaires.

    Le PDF original du modèle Typst n'est jamais exposé
    au navigateur.
    """

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
        device_type.strip()
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

    # ======================================================
    # VALIDATIONS DE BASE
    # ======================================================

    if not activation_code:
        raise HTTPException(
            status_code=400,
            detail="CODE_DOCUMENT_INVALID",
        )

    # ------------------------------------------------------
    # Le nouveau système de documents sécurisés nécessite
    # l'identifiant du navigateur.
    # ------------------------------------------------------

    if not device_id_value:
        raise HTTPException(
            status_code=400,
            detail="DEVICE_ID_REQUIRED",
        )

    # ------------------------------------------------------
    # Protection basique contre un identifiant excessif
    # ------------------------------------------------------

    if len(device_id_value) > 255:
        raise HTTPException(
            status_code=400,
            detail="DEVICE_ID_INVALID",
        )

    if activation_type not in [
        "self",
        "other",
    ]:
        raise HTTPException(
            status_code=400,
            detail="ACTIVATION_TYPE_INVALID",
        )

    if activation_type == "self":

        if beneficiary_email_value != buyer_email_value:
            raise HTTPException(
                status_code=400,
                detail="SELF_ACTIVATION_EMAIL_MISMATCH",
            )

    # ======================================================
    # DOSSIER TEMPORAIRE
    # ======================================================

    temporary_directory = None

    # Le chemin permanent est conservé ici afin de pouvoir
    # éventuellement nettoyer le fichier si une erreur
    # survient avant le commit.
    secure_pdf_path = None

    # Permet de savoir si l'activation SQL a réellement
    # été validée avant une éventuelle erreur ultérieure.
    transaction_committed = False

    try:

        # ==================================================
        # ÉTAPE 1 — VERROUILLAGE + RECHERCHE DU CODE
        # ==================================================

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
                detail="CODE_DOCUMENT_INVALID",
            )

        # ==================================================
        # NOM DU DOCUMENT ACTIVÉ
        # ==================================================

        document_name = activation.document_name

        # ==================================================
        # ÉTAPE 2 — CODE DÉJÀ UTILISÉ
        # ==================================================

        if activation.is_activated:
            raise HTTPException(
                status_code=400,
                detail="DOCUMENT_ALREADY_ACTIVATED",
            )

        # ==================================================
        # ÉTAPE 3 — VÉRIFICATION DE L'ACHETEUR
        # ==================================================

        if activation.buyer_email:

            stored_buyer_email = (
                activation.buyer_email
                .strip()
                .lower()
            )

            if stored_buyer_email != buyer_email_value:
                raise HTTPException(
                    status_code=403,
                    detail="EMAIL_CODE_MISMATCH",
                )

        # ==================================================
        # ÉTAPE 4 — BÉNÉFICIAIRE
        # ==================================================

        user = (
            db.query(User)
            .filter(
                func.lower(User.email)
                == beneficiary_email_value
            )
            .first()
        )

        # ==================================================
        # CAS 1 — COMPTE EXISTANT
        # ==================================================

        if user:

            activation.user_id = user.id

        # ==================================================
        # CAS 2 — NOUVEAU COMPTE
        # ==================================================

        else:

            # ----------------------------------------------
            # Champs obligatoires
            # ----------------------------------------------

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

            # ----------------------------------------------
            # Vérification de doublon supplémentaire
            # ----------------------------------------------

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

            else:

                # ------------------------------------------
                # Hachage du mot de passe
                # ------------------------------------------

                hashed_password = hash_password(
                    password
                )

                # ------------------------------------------
                # Création du compte
                # ------------------------------------------

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

                db.flush()

                activation.user_id = user.id

        # ==================================================
        # ÉTAPE 5 — MODÈLE PDF DU DOCUMENT
        # ==================================================

        document_config = DOCUMENT_TEMPLATES.get(
            document_name
        )

        if not document_config:

            logger.warning(
                "Aucun modèle PDF configuré pour le document '%s'.",
                document_name,
            )

            raise HTTPException(
                status_code=400,
                detail="DOCUMENT_PDF_NOT_CONFIGURED",
            )

        if document_config["type"] != "typst":

            logger.error(
                "Générateur non supporté pour le document '%s'.",
                document_name,
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_GENERATOR_NOT_SUPPORTED",
            )

        # ==================================================
        # ÉTAPE 6 — RÉCUPÉRATION DU MODÈLE
        # ==================================================

        document_directory = Path(
            document_config["directory"]
        )

        document_main = Path(
            document_config["main"]
        )

        if not document_main.exists():

            logger.error(
                "Modèle PDF introuvable pour le document '%s' : %s",
                document_name,
                document_main,
            )

            raise HTTPException(
                status_code=500,
                detail="DOCUMENT_TEMPLATE_NOT_FOUND",
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

        # ==================================================
        # ÉTAPE 8 — PHOTO TEMPORAIRE
        # ==================================================

        photo_path = ""

        if photo:

            if photo.content_type not in ALLOWED_PHOTO_TYPES:

                raise HTTPException(
                    status_code=400,
                    detail="PHOTO_FORMAT_INVALID",
                )

            photo_content = await photo.read()

            if len(photo_content) > MAX_PHOTO_SIZE:

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

            photo_absolute_path = (
                document_directory
                / photo_path
            ).resolve()

            logger.info(
                "PHOTO DEBUG — path=%s | existe=%s | absolu=%s | taille=%s",
                photo_path,
                photo_absolute_path.exists(),
                photo_absolute_path,
                (
                    photo_absolute_path.stat().st_size
                    if photo_absolute_path.exists()
                    else "N/A"
                ),
            )

        # ==================================================
        # ÉTAPE 9 — GÉNÉRATION TYPOGRAPHIQUE
        # ==================================================

        # --------------------------------------------------
        # Résolution robuste du binaire Typst.
        #
        # Ordre de recherche :
        #
        # 1. TYPST_PATH si explicitement défini ;
        # 2. installation Render dans ~/.local/bin/typst ;
        # 3. Typst disponible dans le PATH.
        #
        # Le chemin ~/.local/bin/typst est important sur
        # Render car build.sh installe Typst à cet endroit.
        #
        # On vérifie réellement l'existence et les droits
        # d'exécution de chaque candidat.
        # --------------------------------------------------

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

        # --------------------------------------------------
        # Installation utilisée par build.sh sur Render
        # --------------------------------------------------

        typst_candidates.append(
            Path.home()
            / ".local"
            / "bin"
            / "typst"
        )

        # --------------------------------------------------
        # Fallback : Typst disponible dans PATH
        # --------------------------------------------------

        typst_from_path = shutil.which(
            "typst"
        )

        if typst_from_path:

            typst_candidates.append(
                Path(typst_from_path)
            )

        # --------------------------------------------------
        # Recherche du premier binaire valide
        # --------------------------------------------------

        typst_path = None

        seen_typst_paths = set()

        for candidate in typst_candidates:

            try:

                candidate = (
                    candidate
                    .expanduser()
                    .resolve()
                )

            except OSError:

                continue

            candidate_string = str(
                candidate
            )

            # Évite de tester deux fois le même chemin
            if candidate_string in seen_typst_paths:
                continue

            seen_typst_paths.add(
                candidate_string
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

        # --------------------------------------------------
        # Aucun Typst disponible
        # --------------------------------------------------

        if not typst_path:

            logger.error(
                "Typst introuvable ou non exécutable. "
                "TYPST_PATH=%s | HOME=%s | PATH=%s | candidats=%s",
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
            "Typst utilisé pour le document '%s' : %s",
            document_name,
            typst_path,
        )

        # --------------------------------------------------
        # Préparation de l'environnement du processus Typst
        # --------------------------------------------------
        #
        # Même si Typst a été installé dans ~/.local/bin,
        # le PATH du processus Uvicorn peut ne pas contenir
        # ce dossier après le build Render.
        #
        # On ajoute donc explicitement le dossier du binaire
        # au PATH transmis à subprocess.
        # --------------------------------------------------

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

        # --------------------------------------------------
        # Construction de la commande Typst
        # --------------------------------------------------

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
            "Génération du document '%s' pour %s %s.",
            document_name,
            prenom_value or user.prenom,
            nom_value or user.nom,
        )

        logger.info(
            "Commande Typst préparée avec le binaire : %s",
            typst_path,
        )

        try:

            result = subprocess.run(
                typst_command,
                cwd=str(document_directory),
                env=typst_env,
                capture_output=True,
                text=True,
                timeout=180,
                check=False,
            )

        except FileNotFoundError:

            logger.exception(
                "Typst n'est pas installé ou "
                "n'est pas accessible pour le document '%s'.",
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="TYPST_NOT_AVAILABLE",
            )

        except subprocess.TimeoutExpired:

            logger.exception(
                "La génération du document '%s' "
                "a dépassé le délai autorisé.",
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_GENERATION_TIMEOUT",
            )

        # --------------------------------------------------
        # Vérification du résultat Typst
        # --------------------------------------------------

        if result.returncode != 0:

            logger.error(
                "Erreur Typst pour le document '%s'. "
                "Code retour=%s | stderr=%s | stdout=%s",
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
        # ÉTAPE 10 — VÉRIFIER LE PDF
        # ==================================================

        if not pdf_path.exists():

            logger.error(
                "Typst a terminé sans produire "
                "le PDF attendu pour le document '%s'.",
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_NOT_GENERATED",
            )

        pdf_size = pdf_path.stat().st_size

        if pdf_size == 0:

            logger.error(
                "Le PDF généré pour le document '%s' est vide.",
                document_name,
            )

            db.rollback()

            raise HTTPException(
                status_code=500,
                detail="PDF_EMPTY",
            )

        logger.info(
            "PDF généré : %s octets pour '%s'.",
            pdf_size,
            document_name,
        )

        # ==================================================
        # ÉTAPE 11 — STOCKAGE SÉCURISÉ DU PDF
        # ==================================================
        #
        # IMPORTANT :
        #
        # Le PDF n'est PAS chargé en mémoire.
        #
        # On utilise directement le fichier généré.
        #
        # Il n'est PAS envoyé :
        # - dans MySQL/PostgreSQL ;
        # - par email ;
        # - dans la réponse HTTP.
        #
        # La base conserve uniquement son chemin.
        # ==================================================

        secure_document_directory = (
            SECURE_DOCUMENTS_DIR
            / str(activation.id)
        )

        secure_document_directory.mkdir(
            parents=True,
            exist_ok=True,
        )

        secure_pdf_path = (
            secure_document_directory
            / document_filename
        )

        try:

            shutil.copy2(
                pdf_path,
                secure_pdf_path,
            )

        except Exception:

            logger.exception(
                "Impossible de stocker le PDF sécurisé : %s",
                secure_pdf_path,
            )

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_STORAGE_FAILED",
            )

        # --------------------------------------------------
        # Vérification du fichier sécurisé
        # --------------------------------------------------

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

        if secure_pdf_size == 0:

            raise HTTPException(
                status_code=500,
                detail="SECURE_PDF_EMPTY",
            )

        logger.info(
            "PDF sécurisé enregistré : %s (%s octets)",
            secure_pdf_path,
            secure_pdf_size,
        )

        # --------------------------------------------------
        # Enregistrer UNIQUEMENT le chemin relatif
        # --------------------------------------------------

        activation.pdf_path = str(
            secure_pdf_path.relative_to(
                BACKEND_DIR
            )
        )

        # --------------------------------------------------
        # IMPORTANT :
        # Le gros PDF n'est plus enregistré dans pdf_data.
        # --------------------------------------------------

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

        # ==================================================
        # ÉTAPE 12 — ENREGISTRER LE NAVIGATEUR
        # ==================================================

        now = datetime.utcnow()

        device = (
            db.query(UserDevice)
            .filter(
                UserDevice.device_id
                == device_id_value
            )
            .first()
        )

        # --------------------------------------------------
        # Nouveau navigateur/appareil
        # --------------------------------------------------

        if not device:

            device = UserDevice(
                user_id=user.id,
                device_id=device_id_value,
                device_type=device_type_value,
                is_mobile=(
                    device_type_value
                    in ["android", "ios"]
                ),
                is_active=True,
                created_at=now,
                last_seen=now,
            )

            db.add(device)

            db.flush()

        # --------------------------------------------------
        # Navigateur déjà enregistré
        # --------------------------------------------------

        else:

            # Un même identifiant technique ne doit pas
            # pouvoir être utilisé simultanément comme
            # appareil d'un autre compte.

            if device.user_id != user.id:

                logger.warning(
                    "DEVICE_ALREADY_ASSOCIATED : device=%s "
                    "user_existant=%s user_demande=%s",
                    device_id_value,
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
                in ["android", "ios"]
            )

        # ==================================================
        # ÉTAPE 13 — AUTORISER LE NAVIGATEUR POUR CE PDF
        # ==================================================

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

        # --------------------------------------------------
        # Aucun accès existant
        # --------------------------------------------------

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

        # --------------------------------------------------
        # Accès déjà existant
        # --------------------------------------------------

        else:

            document_access.user_id = user.id

            document_access.is_active = True

            document_access.last_access = now

            document_access.last_version = 1

        # ==================================================
        # ÉTAPE 14 — COMMIT UNIQUE
        # ==================================================
        #
        # IMPORTANT :
        #
        # Le gros PDF n'est plus dans la transaction SQL.
        #
        # PostgreSQL ne reçoit que des informations légères :
        #
        # - pdf_path
        # - pdf_filename
        # - user_id
        # - activation
        # - device
        # - accès document
        #
        # Le fichier PDF lui-même reste dans le stockage.
        # ==================================================

        db.commit()

        transaction_committed = True

        db.refresh(activation)

        db.refresh(device)

        # ==================================================
        # ÉTAPE 15 — AUCUN ENVOI DU PDF
        # ==================================================
        #
        # Pour l'instant :
        #
        # - aucun email Brevo avec le PDF ;
        # - aucun PDF dans la réponse HTTP ;
        # - aucun téléchargement automatique ;
        # - aucun chargement de 242 Mo en mémoire.
        #
        # Le document reste disponible dans :
        #
        # "Mes documents"
        #
        # grâce au système DocumentDeviceAccess.
        # ==================================================

        logger.info(
            "Activation réussie sans envoi du PDF : "
            "activation_id=%s | document=%s | device=%s",
            activation.id,
            activation.document_name,
            device_id_value,
        )

        # ==================================================
        # ÉTAPE 16 — RÉPONSE JSON UNIQUEMENT
        # ==================================================
        #
        # Le navigateur reçoit uniquement des informations
        # légères concernant la réussite de l'activation.
        #
        # Aucun octet du PDF n'est renvoyé.
        # ==================================================

        return {
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

    # ======================================================
    # ERREUR HTTP
    # ======================================================

    except HTTPException:

        try:
            db.rollback()
        except Exception:
            pass

        raise

    # ======================================================
    # ERREUR INATTENDUE
    # ======================================================

    except Exception:

        logger.exception(
            "Erreur inattendue pendant "
            "l'activation du document."
        )

        try:
            db.rollback()
        except Exception:
            pass

        raise HTTPException(
            status_code=500,
            detail="ACTIVATION_FAILED",
        )

    # ======================================================
    # NETTOYAGE
    # ======================================================

    finally:

        # --------------------------------------------------
        # Nettoyage du dossier temporaire
        # --------------------------------------------------

        if temporary_directory:

            try:

                if temporary_directory.exists():

                    shutil.rmtree(
                        temporary_directory,
                        ignore_errors=True,
                    )

            except Exception:

                logger.exception(
                    "Impossible de supprimer "
                    "le dossier temporaire : %s",
                    temporary_directory,
                )

        # --------------------------------------------------
        # Nettoyage du PDF sécurisé en cas d'échec AVANT
        # le commit SQL.
        #
        # Si le commit a réussi, le fichier doit évidemment
        # être conservé.
        # --------------------------------------------------

        if (
            secure_pdf_path
            and not transaction_committed
        ):

            try:

                if secure_pdf_path.exists():

                    secure_pdf_path.unlink()

                    logger.info(
                        "PDF sécurisé supprimé après "
                        "échec de l'activation : %s",
                        secure_pdf_path,
                    )

            except Exception:

                logger.exception(
                    "Impossible de supprimer le PDF sécurisé "
                    "après échec : %s",
                    secure_pdf_path,
                )