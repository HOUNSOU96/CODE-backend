from datetime import datetime
from typing import List, Optional

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field
from sqlalchemy.orm import Session

from database import get_db
from dependencies import get_current_user
from models.user import User
from models.project_idea import ProjectIdea


# ==========================================================
# ROUTER
# ==========================================================

router = APIRouter(
    prefix="/api/projets",
    tags=["Projets"]
)


# ==========================================================
# SCHÉMAS PYDANTIC
# ==========================================================

class ProjectIdeaCreate(BaseModel):
    """
    Données envoyées par une personne qui souhaite
    soumettre une idée à CODE.
    """

    nom: str = Field(..., min_length=1, max_length=100)
    prenom: str = Field(..., min_length=1, max_length=100)

    email: str = Field(..., min_length=3, max_length=255)
    telephone: str = Field(..., min_length=1, max_length=50)

    pays: str = Field(..., min_length=1, max_length=100)

    titre: str = Field(..., min_length=1, max_length=255)

    description: str = Field(..., min_length=1)

    # ------------------------------------------------------
    # Problème / Solution / Vision / Impact
    # ------------------------------------------------------

    probleme: Optional[str] = None

    solution: Optional[str] = None

    vision: Optional[str] = None

    impact: Optional[str] = None

    categorie: Optional[str] = Field(
        default=None,
        max_length=100
    )

    consentement_publication: bool = False
    declaration_droits: bool = False


class ProjectIdeaPublic(BaseModel):
    """
    Informations publiques d'une idée publiée.

    Les coordonnées privées du déposant ne sont jamais
    exposées dans ce schéma.
    """

    id: int

    nom: str
    prenom: str
    pays: str

    titre: str
    description: str

    probleme: Optional[str]
    solution: Optional[str]
    vision: Optional[str]
    impact: Optional[str]

    categorie: Optional[str]

    date_publication: Optional[datetime]


class ProjectIdeaAdmin(BaseModel):
    """
    Informations complètes destinées à l'administration CODE.
    """

    id: int

    nom: str
    prenom: str

    email: str
    telephone: str
    pays: str

    titre: str
    description: str

    probleme: Optional[str]
    solution: Optional[str]
    vision: Optional[str]
    impact: Optional[str]

    categorie: Optional[str]

    statut: str

    consentement_publication: bool
    declaration_droits: bool

    date_soumission: datetime
    date_examen: Optional[datetime]
    date_publication: Optional[datetime]


class ProjectStatusUpdate(BaseModel):
    statut: str


# ==========================================================
# FONCTION UTILITAIRE
# ==========================================================

STATUTS_AUTORISES = {
    "pending",
    "reviewing",
    "accepted",
    "rejected",
    "published",
}


def verifier_admin(current_user: User):
    """
    Vérifie que l'utilisateur connecté est administrateur.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Accès réservé aux administrateurs"
        )


# ==========================================================
# SOUMISSION D'UNE IDÉE
# ==========================================================

@router.post(
    "/soumettre",
    status_code=status.HTTP_201_CREATED
)
def soumettre_projet(
    project_data: ProjectIdeaCreate,
    db: Session = Depends(get_db)
):
    """
    Permet à une personne de soumettre une idée à CODE.

    L'idée est enregistrée avec le statut 'pending'.

    Les deux déclarations sont obligatoires.
    """

    # ------------------------------------------------------
    # Vérification du consentement
    # ------------------------------------------------------

    if not project_data.consentement_publication:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "Vous devez autoriser CODE à publier votre idée "
                "après examen."
            )
        )

    if not project_data.declaration_droits:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "Vous devez accepter la déclaration relative "
                "à l'exploitation libre de l'idée."
            )
        )

    # ------------------------------------------------------
    # Création
    # ------------------------------------------------------

    nouvelle_idee = ProjectIdea(
        nom=project_data.nom.strip(),
        prenom=project_data.prenom.strip(),

        email=project_data.email.strip(),
        telephone=project_data.telephone.strip(),
        pays=project_data.pays.strip(),

        titre=project_data.titre.strip(),
        description=project_data.description.strip(),

        # --------------------------------------------------
        # PROBLÈME
        # --------------------------------------------------

        probleme=(
            project_data.probleme.strip()
            if project_data.probleme
            else None
        ),

        # --------------------------------------------------
        # SOLUTION
        # --------------------------------------------------

        solution=(
            project_data.solution.strip()
            if project_data.solution
            else None
        ),

        # --------------------------------------------------
        # VISION
        # --------------------------------------------------

        vision=(
            project_data.vision.strip()
            if project_data.vision
            else None
        ),

        # --------------------------------------------------
        # IMPACT
        # --------------------------------------------------

        impact=(
            project_data.impact.strip()
            if project_data.impact
            else None
        ),

        # --------------------------------------------------
        # CATÉGORIE
        # --------------------------------------------------

        categorie=(
            project_data.categorie.strip()
            if project_data.categorie
            else None
        ),

        statut="pending",

        consentement_publication=True,
        declaration_droits=True,

        date_soumission=datetime.utcnow()
    )

    db.add(nouvelle_idee)
    db.commit()
    db.refresh(nouvelle_idee)

    return {
        "message": (
            "Votre idée a bien été soumise à l'équipe CODE "
            "pour examen."
        ),
        "id": nouvelle_idee.id,
        "statut": nouvelle_idee.statut
    }


# ==========================================================
# PROJETS PUBLIÉS — PUBLIC
# ==========================================================

@router.get(
    "",
    response_model=List[ProjectIdeaPublic]
)
def get_projets_publics(
    db: Session = Depends(get_db)
):
    """
    Retourne uniquement les idées publiées.

    Les coordonnées privées du déposant ne sont jamais
    retournées ici.
    """

    projets = (
        db.query(ProjectIdea)
        .filter(
            ProjectIdea.statut == "published"
        )
        .order_by(
            ProjectIdea.date_publication.desc(),
            ProjectIdea.id.desc()
        )
        .all()
    )

    return [
        ProjectIdeaPublic(
            id=projet.id,

            nom=projet.nom,
            prenom=projet.prenom,
            pays=projet.pays,

            titre=projet.titre,
            description=projet.description,

            probleme=projet.probleme,
            solution=projet.solution,
            vision=projet.vision,
            impact=projet.impact,

            categorie=projet.categorie,

            date_publication=projet.date_publication
        )
        for projet in projets
    ]


# ==========================================================
# ADMIN — LISTE DE TOUTES LES IDÉES
# ==========================================================

@router.get(
    "/admin/toutes",
    response_model=List[ProjectIdeaAdmin]
)
def get_toutes_les_idees(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Retourne toutes les idées à l'administration CODE.
    """

    verifier_admin(current_user)

    projets = (
        db.query(ProjectIdea)
        .order_by(
            ProjectIdea.date_soumission.desc(),
            ProjectIdea.id.desc()
        )
        .all()
    )

    return projets


