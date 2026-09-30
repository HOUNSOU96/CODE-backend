from datetime import datetime, date
from typing import Optional

from fastapi import APIRouter, Depends, HTTPException
from pydantic import BaseModel
from sqlalchemy.orm import Session

from database import get_db
from dependencies import get_current_user

from models.user import User
from models.school import School, SchoolMembership, SchoolDirector


router = APIRouter(
    prefix="/api/schools",
    tags=["schools"]
)


# ============================================================
# OUTILS
# ============================================================

def get_current_academic_year() -> str:
    """
    Détermine automatiquement l'année scolaire.

    Septembre 2026 -> 2026-2027
    Août 2027     -> 2026-2027
    Septembre 2027 -> 2027-2028
    """

    today = date.today()

    if today.month >= 9:
        return f"{today.year}-{today.year + 1}"

    return f"{today.year - 1}-{today.year}"


def get_user_role(user: User) -> str:
    """
    Détermine le rôle scolaire de l'utilisateur.

    Un enseignant actif est toujours considéré comme enseignant.
    Les autres utilisateurs sont considérés comme apprenants.

    Le frontend ne peut pas décider du rôle.
    """

    if user.enseignant and user.enseignant_actif:
        return "teacher"

    return "student"


def clean_optional_text(
    value: Optional[str]
) -> Optional[str]:
    """
    Nettoie une chaîne de caractères optionnelle.

    Exemple :
        "  Cotonou  " -> "Cotonou"
        ""            -> None
        None          -> None
    """

    if value is None:
        return None

    value = value.strip()

    return value if value else None


def get_director_for_school(
    db: Session,
    school_id: int
) -> Optional[SchoolDirector]:
    """
    Retourne le directeur actif d'une école.
    """

    return (
        db.query(SchoolDirector)
        .filter(
            SchoolDirector.school_id == school_id,
            SchoolDirector.is_active == True
        )
        .first()
    )


def verify_school_director(
    db: Session,
    current_user: User,
    school_id: int
) -> SchoolDirector:
    """
    Vérifie que l'utilisateur est bien le directeur
    actif de l'école demandée.

    Retourne l'enregistrement SchoolDirector si tout est correct.
    """

    director = (
        db.query(SchoolDirector)
        .filter(
            SchoolDirector.user_id == current_user.id,
            SchoolDirector.school_id == school_id,
            SchoolDirector.is_active == True
        )
        .first()
    )

    if not director:
        raise HTTPException(
            status_code=403,
            detail="Vous n'êtes pas directeur de cette école."
        )

    return director


# ============================================================
# SCHEMAS
# ============================================================

class SchoolCreateRequest(BaseModel):
    nom: str
    adresse: Optional[str] = None
    ville: Optional[str] = None
    departement: Optional[str] = None
    pays: Optional[str] = "Bénin"
    type_enseignement: Optional[str] = None
    statut: Optional[str] = None
    email: Optional[str] = None
    telephone: Optional[str] = None


class SchoolRequestCreate(BaseModel):
    school_id: int


class SchoolDecisionRequest(BaseModel):
    decision: str


class DirectorAssignRequest(BaseModel):
    user_id: int


# ============================================================
# 1. LISTE DES ÉCOLES
# ============================================================

