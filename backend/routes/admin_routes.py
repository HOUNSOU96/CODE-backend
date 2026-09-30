from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from typing import List, Optional
from pydantic import BaseModel
import uuid
import os

from sqlalchemy import func

from database import get_db
from dependencies import get_current_user

from routes.auth import create_access_token

from models.user import User, UserStatus
from models.connection_log import UserConnectionLog
from models.document_activation import DocumentActivation

# ---------------------------------------------------------
# ÉCOLES
# ---------------------------------------------------------
from models.school import School, SchoolDirector, SchoolMembership

from utils.email import send_email, send_email_sync


router = APIRouter(
    prefix="/api/admin",
    tags=["admin"]
)


# ==========================================================
# MOT DE PASSE ADMIN
# ==========================================================

ADMIN_CODE = "MOraVi"


# ==========================================================
# EMAIL EXCLU DE LA LISTE
# ==========================================================

EXCLUDED_ADMIN_EMAIL = "deogratiashounsou@gmail.com"


# ==========================================================
# MODÈLES PYDANTIC
# ==========================================================

class AdminCode(BaseModel):
    password: str


class ConnectionRecord(BaseModel):
    id: int
    nom: str
    prenom: str
    date: str
    heure_connexion: str
    heure_deconnexion: str


# ==========================================================
# OUTILS D'AUTORISATION
# ==========================================================

def get_director_school_ids(
    current_user: User,
    db: Session
) -> List[int]:
    """
    Retourne les IDs des écoles dont l'utilisateur
    est actuellement directeur.

    Un utilisateur peut être directeur de plusieurs écoles.
    """

    rows = (
        db.query(SchoolDirector.school_id)
        .filter(
            SchoolDirector.user_id == current_user.id,
            SchoolDirector.is_active == True
        )
        .all()
    )

    return [
        row.school_id
        for row in rows
    ]


def is_school_director(
    current_user: User,
    db: Session
) -> bool:
    """
    Vérifie si l'utilisateur est directeur actif
    d'au moins une école.
    """

    return (
        db.query(SchoolDirector.id)
        .filter(
            SchoolDirector.user_id == current_user.id,
            SchoolDirector.is_active == True
        )
        .first()
        is not None
    )


def can_access_admin_area(
    current_user: User,
    db: Session
) -> bool:
    """
    Autorise :
    - les administrateurs globaux
    - les directeurs d'école actifs
    """

    if current_user.is_admin:
        return True

    return is_school_director(
        current_user,
        db
    )


def require_admin_or_director(
    current_user: User,
    db: Session
):
    """
    Vérification commune pour les routes accessibles
    aux administrateurs globaux et aux directeurs.
    """

    if not can_access_admin_area(
        current_user,
        db
    ):
        raise HTTPException(
            status_code=403,
            detail=(
                "Accès réservé aux administrateurs "
                "et aux directeurs d'école."
            )
        )


def director_can_manage_user(
    current_user: User,
    target_user: User,
    db: Session
) -> bool:
    """
    Détermine si l'utilisateur connecté peut gérer
    l'utilisateur cible.

    Règles :

    1. Un administrateur global peut tout gérer.
    2. Un directeur peut gérer uniquement les utilisateurs
       appartenant à au moins une de ses écoles.
    3. Un directeur ne peut pas gérer un administrateur global.
    """

    # ------------------------------------------------------
    # Administrateur global
    # ------------------------------------------------------

    if current_user.is_admin:
        return True

    # ------------------------------------------------------
    # Un directeur ne doit pas pouvoir gérer un autre
    # administrateur global.
    # ------------------------------------------------------

    if target_user.is_admin:
        return False

    # ------------------------------------------------------
    # Écoles dirigées par le directeur
    # ------------------------------------------------------

    director_school_ids = get_director_school_ids(
        current_user,
        db
    )

    if not director_school_ids:
        return False

    # ------------------------------------------------------
    # Vérification de l'appartenance de l'utilisateur
    # à une des écoles du directeur.
    #
    # On utilise uniquement les adhésions approuvées.
    # ------------------------------------------------------

    membership = (
        db.query(SchoolMembership.id)
        .filter(
            SchoolMembership.user_id == target_user.id,
            SchoolMembership.school_id.in_(
                director_school_ids
            ),
            SchoolMembership.status == "approved"
        )
        .first()
    )

    return membership is not None


