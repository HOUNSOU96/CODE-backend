import os
from io import BytesIO
from pathlib import Path
from uuid import uuid4

import cloudinary
import cloudinary.uploader

from fastapi import APIRouter, Depends, File, HTTPException, UploadFile
from sqlalchemy.orm import Session

from database import get_db
from dependencies import get_current_user
from models.user import User
from models.teacher_subject import TeacherSubject


# ============================================================
# ROUTER
# ============================================================

router = APIRouter(
    prefix="/api/teacher",
    tags=["Enseignants"],
)


# ============================================================
# CONFIGURATION CLOUDINARY
# ============================================================

cloudinary.config(
    cloud_name=os.getenv("CLOUDINARY_CLOUD_NAME"),
    api_key=os.getenv("CLOUDINARY_API_KEY"),
    api_secret=os.getenv("CLOUDINARY_API_SECRET"),
    secure=True,
)


# ============================================================
# CONFIGURATION PHOTO
# ============================================================

MAX_PHOTO_SIZE = 5 * 1024 * 1024  # 5 Mo

ALLOWED_PHOTO_TYPES = {
    "image/jpeg": ".jpg",
    "image/png": ".png",
}


# ============================================================
# URL PHOTO
# ============================================================

def get_teacher_photo_url(photo: str | None) -> str | None:
    """
    Retourne l'URL utilisable par le frontend.

    Nouvelle méthode :
        photo = URL Cloudinary complète.

    Ancienne méthode :
        photo = enseignants/nom.jpg
        => /images/enseignants/nom.jpg

    Cela permet de conserver la compatibilité avec
    les anciennes photos enregistrées avant Cloudinary.
    """

    if not photo:
        return None

    if photo.startswith("http://") or photo.startswith("https://"):
        return photo

    return f"/images/{photo.lstrip('/')}"


# ============================================================
# EXTRACTION PUBLIC ID CLOUDINARY
# ============================================================

def get_cloudinary_public_id(photo_url: str | None) -> str | None:
    """
    Extrait le public_id Cloudinary depuis une URL Cloudinary.

    Exemple :

    https://res.cloudinary.com/zpepydbz/image/upload/v123456/
    CODE/enseignants/123_photo.jpg

    devient :

    CODE/enseignants/123_photo
    """

    if not photo_url:
        return None

    if not (
        photo_url.startswith("http://")
        or photo_url.startswith("https://")
    ):
        return None

    try:
        if "/image/upload/" not in photo_url:
            return None

        public_part = photo_url.split("/image/upload/", 1)[1]

        # Supprime une éventuelle version Cloudinary :
        # v123456/...
        parts = public_part.split("/")

        if parts and parts[0].startswith("v") and parts[0][1:].isdigit():
            parts = parts[1:]

        public_id = "/".join(parts)

        # Supprime l'extension
        public_id = Path(public_id).with_suffix("").as_posix()

        return public_id

    except Exception:
        return None


# ============================================================
# SUPPRESSION D'UNE ANCIENNE PHOTO CLOUDINARY
# ============================================================

def delete_cloudinary_photo(photo_url: str | None) -> None:
    """
    Supprime une ancienne photo Cloudinary lorsqu'elle
    est remplacée.

    Si l'ancienne photo n'est pas une URL Cloudinary,
    aucune suppression Cloudinary n'est effectuée.
    """

    public_id = get_cloudinary_public_id(photo_url)

    if not public_id:
        return

    try:
        cloudinary.uploader.destroy(
            public_id,
            resource_type="image",
            invalidate=True,
        )
    except Exception:
        # Une erreur de suppression de l'ancienne photo
        # ne doit pas empêcher l'enregistrement de la nouvelle.
        pass


# ============================================================
# VÉRIFICATION ENSEIGNANT
# ============================================================

def require_active_teacher(current_user: User) -> User:
    """
    Vérifie que l'utilisateur connecté est un enseignant actif.
    """

    if not current_user.enseignant:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux enseignants.",
        )

    if not current_user.enseignant_actif:
        raise HTTPException(
            status_code=403,
            detail="Votre statut d'enseignant est actuellement désactivé.",
        )

    return current_user


