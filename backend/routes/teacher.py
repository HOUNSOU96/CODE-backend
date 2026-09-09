from pathlib import Path
from uuid import uuid4

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
# CONFIGURATION
# ============================================================

BACKEND_DIR = Path(__file__).resolve().parent.parent

TEACHER_IMAGES_DIR = BACKEND_DIR / "Images" / "enseignants"
TEACHER_IMAGES_DIR.mkdir(parents=True, exist_ok=True)

MAX_PHOTO_SIZE = 5 * 1024 * 1024  # 5 Mo

ALLOWED_PHOTO_TYPES = {
    "image/jpeg": ".jpg",
    "image/png": ".png",
}


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
# PROFIL ENSEIGNANT
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
        "telephone": current_user.telephone,
        "pays_residence": current_user.pays_residence,
        "subjects": [subject[0] for subject in subjects],
        "teacher_photo": (
            f"/images/{current_user.teacher_photo}"
            if current_user.teacher_photo
            else None
        ),
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
    Enregistre la photo et valide le profil enseignant.

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

    extension = ALLOWED_PHOTO_TYPES[photo.content_type]

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
    # Nouveau nom de fichier
    # --------------------------------------------------------

    filename = f"{current_user.id}_{uuid4().hex}{extension}"

    destination = TEACHER_IMAGES_DIR / filename

    # --------------------------------------------------------
    # Suppression de l'ancienne photo
    # --------------------------------------------------------

    old_photo = current_user.teacher_photo

    if old_photo:
        old_path = BACKEND_DIR / "Images" / old_photo

        try:
            if old_path.exists():
                old_path.unlink()
        except OSError:
            pass

    # --------------------------------------------------------
    # Enregistrement de la nouvelle photo
    # --------------------------------------------------------

    try:
        destination.write_bytes(photo_content)

    except OSError as exc:
        raise HTTPException(
            status_code=500,
            detail="Impossible d'enregistrer la photo.",
        ) from exc

    # --------------------------------------------------------
    # Mise à jour du profil
    # --------------------------------------------------------

    current_user.teacher_photo = f"enseignants/{filename}"
    current_user.teacher_profile_validated = True

    db.commit()
    db.refresh(current_user)

    return {
        "success": True,
        "message": "Votre profil enseignant a été validé avec succès.",
        "teacher_profile_validated": True,
        "teacher_photo": f"/images/{current_user.teacher_photo}",
        "subjects": cleaned_subjects,
    }


@router.get("/public-profile")
def get_teacher_public_profile(
    email: str,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
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

    return {
        "nom": teacher.nom,
        "prenom": teacher.prenom,
        "email": teacher.email,
        "teacher_photo": (
            f"/images/{teacher.teacher_photo}"
            if teacher.teacher_photo
            else None
        ),
    }