def ensure_can_manage_user(
    current_user: User,
    target_user: User,
    db: Session
):
    """
    Lève une erreur 403 si l'utilisateur connecté
    n'a pas le droit de gérer la cible.
    """

    if not director_can_manage_user(
        current_user,
        target_user,
        db
    ):
        raise HTTPException(
            status_code=403,
            detail=(
                "Vous n'êtes pas autorisé à gérer "
                "cet utilisateur."
            )
        )


# ==========================================================
# VÉRIFIER QU'UN DIRECTEUR GÈRE UNE ÉCOLE
# ==========================================================

def ensure_director_of_school(
    current_user: User,
    school_id: int,
    db: Session
):
    """
    Vérifie que l'utilisateur connecté est directeur actif
    de l'école demandée.

    Un administrateur global passe directement.
    """

    if current_user.is_admin:
        return

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
            detail=(
                "Vous n'êtes pas directeur actif "
                "de cette école."
            )
        )


# ==========================================================
# FONCTION D'ENVOI DES EMAILS AUX ADMINS
# ==========================================================

def send_admin_validation_emails(
    new_user: User,
    background_tasks: BackgroundTasks,
    db: Session
):

    admins = (
        db.query(User)
        .filter(
            User.is_admin == True
        )
        .all()
    )

    for admin in admins:

        subject = "Nouvelle inscription CODE à valider"

        accept_link = (
            f"{os.getenv('FRONTEND_URL')}"
            f"/api/admin/validate/"
            f"{new_user.validation_token}/accept"
        )

        reject_link = (
            f"{os.getenv('FRONTEND_URL')}"
            f"/api/admin/validate/"
            f"{new_user.validation_token}/reject"
        )

        content = (
            f"Bonjour {admin.nom},\n\n"
            f"Nouvelle inscription de "
            f"{new_user.nom} {new_user.prenom} "
            f"({new_user.email}).\n\n"
            f"Pour VALIDER : {accept_link}\n"
            f"Pour REFUSER : {reject_link}\n\n"
            "Cordialement,\n"
            "L'équipe CODE"
        )

        background_tasks.add_task(
            send_email_sync,
            to=admin.email,
            subject=subject,
            body=content
        )

        print(
            f"[DEBUG] Email envoyé à "
            f"{admin.email} pour {new_user.email}"
        )


# ==========================================================
# LISTE DES INSCRITS
# ==========================================================