# ==========================================================
# ADMIN — CONSULTER UNE IDÉE
# ==========================================================

@router.get(
    "/admin/idee/{project_id}",
    response_model=ProjectIdeaAdmin
)
def get_idee_admin(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Retourne les informations complètes d'une idée
    à l'administrateur.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    return projet


# ==========================================================
# ADMIN — EXAMINER
# ==========================================================

@router.put(
    "/admin/{project_id}/examiner"
)
def examiner_projet(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Place une idée en cours d'examen.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    if projet.statut != "pending":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "Cette idée ne peut plus être placée "
                "en attente d'examen."
            )
        )

    projet.statut = "reviewing"
    projet.date_examen = datetime.utcnow()

    db.commit()
    db.refresh(projet)

    return {
        "message": "Idée placée en cours d'examen.",
        "id": projet.id,
        "statut": projet.statut
    }


# ==========================================================
# ADMIN — ACCEPTER
# ==========================================================

@router.put(
    "/admin/{project_id}/accepter"
)
def accepter_projet(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Accepte une idée après examen.

    L'idée n'est pas encore publique.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    if projet.statut not in {"pending", "reviewing"}:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "Cette idée ne peut pas être acceptée "
                "dans son état actuel."
            )
        )

    if not projet.consentement_publication:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Le consentement de publication est absent."
        )

    if not projet.declaration_droits:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "La déclaration relative aux droits est absente."
            )
        )

    projet.statut = "accepted"

    if not projet.date_examen:
        projet.date_examen = datetime.utcnow()

    db.commit()
    db.refresh(projet)

    return {
        "message": "Idée acceptée.",
        "id": projet.id,
        "statut": projet.statut
    }


# ==========================================================
# ADMIN — REFUSER
# ==========================================================

@router.put(
    "/admin/{project_id}/refuser"
)
def refuser_projet(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Refuse une idée.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    projet.statut = "rejected"

    if not projet.date_examen:
        projet.date_examen = datetime.utcnow()

    db.commit()
    db.refresh(projet)

    return {
        "message": "Idée refusée.",
        "id": projet.id,
        "statut": projet.statut
    }


# ==========================================================
# ADMIN — PUBLIER
# ==========================================================

@router.put(
    "/admin/{project_id}/publier"
)
def publier_projet(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Rend une idée acceptée publiquement visible.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    if projet.statut != "accepted":
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "Seule une idée acceptée peut être publiée."
            )
        )

    if not projet.consentement_publication:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Le consentement de publication est absent."
        )

    if not projet.declaration_droits:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail=(
                "La déclaration relative aux droits est absente."
            )
        )

    projet.statut = "published"
    projet.date_publication = datetime.utcnow()

    db.commit()
    db.refresh(projet)

    return {
        "message": "Idée publiée avec succès.",
        "id": projet.id,
        "statut": projet.statut,
        "date_publication": (
            projet.date_publication.isoformat()
            if projet.date_publication
            else None
        )
    }


# ==========================================================
# ADMIN — SUPPRIMER
# ==========================================================

@router.delete(
    "/admin/{project_id}"
)
def supprimer_projet(
    project_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    """
    Supprime définitivement une idée.
    """

    verifier_admin(current_user)

    projet = (
        db.query(ProjectIdea)
        .filter(ProjectIdea.id == project_id)
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Idée introuvable"
        )

    db.delete(projet)
    db.commit()

    return {
        "message": "Idée supprimée définitivement.",
        "id": project_id
    }


# ==========================================================
# PROJET PUBLIÉ — PUBLIC
# ==========================================================

@router.get(
    "/{project_id}",
    response_model=ProjectIdeaPublic
)
def get_projet_public(
    project_id: int,
    db: Session = Depends(get_db)
):
    """
    Retourne une seule idée si elle est publiée.
    """

    projet = (
        db.query(ProjectIdea)
        .filter(
            ProjectIdea.id == project_id,
            ProjectIdea.statut == "published"
        )
        .first()
    )

    if not projet:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Projet publié introuvable"
        )

    return ProjectIdeaPublic(
        id=projet.id,

        nom=projet.nom,
        prenom=projet.prenom,
        pays=projet.pays,

        titre=projet.titre,
        description=projet.description,

        probleme=projet.probleme,
        solution=projet.solution,
        vision=projet.vision,
        impact=projet.impact,

        categorie=projet.categorie,

        date_publication=projet.date_publication
    )