# ============================================================
# PROFIL ENSEIGNANT CONNECTÉ
# ============================================================

@router.get("/profile")
def get_teacher_profile(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retourne les informations du profil de l'enseignant connecté.
    """

    require_active_teacher(current_user)

    subjects = (
        db.query(TeacherSubject.subject)
        .filter(
            TeacherSubject.teacher_id == current_user.id
        )
        .order_by(TeacherSubject.subject.asc())
        .all()
    )

    return {
        "id": current_user.id,
        "nom": current_user.nom,
        "prenom": current_user.prenom,
        "email": current_user.email,

        # ====================================================
        # TÉLÉPHONE / WHATSAPP
        # ====================================================
        "telephone": current_user.telephone,

        # ====================================================
        # PAYS DE RÉSIDENCE
        # ====================================================
        "pays_residence": current_user.pays_residence,

        # ====================================================
        # MATIÈRES
        # ====================================================
        "subjects": [
            subject[0]
            for subject in subjects
        ],

        # ====================================================
        # PHOTO
        # ====================================================
        "teacher_photo": get_teacher_photo_url(
            current_user.teacher_photo
        ),

        # ====================================================
        # VALIDATION
        # ====================================================
        "teacher_profile_validated": (
            current_user.teacher_profile_validated
        ),

        "enseignant": current_user.enseignant,

        "enseignant_actif": current_user.enseignant_actif,
    }


# ============================================================
# VALIDATION DU PROFIL ENSEIGNANT
# ============================================================

@router.post("/profile/validate")
async def validate_teacher_profile(
    photo: UploadFile = File(...),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Enregistre la photo dans Cloudinary et valide
    le profil enseignant.

    Le backend vérifie :
    - que l'utilisateur est enseignant ;
    - que l'enseignant est actif ;
    - qu'au moins une matière est déclarée ;
    - que la photo est au format JPG ou PNG ;
    - que la photo ne dépasse pas 5 Mo.
    """

    require_active_teacher(current_user)

    # --------------------------------------------------------
    # Récupération des matières
    # --------------------------------------------------------

    subjects = (
        db.query(TeacherSubject.subject)
        .filter(
            TeacherSubject.teacher_id == current_user.id
        )
        .all()
    )

    cleaned_subjects = sorted({
        subject[0].strip()
        for subject in subjects
        if subject[0] and subject[0].strip()
    })

    if not cleaned_subjects:
        raise HTTPException(
            status_code=400,
            detail=(
                "Vous devez avoir au moins une matière déclarée "
                "avant de valider votre profil."
            ),
        )

    # --------------------------------------------------------
    # Vérification du type de photo
    # --------------------------------------------------------

    if photo.content_type not in ALLOWED_PHOTO_TYPES:
        raise HTTPException(
            status_code=400,
            detail="La photo doit être au format JPG ou PNG.",
        )

    # --------------------------------------------------------
    # Lecture de la photo
    # --------------------------------------------------------

    photo_content = await photo.read()

    if not photo_content:
        raise HTTPException(
            status_code=400,
            detail="La photo envoyée est vide.",
        )

    if len(photo_content) > MAX_PHOTO_SIZE:
        raise HTTPException(
            status_code=400,
            detail="La photo ne doit pas dépasser 5 Mo.",
        )

    # --------------------------------------------------------
    # Vérification configuration Cloudinary
    # --------------------------------------------------------

    cloud_name = os.getenv("CLOUDINARY_CLOUD_NAME")
    api_key = os.getenv("CLOUDINARY_API_KEY")
    api_secret = os.getenv("CLOUDINARY_API_SECRET")

    if not cloud_name or not api_key or not api_secret:
        raise HTTPException(
            status_code=500,
            detail=(
                "La configuration du stockage des photos "
                "est incomplète."
            ),
        )

    # --------------------------------------------------------
    # Ancienne photo
    # --------------------------------------------------------

    old_photo = current_user.teacher_photo

    # --------------------------------------------------------
    # Nom unique Cloudinary
    # --------------------------------------------------------

    extension = ALLOWED_PHOTO_TYPES[photo.content_type]

    public_id = (
        f"CODE/enseignants/"
        f"{current_user.id}_{uuid4().hex}"
    )

    # --------------------------------------------------------
    # Upload Cloudinary
    # --------------------------------------------------------

    try:
        upload_result = cloudinary.uploader.upload(
            BytesIO(photo_content),
            public_id=public_id,
            folder=None,
            resource_type="image",
            overwrite=False,
            invalidate=True,
        )

    except Exception as exc:
        raise HTTPException(
            status_code=500,
            detail=(
                "Impossible d'enregistrer la photo "
                "sur le stockage sécurisé."
            ),
        ) from exc

    # --------------------------------------------------------
    # Récupération URL Cloudinary
    # --------------------------------------------------------

    secure_url = upload_result.get("secure_url")

    if not secure_url:
        raise HTTPException(
            status_code=500,
            detail=(
                "La photo a été envoyée mais son URL "
                "n'a pas pu être récupérée."
            ),
        )

    # --------------------------------------------------------
    # Mise à jour PostgreSQL
    # --------------------------------------------------------

    current_user.teacher_photo = secure_url
    current_user.teacher_profile_validated = True

    try:
        db.commit()
        db.refresh(current_user)

    except Exception as exc:
        db.rollback()

        # Si PostgreSQL échoue après l'upload,
        # on tente de supprimer la photo Cloudinary
        # pour éviter de laisser un fichier orphelin.
        try:
            cloudinary.uploader.destroy(
                public_id,
                resource_type="image",
                invalidate=True,
            )
        except Exception:
            pass

        raise HTTPException(
            status_code=500,
            detail=(
                "La photo a été enregistrée temporairement "
                "mais la mise à jour du profil a échoué."
            ),
        ) from exc

    # --------------------------------------------------------
    # Suppression de l'ancienne photo Cloudinary
    # --------------------------------------------------------

    if old_photo and old_photo != secure_url:
        delete_cloudinary_photo(old_photo)

    # --------------------------------------------------------
    # Réponse
    # --------------------------------------------------------

    return {
        "success": True,
        "message": (
            "Votre profil enseignant a été validé "
            "avec succès."
        ),
        "teacher_profile_validated": True,
        "teacher_photo": secure_url,
        "subjects": cleaned_subjects,
    }


# ============================================================
# PROFIL PUBLIC DE L'ENSEIGNANT
# ============================================================

@router.get("/public-profile")
def get_teacher_public_profile(
    email: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retourne les informations publiques d'un enseignant.

    Ce profil est utilisé notamment dans :
    - Questions.tsx
    - RemediationVideo.tsx
    - EnsProfil.tsx

    Les informations retournées comprennent :
    - nom
    - prénom
    - email
    - téléphone / WhatsApp
    - pays de résidence
    - matières enseignées
    - photo
    """

    teacher = (
        db.query(User)
        .filter(
            User.email == email,
            User.enseignant.is_(True),
            User.enseignant_actif.is_(True),
        )
        .first()
    )

    if not teacher:
        raise HTTPException(
            status_code=404,
            detail="Enseignant introuvable.",
        )

    # --------------------------------------------------------
    # RÉCUPÉRATION DES MATIÈRES
    # --------------------------------------------------------

    subjects = (
        db.query(TeacherSubject.subject)
        .filter(
            TeacherSubject.teacher_id == teacher.id
        )
        .order_by(TeacherSubject.subject.asc())
        .all()
    )

    # --------------------------------------------------------
    # PROFIL PUBLIC
    # --------------------------------------------------------

    return {
        # ====================================================
        # IDENTITÉ
        # ====================================================
        "nom": teacher.nom,
        "prenom": teacher.prenom,

        # ====================================================
        # CONTACT
        # ====================================================
        "email": teacher.email,
        "telephone": teacher.telephone,

        # ====================================================
        # PAYS DE RÉSIDENCE
        # ====================================================
        "pays_residence": teacher.pays_residence,

        # ====================================================
        # MATIÈRES
        # ====================================================
        "subjects": [
            subject[0]
            for subject in subjects
        ],

        # ====================================================
        # PHOTO
        # ====================================================
        "teacher_photo": get_teacher_photo_url(
            teacher.teacher_photo
        ),
    }