@router.get("/liste-inscrits")
def liste_inscrits(
    page: int = 1,
    page_size: int = 10,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    # ------------------------------------------------------
    # Vérification des droits
    # ------------------------------------------------------

    require_admin_or_director(
        current_user,
        db
    )

    # ------------------------------------------------------
    # Sécurité pagination
    # ------------------------------------------------------

    if page < 1:
        page = 1

    if page_size < 1:
        page_size = 10

    if page_size > 100:
        page_size = 100

    # ------------------------------------------------------
    # Requête de base
    # ------------------------------------------------------

    query = (
        db.query(
            User,
            func.count(
                DocumentActivation.id
            ).label("documents_count")
        )
        .outerjoin(
            DocumentActivation,
            DocumentActivation.user_id == User.id
        )
    )

    # ------------------------------------------------------
    # ADMIN GLOBAL
    #
    # L'administrateur voit tous les utilisateurs.
    # ------------------------------------------------------

    if current_user.is_admin:

        query = query.filter(
            User.email != EXCLUDED_ADMIN_EMAIL
        )

    # ------------------------------------------------------
    # DIRECTEUR
    #
    # Le directeur voit uniquement les utilisateurs
    # appartenant à ses écoles.
    # ------------------------------------------------------

    else:

        director_school_ids = get_director_school_ids(
            current_user,
            db
        )

        if not director_school_ids:
            raise HTTPException(
                status_code=403,
                detail=(
                    "Aucune école active ne vous est "
                    "attribuée en tant que directeur."
                )
            )

        query = (
            query
            .join(
                SchoolMembership,
                SchoolMembership.user_id == User.id
            )
            .filter(
                SchoolMembership.school_id.in_(
                    director_school_ids
                ),
                SchoolMembership.status == "approved",
                User.email != EXCLUDED_ADMIN_EMAIL,
                User.is_admin == False
            )
        )

    # ------------------------------------------------------
    # GROUP BY / ORDER BY
    # ------------------------------------------------------

    query = (
        query
        .group_by(User.id)
        .order_by(
            func.count(
                DocumentActivation.id
            ).desc(),
            User.created_at.desc()
        )
    )

    # ------------------------------------------------------
    # TOTAL
    # ------------------------------------------------------

    total = query.count()

    # ------------------------------------------------------
    # PAGINATION
    # ------------------------------------------------------

    results = (
        query
        .offset(
            (page - 1) * page_size
        )
        .limit(page_size)
        .all()
    )

    online_threshold = (
        datetime.utcnow()
        - timedelta(minutes=1)
    )

    data = []

    # ======================================================
    # CONSTRUCTION DES DONNÉES
    # ======================================================

    for user, documents_count in results:

        # --------------------------------------------------
        # FILLEULS
        # --------------------------------------------------

        filleuls = (
            db.query(User.email)
            .filter(
                User.parrain_email == user.email
            )
            .all()
        )

        # --------------------------------------------------
        # DOCUMENTS
        # --------------------------------------------------

        documents = (
            db.query(DocumentActivation)
            .filter(
                DocumentActivation.user_id == user.id
            )
            .order_by(
                DocumentActivation.activated_at.desc(),
                DocumentActivation.id.desc()
            )
            .all()
        )

        documents_data = [
            {
                "id": document.id,

                "document_name":
                    document.document_name,

                "activation_code":
                    document.activation_code,

                "is_activated":
                    document.is_activated,

                "activated_at": (
                    document.activated_at.isoformat()
                    if document.activated_at
                    else None
                ),

                "activation_type":
                    document.activation_type,
            }
            for document in documents
        ]

        # --------------------------------------------------
        # ÉCOLES DE L'UTILISATEUR
        #
        # Deux sources sont prises en compte :
        #
        # 1. SchoolMembership
        # 2. SchoolDirector
        #
        # Cela permet à l'admin CODE de voir les écoles
        # d'un apprenant, d'un enseignant ou d'un directeur.
        # --------------------------------------------------

        schools_data = []

        # ==================================================
        # 1. ÉCOLES VIA SCHOOL MEMBERSHIP
        # ==================================================

        memberships = (
            db.query(SchoolMembership)
            .filter(
                SchoolMembership.user_id == user.id
            )
            .all()
        )

        for membership in memberships:

            school = (
                db.query(School)
                .filter(
                    School.id == membership.school_id
                )
                .first()
            )

            if not school:
                continue

            schools_data.append(
                {
                    "school_id":
                        school.id,

                    "school_name":
                        school.nom,

                    "role":
                        membership.role,

                    "status":
                        membership.status,

                    "academic_year":
                        membership.academic_year,

                    "is_director":
                        False,
                }
            )

        # ==================================================
        # 2. ÉCOLES DIRIGÉES
        # ==================================================

        directorships = (
            db.query(SchoolDirector)
            .filter(
                SchoolDirector.user_id == user.id,
                SchoolDirector.is_active == True
            )
            .all()
        )

        for directorship in directorships:

            school = (
                db.query(School)
                .filter(
                    School.id == directorship.school_id
                )
                .first()
            )

            if not school:
                continue

            existing_school = None

            for item in schools_data:

                if (
                    item["school_id"]
                    == school.id
                ):
                    existing_school = item
                    break

            # ----------------------------------------------
            # L'école existe déjà via SchoolMembership.
            # On la marque simplement comme école dirigée.
            # ----------------------------------------------

            if existing_school:

                existing_school[
                    "is_director"
                ] = True

                # Si l'utilisateur a une adhésion normale
                # et une direction, on conserve la direction
                # comme information principale du rôle.
                existing_school[
                    "role"
                ] = "director"

                existing_school[
                    "status"
                ] = "approved"

            # ----------------------------------------------
            # Sinon on ajoute directement l'école.
            # ----------------------------------------------

            else:

                schools_data.append(
                    {
                        "school_id":
                            school.id,

                        "school_name":
                            school.nom,

                        "role":
                            "director",

                        "status":
                            "approved",

                        "academic_year":
                            None,

                        "is_director":
                            True,
                    }
                )

        # --------------------------------------------------
        # INFORMATIONS UTILISATEUR
        # --------------------------------------------------

        user_data = {

            "id":
                user.id,

            "nom":
                user.nom,

            "prenom":
                user.prenom,

            "email":
                user.email,

            "telephone":
                user.telephone,

            "is_validated":
                user.is_validated,

            "status": (
                user.status
                if user.status
                else UserStatus.ACTIVE.value
            ),

            "is_admin":
                user.is_admin,

            "is_blocked":
                user.is_blocked,

            "last_warning":
                user.last_warning,

            "parrain_email":
                user.parrain_email,

            "pays_residence":
                user.pays_residence,

            "date_inscription": (
                user.created_at
                if hasattr(
                    user,
                    "created_at"
                )
                else None
            ),

            "is_online":
                bool(
                    user.last_seen
                    and user.last_seen >
                    online_threshold
                ),

            "filleuls_emails": [
                f[0]
                for f in filleuls
            ],

            "documents":
                documents_data,

            "documents_count":
                documents_count,

            "schools":
                schools_data,
        }

        data.append(
            user_data
        )

    return {
        "total":
            total,

        "inscrits":
            data,
    }


# ==========================================================
# RETIRER UN ENSEIGNANT D'UNE ÉCOLE
# ==========================================================

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
    Retire uniquement l'enseignant de l'école.

    IMPORTANT :
    Cette route ne supprime PAS le compte utilisateur CODE.

    Elle supprime uniquement son SchoolMembership
    dans l'école concernée.

    Un administrateur global peut également utiliser cette route.
    Un directeur ne peut l'utiliser que pour une école
    qu'il dirige activement.
    """

    # ------------------------------------------------------
    # Vérifier l'existence de l'école
    # ------------------------------------------------------

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

    # ------------------------------------------------------
    # Vérifier les droits sur cette école
    # ------------------------------------------------------

    ensure_director_of_school(
        current_user,
        school_id,
        db
    )

    # ------------------------------------------------------
    # Vérifier l'utilisateur cible
    # ------------------------------------------------------

    target_user = (
        db.query(User)
        .filter(
            User.id == user_id
        )
        .first()
    )

    if not target_user:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable."
        )

    # ------------------------------------------------------
    # Un directeur ne peut pas retirer un administrateur
    # global.
    # ------------------------------------------------------

    if (
        not current_user.is_admin
        and target_user.is_admin
    ):
        raise HTTPException(
            status_code=403,
            detail=(
                "Un administrateur global ne peut pas "
                "être retiré d'une école par un directeur."
            )
        )

    # ------------------------------------------------------
    # Rechercher l'adhésion de l'utilisateur dans l'école
    # ------------------------------------------------------

    membership = (
        db.query(SchoolMembership)
        .filter(
            SchoolMembership.user_id == user_id,
            SchoolMembership.school_id == school_id,
            SchoolMembership.status == "approved"
        )
        .first()
    )

    if not membership:
        raise HTTPException(
            status_code=404,
            detail=(
                "Cet utilisateur n'est pas membre actif "
                "de cette école."
            )
        )

    # ------------------------------------------------------
    # Vérifier qu'il s'agit bien d'un enseignant
    # ------------------------------------------------------

    if membership.role != "teacher":
        raise HTTPException(
            status_code=400,
            detail=(
                "Cet utilisateur n'est pas enregistré "
                "comme enseignant dans cette école."
            )
        )

    # ------------------------------------------------------
    # Vérifier si l'utilisateur est directeur actif
    # de cette école.
    #
    # On ne supprime pas la direction avec cette route.
    # ------------------------------------------------------

    active_directorship = (
        db.query(SchoolDirector.id)
        .filter(
            SchoolDirector.user_id == user_id,
            SchoolDirector.school_id == school_id,
            SchoolDirector.is_active == True
        )
        .first()
    )

    if active_directorship:
        raise HTTPException(
            status_code=400,
            detail=(
                "Cet utilisateur est également directeur "
                "de cette école. Utilisez la gestion "
                "des directeurs pour modifier sa direction."
            )
        )

    # ------------------------------------------------------
    # Suppression de l'adhésion uniquement
    # ------------------------------------------------------

    teacher_name = (
        f"{target_user.nom} "
        f"{target_user.prenom}"
    )

    db.delete(membership)
    db.commit()

    return {
        "message": (
            f"{teacher_name} a été retiré de "
            f"l'école {school.nom}."
        ),

        "user_id":
            user_id,

        "school_id":
            school_id,

        "school_name":
            school.nom,
    }


# ==========================================================
# DOCUMENTS ACTIVÉS / ASSOCIÉS
# ==========================================================

@router.get("/documents")
def get_admin_documents(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    """
    Retourne les documents connus dans DocumentActivation
    avec les informations du bénéficiaire lorsqu'ils sont activés.

    Cette fonctionnalité reste réservée à l'administrateur
    global, car elle concerne l'ensemble des documents CODE.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    activations = (
        db.query(DocumentActivation)
        .order_by(
            DocumentActivation.id.asc()
        )
        .all()
    )

    result = []

    for index, activation in enumerate(
        activations,
        start=1
    ):

        user = None

        if activation.user_id:

            user = (
                db.query(User)
                .filter(
                    User.id == activation.user_id
                )
                .first()
            )

        result.append(
            {
                "numero":
                    index,

                "document_name":
                    activation.document_name,

                "user_id":
                    activation.user_id,

                "nom":
                    user.nom
                    if user
                    else None,

                "prenom":
                    user.prenom
                    if user
                    else None,

                "email": (
                    user.email
                    if user
                    else activation.beneficiary_email
                ),

                "telephone": (
                    user.telephone
                    if user
                    else None
                ),

                "is_activated":
                    bool(
                        activation.is_activated
                    ),

                "activation_code":
                    activation.activation_code,

                "buyer_email":
                    activation.buyer_email,

                "beneficiary_email":
                    activation.beneficiary_email,

                "activation_type":
                    activation.activation_type,

                "activated_at": (
                    activation.activated_at.isoformat()
                    if activation.activated_at
                    else None
                )
            }
        )

    return result