@router.get("")
def list_schools(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retourne les écoles actives disponibles.

    Accessible aux utilisateurs connectés.
    """

    schools = (
        db.query(School)
        .filter(
            School.is_active == True
        )
        .order_by(
            School.nom.asc()
        )
        .all()
    )

    return {
        "schools": [
            {
                "id": school.id,
                "nom": school.nom,
                "adresse": school.adresse,
                "ville": school.ville,
                "departement": school.departement,
                "pays": school.pays,
                "type_enseignement": school.type_enseignement,
                "statut": school.statut,
                "email": school.email,
                "telephone": school.telephone,
                "is_active": school.is_active,
            }
            for school in schools
        ]
    }


# ============================================================
# 2. INFORMATIONS SCOLAIRES DE L'UTILISATEUR
# ============================================================

@router.get("/me")
def get_my_school_information(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retourne les écoles de l'utilisateur et les possibilités
    de sélection.

    Enseignant :
        - plusieurs écoles ;
        - peut ajouter une école à tout moment.

    Apprenant :
        - une seule école active par année scolaire ;
        - nouveau choix possible à partir du 1er septembre.
    """

    academic_year = get_current_academic_year()
    role = get_user_role(current_user)

    membership_rows = (
        db.query(
            SchoolMembership,
            School
        )
        .join(
            School,
            School.id == SchoolMembership.school_id
        )
        .filter(
            SchoolMembership.user_id == current_user.id
        )
        .order_by(
            SchoolMembership.requested_at.desc()
        )
        .all()
    )

    current_memberships = [
        (membership, school)
        for membership, school in membership_rows
        if membership.academic_year == academic_year
    ]

    school_data = []

    for membership, school in current_memberships:

        school_data.append({
            "membership_id": membership.id,
            "school_id": school.id,
            "school_name": school.nom,
            "adresse": school.adresse,
            "ville": school.ville,
            "departement": school.departement,
            "pays": school.pays,
            "type_enseignement": school.type_enseignement,
            "statut": school.statut,
            "role": membership.role,
            "status": membership.status,
            "academic_year": membership.academic_year,
            "requested_at": (
                membership.requested_at.isoformat()
                if membership.requested_at
                else None
            ),
            "approved_at": (
                membership.approved_at.isoformat()
                if membership.approved_at
                else None
            ),
        })

    # --------------------------------------------------------
    # ENSEIGNANT
    # --------------------------------------------------------

    if role == "teacher":

        return {
            "role": "teacher",
            "academic_year": academic_year,

            # Un enseignant peut demander plusieurs écoles.
            "can_choose_school": True,

            "memberships": school_data
        }

    # --------------------------------------------------------
    # APPRENANT
    # --------------------------------------------------------

    active_membership = next(
        (
            (membership, school)
            for membership, school in current_memberships
            if membership.status in ["pending", "approved"]
        ),
        None
    )

    return {
        "role": "student",
        "academic_year": academic_year,

        "can_choose_school": active_membership is None,

        "membership": (
            {
                "membership_id": active_membership[0].id,
                "school_id": active_membership[1].id,
                "school_name": active_membership[1].nom,
                "ville": active_membership[1].ville,
                "departement": active_membership[1].departement,
                "status": active_membership[0].status,
                "academic_year": active_membership[0].academic_year,
            }
            if active_membership
            else None
        ),

        "memberships": school_data
    }


# ============================================================
# 3. DEMANDER UNE ÉCOLE
# ============================================================

@router.post("/request")
def request_school(
    data: SchoolRequestCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Demande d'affectation à une école.

    Enseignant :
        peut demander plusieurs écoles pendant l'année.

    Apprenant :
        une seule école simultanément.
    """

    school = (
        db.query(School)
        .filter(
            School.id == data.school_id,
            School.is_active == True
        )
        .first()
    )

    if not school:
        raise HTTPException(
            status_code=404,
            detail="École introuvable ou inactive."
        )

    academic_year = get_current_academic_year()
    role = get_user_role(current_user)

    # --------------------------------------------------------
    # Vérifier une demande identique existante
    # --------------------------------------------------------

    existing = (
        db.query(SchoolMembership)
        .filter(
            SchoolMembership.user_id == current_user.id,
            SchoolMembership.school_id == school.id,
            SchoolMembership.academic_year == academic_year
        )
        .first()
    )

    if existing:

        if existing.status == "pending":
            raise HTTPException(
                status_code=400,
                detail=(
                    "Une demande pour cette école "
                    "est déjà en attente."
                )
            )

        if existing.status == "approved":
            raise HTTPException(
                status_code=400,
                detail="Vous appartenez déjà à cette école."
            )

        # ----------------------------------------------------
        # Si la demande précédente a été rejetée,
        # on autorise une nouvelle demande.
        # ----------------------------------------------------

        if existing.status == "rejected":

            existing.status = "pending"
            existing.requested_at = datetime.utcnow()

            existing.rejected_at = None
            existing.rejected_by = None

            existing.approved_at = None
            existing.approved_by = None

            existing.role = role

            db.commit()
            db.refresh(existing)

            return {
                "message": "Nouvelle demande envoyée.",
                "membership_id": existing.id,
                "school_id": school.id,
                "school_name": school.nom,
                "role": existing.role,
                "status": existing.status,
                "academic_year": existing.academic_year
            }

    # --------------------------------------------------------
    # RÈGLE APPRENANT
    # --------------------------------------------------------

    if role == "student":

        active_membership = (
            db.query(SchoolMembership)
            .filter(
                SchoolMembership.user_id == current_user.id,
                SchoolMembership.academic_year == academic_year,
                SchoolMembership.status.in_(
                    ["pending", "approved"]
                )
            )
            .first()
        )

        if active_membership:
            raise HTTPException(
                status_code=400,
                detail=(
                    "Vous avez déjà une école sélectionnée "
                    "ou une demande en attente pour cette "
                    "année scolaire."
                )
            )

    # --------------------------------------------------------
    # RÈGLE ENSEIGNANT
    # --------------------------------------------------------
    #
    # Aucun blocage supplémentaire.
    #
    # Un enseignant peut donc avoir :
    #
    # École A -> approved
    # École B -> approved
    # École C -> pending
    #
    # même en plein milieu de l'année.
    # --------------------------------------------------------

    membership = SchoolMembership(
        user_id=current_user.id,
        school_id=school.id,
        role=role,
        status="pending",
        academic_year=academic_year,
        requested_at=datetime.utcnow()
    )

    db.add(membership)
    db.commit()
    db.refresh(membership)

    return {
        "message": (
            "Demande d'école envoyée. "
            "Elle doit être validée par le directeur."
        ),
        "membership_id": membership.id,
        "school_id": school.id,
        "school_name": school.nom,
        "role": role,
        "status": "pending",
        "academic_year": academic_year
    }


# ============================================================
# 4. LISTE DES DEMANDES POUR UN DIRECTEUR
# ============================================================

@router.get("/director/requests")
def director_school_requests(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Le directeur ne voit que les demandes concernant
    son ou ses propres écoles.
    """

    director_records = (
        db.query(SchoolDirector)
        .filter(
            SchoolDirector.user_id == current_user.id,
            SchoolDirector.is_active == True
        )
        .all()
    )

    if not director_records:
        raise HTTPException(
            status_code=403,
            detail="Vous n'êtes directeur d'aucune école."
        )

    school_ids = [
        director.school_id
        for director in director_records
    ]

    rows = (
        db.query(
            SchoolMembership,
            User,
            School
        )
        .join(
            User,
            User.id == SchoolMembership.user_id
        )
        .join(
            School,
            School.id == SchoolMembership.school_id
        )
        .filter(
            SchoolMembership.school_id.in_(school_ids),
            SchoolMembership.status == "pending"
        )
        .order_by(
            SchoolMembership.requested_at.asc()
        )
        .all()
    )

    result = []

    for membership, user, school in rows:

        result.append({
            "membership_id": membership.id,

            "user": {
                "id": user.id,
                "nom": user.nom,
                "prenom": user.prenom,
                "email": user.email,
                "telephone": user.telephone,
                "enseignant": user.enseignant,
                "enseignant_actif": user.enseignant_actif,
            },

            "school": {
                "id": school.id,
                "nom": school.nom,
                "ville": school.ville,
                "departement": school.departement,
            },

            "role": membership.role,
            "status": membership.status,
            "academic_year": membership.academic_year,
            "requested_at": (
                membership.requested_at.isoformat()
                if membership.requested_at
                else None
            )
        })

    return {
        "requests": result
    }


# ============================================================
# 5. ACCEPTER / REFUSER UNE DEMANDE
# ============================================================

@router.post("/director/requests/{membership_id}/decision")
def director_decide_school_request(
    membership_id: int,
    data: SchoolDecisionRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Le directeur accepte ou refuse une demande.

    Le directeur ne peut agir que sur une demande
    concernant une école qu'il dirige actuellement.
    """

    decision = data.decision.lower().strip()

    if decision not in ["approved", "rejected"]:
        raise HTTPException(
            status_code=400,
            detail=(
                "La décision doit être "
                "'approved' ou 'rejected'."
            )
        )

    membership = (
        db.query(SchoolMembership)
        .filter(
            SchoolMembership.id == membership_id
        )
        .first()
    )

    if not membership:
        raise HTTPException(
            status_code=404,
            detail="Demande introuvable."
        )

    # --------------------------------------------------------
    # Vérification essentielle :
    # le directeur doit réellement diriger cette école.
    # --------------------------------------------------------

    verify_school_director(
        db=db,
        current_user=current_user,
        school_id=membership.school_id
    )

    if membership.status != "pending":
        raise HTTPException(
            status_code=400,
            detail="Cette demande a déjà été traitée."
        )

    now = datetime.utcnow()

    # ========================================================
    # APPROBATION
    # ========================================================

    if decision == "approved":

        user = (
            db.query(User)
            .filter(
                User.id == membership.user_id
            )
            .first()
        )

        if not user:
            raise HTTPException(
                status_code=404,
                detail="Utilisateur introuvable."
            )

        # ----------------------------------------------------
        # Protection supplémentaire pour les apprenants :
        # un apprenant ne peut pas avoir deux écoles
        # approuvées pendant la même année scolaire.
        # ----------------------------------------------------

        if not user.enseignant:

            other_membership = (
                db.query(SchoolMembership)
                .filter(
                    SchoolMembership.user_id == user.id,
                    SchoolMembership.academic_year == (
                        membership.academic_year
                    ),
                    SchoolMembership.status == "approved",
                    SchoolMembership.id != membership.id
                )
                .first()
            )

            if other_membership:

                raise HTTPException(
                    status_code=400,
                    detail=(
                        "Cet apprenant possède déjà une école "
                        "validée pour cette année scolaire."
                    )
                )

        membership.status = "approved"
        membership.approved_at = now
        membership.approved_by = current_user.id

        membership.rejected_at = None
        membership.rejected_by = None

    # ========================================================
    # REFUS
    # ========================================================

    else:

        membership.status = "rejected"

        membership.rejected_at = now
        membership.rejected_by = current_user.id

        membership.approved_at = None
        membership.approved_by = None

    db.commit()
    db.refresh(membership)

    return {
        "message": (
            "Demande acceptée."
            if decision == "approved"
            else "Demande refusée."
        ),
        "membership_id": membership.id,
        "status": membership.status
    }


# ============================================================
# 6. ENSEIGNANTS DE L'ÉCOLE DU DIRECTEUR
# ============================================================

@router.get("/director/{school_id}/teachers")
def director_teachers(
    school_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retourne uniquement les enseignants appartenant
    à l'école concernée.

    Le directeur doit diriger cette école.
    """

    verify_school_director(
        db=db,
        current_user=current_user,
        school_id=school_id
    )

    rows = (
        db.query(
            User,
            SchoolMembership
        )
        .join(
            SchoolMembership,
            SchoolMembership.user_id == User.id
        )
        .filter(
            SchoolMembership.school_id == school_id,
            SchoolMembership.role == "teacher",
            SchoolMembership.status == "approved"
        )
        .order_by(
            User.nom.asc(),
            User.prenom.asc()
        )
        .all()
    )

    result = []

    for user, membership in rows:

        result.append({
            "id": user.id,
            "nom": user.nom,
            "prenom": user.prenom,
            "email": user.email,
            "telephone": user.telephone,
            "enseignant": user.enseignant,
            "enseignant_actif": user.enseignant_actif,
            "school_membership_id": membership.id,
            "academic_year": membership.academic_year,
        })

    return {
        "school_id": school_id,
        "teachers": result
    }


# ============================================================
# 7. APPRENANTS DE L'ÉCOLE DU DIRECTEUR
# ============================================================

@router.get("/director/{school_id}/students")
def director_students(
    school_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retourne uniquement les apprenants appartenant
    à l'école du directeur.
    """

    verify_school_director(
        db=db,
        current_user=current_user,
        school_id=school_id
    )

    rows = (
        db.query(
            User,
            SchoolMembership
        )
        .join(
            SchoolMembership,
            SchoolMembership.user_id == User.id
        )
        .filter(
            SchoolMembership.school_id == school_id,
            SchoolMembership.role == "student",
            SchoolMembership.status == "approved"
        )
        .order_by(
            User.nom.asc(),
            User.prenom.asc()
        )
        .all()
    )

    result = []

    for user, membership in rows:

        result.append({
            "id": user.id,
            "nom": user.nom,
            "prenom": user.prenom,
            "email": user.email,
            "telephone": user.telephone,
            "school_membership_id": membership.id,
            "academic_year": membership.academic_year,
        })

    return {
        "school_id": school_id,
        "students": result
    }


# ============================================================
# 8. ÉCOLES DIRIGÉES PAR LE DIRECTEUR
# ============================================================

@router.get("/director/my-schools")
def director_my_schools(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retourne les écoles dont l'utilisateur est directeur actif.
    """

    rows = (
        db.query(
            SchoolDirector,
            School
        )
        .join(
            School,
            School.id == SchoolDirector.school_id
        )
        .filter(
            SchoolDirector.user_id == current_user.id,
            SchoolDirector.is_active == True
        )
        .order_by(
            School.nom.asc()
        )
        .all()
    )

    result = []

    for director, school in rows:

        result.append({
            "id": school.id,
            "nom": school.nom,
            "adresse": school.adresse,
            "ville": school.ville,
            "departement": school.departement,
            "pays": school.pays,
            "type_enseignement": school.type_enseignement,
            "statut": school.statut,
            "email": school.email,
            "telephone": school.telephone,
            "is_active": school.is_active,
            "director_id": director.id,
            "assigned_at": (
                director.assigned_at.isoformat()
                if director.assigned_at
                else None
            ),
        })

    return {
        "schools": result
    }


# ============================================================
# 9. CRÉATION D'UNE ÉCOLE
# ============================================================

@router.post("/admin/create")
def create_school(
    data: SchoolCreateRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Seul un administrateur global de CODE peut créer
    une école.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs CODE."
        )

    # --------------------------------------------------------
    # Nettoyage des données
    # --------------------------------------------------------

    school_name = data.nom.strip()

    if not school_name:
        raise HTTPException(
            status_code=400,
            detail="Le nom de l'école est obligatoire."
        )

    adresse = clean_optional_text(data.adresse)
    ville = clean_optional_text(data.ville)
    departement = clean_optional_text(data.departement)
    pays = clean_optional_text(data.pays) or "Bénin"
    type_enseignement = clean_optional_text(
        data.type_enseignement
    )
    statut = clean_optional_text(data.statut)
    email = clean_optional_text(data.email)
    telephone = clean_optional_text(data.telephone)

    # --------------------------------------------------------
    # Vérifier les doublons
    # --------------------------------------------------------

    existing = (
        db.query(School)
        .filter(
            School.nom == school_name,
            School.ville == ville,
            School.departement == departement
        )
        .first()
    )

    if existing:
        raise HTTPException(
            status_code=400,
            detail=(
                "Cette école existe déjà dans cette ville "
                "et ce département."
            )
        )

    # --------------------------------------------------------
    # Création
    # --------------------------------------------------------

    school = School(
        nom=school_name,
        adresse=adresse,
        ville=ville,
        departement=departement,
        pays=pays,
        type_enseignement=type_enseignement,
        statut=statut,
        email=email,
        telephone=telephone,
        is_active=True
    )

    db.add(school)
    db.commit()
    db.refresh(school)

    return {
        "message": "École créée avec succès.",
        "school": {
            "id": school.id,
            "nom": school.nom,
            "adresse": school.adresse,
            "ville": school.ville,
            "departement": school.departement,
            "pays": school.pays,
            "type_enseignement": school.type_enseignement,
            "statut": school.statut,
            "email": school.email,
            "telephone": school.telephone,
            "is_active": school.is_active,
        }
    }


# ============================================================
# 10. DÉSIGNER UN DIRECTEUR
# ============================================================

@router.post("/admin/{school_id}/director")
def assign_school_director(
    school_id: int,
    data: DirectorAssignRequest,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Seul un administrateur global CODE peut désigner
    le directeur d'une école.

    Règles :
        - le directeur doit être un enseignant actif ;
        - il reste enseignant ;
        - il est automatiquement rattaché à l'école
          comme enseignant approuvé ;
        - une école ne peut avoir qu'un seul directeur actif.
    """

    # --------------------------------------------------------
    # ADMIN GLOBAL
    # --------------------------------------------------------

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs CODE."
        )

    # --------------------------------------------------------
    # VÉRIFIER L'ÉCOLE
    # --------------------------------------------------------

    school = (
        db.query(School)
        .filter(
            School.id == school_id
        )
        .first()
    )

    if not school:
        raise HTTPException(
            status_code=404,
            detail="École introuvable."
        )

    if not school.is_active:
        raise HTTPException(
            status_code=400,
            detail="Impossible de désigner un directeur pour une école inactive."
        )

    # --------------------------------------------------------
    # VÉRIFIER L'UTILISATEUR
    # --------------------------------------------------------

    user = (
        db.query(User)
        .filter(
            User.id == data.user_id
        )
        .first()
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable."
        )

    # --------------------------------------------------------
    # LE DIRECTEUR DOIT ÊTRE UN ENSEIGNANT ACTIF
    # --------------------------------------------------------

    if not user.enseignant or not user.enseignant_actif:
        raise HTTPException(
            status_code=400,
            detail=(
                "Le directeur doit être un enseignant actif "
                "sur CODE."
            )
        )

    # --------------------------------------------------------
    # VÉRIFIER S'IL EXISTE DÉJÀ UN DIRECTEUR ACTIF
    # --------------------------------------------------------

    existing_active = get_director_for_school(
        db=db,
        school_id=school_id
    )

    if existing_active:

        if existing_active.user_id == user.id:
            raise HTTPException(
                status_code=400,
                detail=(
                    "Cet utilisateur est déjà directeur actif "
                    "de cette école."
                )
            )

        raise HTTPException(
            status_code=400,
            detail="Cette école possède déjà un directeur actif."
        )

    # --------------------------------------------------------
    # ANNÉE SCOLAIRE COURANTE
    # --------------------------------------------------------

    academic_year = get_current_academic_year()
    now = datetime.utcnow()

    # --------------------------------------------------------
    # VÉRIFIER / CRÉER LE RATTACHEMENT ENSEIGNANT
    # --------------------------------------------------------

    membership = (
        db.query(SchoolMembership)
        .filter(
            SchoolMembership.user_id == user.id,
            SchoolMembership.school_id == school.id,
            SchoolMembership.academic_year == academic_year
        )
        .first()
    )

    if membership:

        membership.role = "teacher"
        membership.status = "approved"

        membership.approved_at = now
        membership.approved_by = current_user.id

        membership.rejected_at = None
        membership.rejected_by = None

    else:

        membership = SchoolMembership(
            user_id=user.id,
            school_id=school.id,
            role="teacher",
            status="approved",
            academic_year=academic_year,
            requested_at=now,
            approved_at=now,
            approved_by=current_user.id
        )

        db.add(membership)
        db.flush()

    # --------------------------------------------------------
    # CRÉER LA DIRECTION
    # --------------------------------------------------------

    director = SchoolDirector(
        user_id=user.id,
        school_id=school.id,
        is_active=True,
        assigned_at=now,
        assigned_by=current_user.id
    )

    db.add(director)

    # --------------------------------------------------------
    # ENREGISTRER
    # --------------------------------------------------------

    db.commit()
    db.refresh(director)

    return {
        "message": "Directeur désigné avec succès.",
        "school_id": school.id,
        "school_name": school.nom,
        "user_id": user.id,
        "role": "teacher",
        "is_director": True,
        "academic_year": academic_year,
        "membership_id": membership.id,
        "director_id": director.id
    }


# ============================================================
# 11. RETIRER UN ENSEIGNANT D'UNE ÉCOLE
# ============================================================

@router.delete(
    "/director/{school_id}/teachers/{user_id}"
)
def remove_teacher_from_school(
    school_id: int,
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Retire un enseignant de cette école uniquement.

    IMPORTANT :
        Cette opération ne désactive PAS son compte CODE.

    L'enseignant peut donc continuer à enseigner dans :
        - CODE globalement ;
        - d'autres écoles auxquelles il appartient.

    Le directeur ne peut agir que sur sa propre école.
    """

    verify_school_director(
        db=db,
        current_user=current_user,
        school_id=school_id
    )

    # --------------------------------------------------------
    # Vérifier l'utilisateur
    # --------------------------------------------------------

    user = (
        db.query(User)
        .filter(
            User.id == user_id
        )
        .first()
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable."
        )

    # --------------------------------------------------------
    # Empêcher le directeur de se retirer lui-même
    # de son école avec cet endpoint.
    # --------------------------------------------------------

    if user_id == current_user.id:
        raise HTTPException(
            status_code=400,
            detail=(
                "Le directeur ne peut pas se retirer lui-même "
                "de cette école."
            )
        )

    # --------------------------------------------------------
    # Chercher l'appartenance active.
    #
    # On cible l'année scolaire courante.
    # --------------------------------------------------------

    academic_year = get_current_academic_year()

    membership = (
        db.query(SchoolMembership)
        .filter(
            SchoolMembership.user_id == user_id,
            SchoolMembership.school_id == school_id,
            SchoolMembership.academic_year == academic_year,
            SchoolMembership.role == "teacher",
            SchoolMembership.status == "approved"
        )
        .first()
    )

    if not membership:
        raise HTTPException(
            status_code=404,
            detail=(
                "Cet enseignant n'est pas rattaché "
                "à cette école pour l'année scolaire courante."
            )
        )

    # --------------------------------------------------------
    # On ne modifie PAS :
    #
    # user.enseignant
    # user.enseignant_actif
    #
    # Le compte enseignant CODE reste donc actif.
    # --------------------------------------------------------

    membership.status = "rejected"
    membership.rejected_at = datetime.utcnow()
    membership.rejected_by = current_user.id

    membership.approved_at = None
    membership.approved_by = None

    db.commit()

    return {
        "message": (
            "L'enseignant a été retiré de cette école. "
            "Son compte enseignant CODE reste actif."
        ),
        "school_id": school_id,
        "user_id": user_id,
        "academic_year": academic_year,
        "teacher_account_active": (
            user.enseignant and user.enseignant_actif
        )
    }


# ============================================================
# 12. DÉSACTIVER LE DIRECTEUR D'UNE ÉCOLE
# ============================================================

@router.delete(
    "/admin/{school_id}/director"
)
def deactivate_school_director(
    school_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Désactive le directeur actuel d'une école.

    Cette opération :
        - retire son statut de directeur pour cette école ;
        - conserve son compte CODE ;
        - conserve son statut global d'enseignant ;
        - conserve son appartenance comme enseignant à l'école.

    Un nouvel administrateur peut ensuite désigner
    un autre directeur.
    """

    # --------------------------------------------------------
    # ADMIN GLOBAL
    # --------------------------------------------------------

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs CODE."
        )

    # --------------------------------------------------------
    # ÉCOLE
    # --------------------------------------------------------

    school = (
        db.query(School)
        .filter(
            School.id == school_id
        )
        .first()
    )

    if not school:
        raise HTTPException(
            status_code=404,
            detail="École introuvable."
        )

    # --------------------------------------------------------
    # DIRECTEUR ACTIF
    # --------------------------------------------------------

    director = get_director_for_school(
        db=db,
        school_id=school_id
    )

    if not director:
        raise HTTPException(
            status_code=404,
            detail="Cette école n'a aucun directeur actif."
        )

    director.is_active = False

    db.commit()
    db.refresh(director)

    return {
        "message": "Directeur désactivé avec succès.",
        "school_id": school.id,
        "school_name": school.nom,
        "user_id": director.user_id,
        "director_id": director.id,
        "is_active": director.is_active
    }


# ============================================================
# 13. RÉACTIVER UNE ÉCOLE
# ============================================================

@router.patch(
    "/admin/{school_id}/activate"
)
def activate_school(
    school_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Réactive une école désactivée.

    Seul un administrateur global peut effectuer cette opération.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs CODE."
        )

    school = (
        db.query(School)
        .filter(
            School.id == school_id
        )
        .first()
    )

    if not school:
        raise HTTPException(
            status_code=404,
            detail="École introuvable."
        )

    if school.is_active:
        return {
            "message": "Cette école est déjà active.",
            "school_id": school.id,
            "is_active": True
        }

    school.is_active = True

    db.commit()
    db.refresh(school)

    return {
        "message": "École réactivée avec succès.",
        "school_id": school.id,
        "school_name": school.nom,
        "is_active": school.is_active
    }


# ============================================================
# 14. DÉSACTIVER UNE ÉCOLE
# ============================================================

@router.patch(
    "/admin/{school_id}/deactivate"
)
def deactivate_school(
    school_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    """
    Désactive une école.

    Les données historiques restent dans la base.
    Les appartenances existantes ne sont pas supprimées.

    L'école ne sera simplement plus proposée dans
    la liste des écoles actives.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs CODE."
        )

    school = (
        db.query(School)
        .filter(
            School.id == school_id
        )
        .first()
    )

    if not school:
        raise HTTPException(
            status_code=404,
            detail="École introuvable."
        )

    if not school.is_active:
        return {
            "message": "Cette école est déjà inactive.",
            "school_id": school.id,
            "is_active": False
        }

    school.is_active = False

    db.commit()
    db.refresh(school)

    return {
        "message": "École désactivée avec succès.",
        "school_id": school.id,
        "school_name": school.nom,
        "is_active": school.is_active
    }