# ==========================================================
# CODES D'ACTIVATION
# ==========================================================

@router.get("/activation-codes")
def get_admin_activation_codes(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    """
    Retourne tous les codes d'activation avec leur état
    et les informations d'utilisation.

    Réservé à l'administrateur global.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    activations = (
        db.query(DocumentActivation)
        .order_by(
            DocumentActivation.id.asc()
        )
        .all()
    )

    result = []

    for index, activation in enumerate(
        activations,
        start=1
    ):

        result.append(
            {
                "id":
                    activation.id,

                "numero":
                    index,

                "activation_code":
                    activation.activation_code,

                "document_name":
                    activation.document_name,

                "buyer_email":
                    activation.buyer_email,

                "beneficiary_email":
                    activation.beneficiary_email,

                "user_id":
                    activation.user_id,

                "is_activated":
                    bool(
                        activation.is_activated
                    ),

                "activated_at": (
                    activation.activated_at.isoformat()
                    if activation.activated_at
                    else None
                ),

                "activation_type":
                    activation.activation_type
            }
        )

    return result


# ==========================================================
# HISTORIQUE DES CONNEXIONS
# ==========================================================

@router.get(
    "/historique-connections",
    response_model=List[ConnectionRecord]
)
def get_historique_connections(
    date: Optional[str] = None,
    limit: int = 500,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    """
    Historique global des connexions.

    Réservé à l'administrateur global.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès admin requis"
        )

    query = db.query(
        UserConnectionLog
    )

    if date:

        try:

            date_obj = datetime.strptime(
                date,
                "%Y-%m-%d"
            ).date()

            query = query.filter(
                UserConnectionLog.date == date_obj
            )

        except ValueError:

            raise HTTPException(
                status_code=400,
                detail="Format date invalide"
            )

    logs = (
        query
        .order_by(
            UserConnectionLog.date.desc(),
            UserConnectionLog.heure_connexion.desc()
        )
        .limit(limit)
        .all()
    )

    results = []

    for log in logs:

        results.append(
            ConnectionRecord(
                id=log.user.id,

                nom=log.user.nom,

                prenom=log.user.prenom,

                date=log.date.strftime(
                    "%Y-%m-%d"
                ),

                heure_connexion=
                    log.heure_connexion.strftime(
                        "%H:%M"
                    ),

                heure_deconnexion=(
                    log.heure_deconnexion.strftime(
                        "%H:%M"
                    )
                    if log.heure_deconnexion
                    else "-"
                )
            )
        )

    return results


# ==========================================================
# CRÉATION UTILISATEUR ADMIN
# ==========================================================

@router.post("/create-user")
def create_user(
    user_data: dict,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    """
    Création manuelle d'un utilisateur.

    Réservée à l'administrateur global.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    if (
        not user_data.get("email")
        or not user_data.get("nom")
        or not user_data.get("prenom")
    ):
        raise HTTPException(
            status_code=400,
            detail=(
                "Les champs nom, prénom et email "
                "sont obligatoires."
            )
        )

    if (
        db.query(User)
        .filter(
            User.email == user_data["email"]
        )
        .first()
    ):
        raise HTTPException(
            status_code=400,
            detail="Email déjà utilisé"
        )

    new_user = User(
        nom=user_data["nom"],
        prenom=user_data["prenom"],
        email=user_data["email"],
        validation_token=str(uuid.uuid4()),
        is_validated=False,
        status=UserStatus.PENDING.value
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    send_admin_validation_emails(
        new_user,
        background_tasks,
        db
    )

    return {
        "message": (
            f"Utilisateur {new_user.email} créé "
            "et notifications envoyées aux admins."
        )
    }


# ==========================================================
# RELANCER LES EMAILS
# ==========================================================

@router.post("/resend-pending-emails")
def resend_pending_emails(
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    pending_users = (
        db.query(User)
        .filter(
            User.is_validated == False
        )
        .all()
    )

    for user in pending_users:

        send_admin_validation_emails(
            user,
            background_tasks,
            db
        )

    return {
        "message": (
            f"Emails envoyés pour "
            f"{len(pending_users)} utilisateurs "
            "en attente."
        )
    }


# ==========================================================
# VALIDER INSCRIT
# ==========================================================

@router.post("/valider-inscrit/{user_id}")
def valider_inscrit(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    user.is_validated = True
    user.status = UserStatus.VALIDATED.value
    user.token_used = True

    db.commit()

    return {
        "message":
            f"Utilisateur {user.email} "
            "validé avec succès."
    }


# ==========================================================
# REFUSER INSCRIT
# ==========================================================

@router.post("/refuser-inscrit/{user_id}")
def refuser_inscrit(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    email = user.email

    db.delete(user)
    db.commit()

    return {
        "message":
            f"Utilisateur {email} supprimé (refusé)."
    }


# ==========================================================
# VALIDATION VIA TOKEN
# ==========================================================

@router.get(
    "/validate/{token}/{action}"
)
def validate_inscription(
    token: str,
    action: str,
    db: Session = Depends(get_db)
):

    user = (
        db.query(User)
        .filter(
            User.validation_token == token
        )
        .first()
    )

    if not user:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable"
        )

    if user.token_used:
        raise HTTPException(
            status_code=400,
            detail="Lien déjà utilisé."
        )

    if action == "accept":

        user.is_validated = True

        user.status = (
            UserStatus.VALIDATED.value
        )

    elif action == "reject":

        user.is_validated = False

        user.status = (
            UserStatus.SUSPENDED.value
        )

    else:

        raise HTTPException(
            status_code=400,
            detail="Action invalide"
        )

    user.token_used = True

    db.commit()

    return {
        "message":
            f"Inscription de "
            f"{user.nom} traitée."
    }


# ==========================================================
# BLOQUER UTILISATEUR
# ==========================================================

@router.post("/block-user/{user_id}")
def block_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    user.is_blocked = True

    db.commit()

    return {
        "message":
            f"Utilisateur {user.email} bloqué"
    }


# ==========================================================
# RÉACTIVER UTILISATEUR
# ==========================================================

@router.post(
    "/reactivate-user/{user_id}"
)
def reactivate_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    user.is_blocked = False

    db.commit()

    return {
        "message":
            f"Utilisateur {user.email} réactivé"
    }


# ==========================================================
# AVERTISSEMENT
# ==========================================================

@router.post(
    "/send-warning/{user_id}"
)
def send_warning(
    user_id: int,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    if (
        user.last_warning
        and (
            datetime.utcnow()
            - user.last_warning
        ).days < 21
    ):

        jours_restants = (
            21
            - (
                datetime.utcnow()
                - user.last_warning
            ).days
        )

        return {
            "message": (
                "Avertissement déjà envoyé. "
                f"Prochain possible dans "
                f"{jours_restants} jours."
            )
        }

    user.last_warning = datetime.utcnow()

    db.commit()

    subject = "Avertissement CODE"

    content = (
        f"Bonjour {user.nom} {user.prenom},\n\n"
        "Vous devez renouveler votre abonnement.\n\n"
        "Cordialement."
    )

    background_tasks.add_task(
        send_email,
        to=user.email,
        subject=subject,
        body=content
    )

    return {
        "message":
            "Email d'avertissement envoyé"
    }


# ==========================================================
# SUPPRIMER UTILISATEUR
# ==========================================================

@router.delete(
    "/delete-user/{user_id}"
)
def delete_user(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

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
            detail="Utilisateur introuvable"
        )

    ensure_can_manage_user(
        current_user,
        user,
        db
    )

    email = user.email

    db.delete(user)

    db.commit()

    return {
        "message":
            f"Utilisateur {email} supprimé"
    }


# ==========================================================
# VÉRIFICATION ADMIN
# ==========================================================

@router.post("/check-admin")
def check_admin(
    code: AdminCode,
    db: Session = Depends(get_db)
):

    if code.password != ADMIN_CODE:

        raise HTTPException(
            status_code=401,
            detail="Mot de passe incorrect"
        )

    admin = (
        db.query(User)
        .filter(
            User.is_admin == True
        )
        .first()
    )

    if not admin:

        raise HTTPException(
            status_code=404,
            detail="Aucun administrateur trouvé"
        )

    token = create_access_token(
        admin.id
    )

    return {
        "access": True,

        "token": token,

        "user": {
            "id":
                admin.id,

            "nom":
                admin.nom,

            "prenom":
                admin.prenom,

            "email":
                admin.email,

            "is_admin":
                True
        }
    }