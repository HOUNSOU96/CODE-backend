from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from typing import List, Optional
from pydantic import BaseModel
import uuid
import os
from routes.auth import create_access_token
from sqlalchemy import func
from database import get_db
from dependencies import get_current_user
from models.user import User, UserStatus
from models.connection_log import UserConnectionLog
from utils.email import send_email, send_email_sync
from models.document_activation import DocumentActivation


router = APIRouter(prefix="/api/admin", tags=["admin"])


# ---------------- Mot de passe admin ----------------
ADMIN_CODE = "MOraVi"


# ---------------- Modèles ----------------
class AdminCode(BaseModel):
    password: str


class ConnectionRecord(BaseModel):
    id: int
    nom: str
    prenom: str
    date: str
    heure_connexion: str
    heure_deconnexion: str


# ---------------- Fonction d'envoi emails aux admins ----------------
def send_admin_validation_emails(new_user: User, background_tasks: BackgroundTasks, db: Session):

    admins = db.query(User).filter(User.is_admin == True).all()

    for admin in admins:

        subject = "Nouvelle inscription CODE à valider"

        accept_link = f"{os.getenv('FRONTEND_URL')}/api/admin/validate/{new_user.validation_token}/accept"
        reject_link = f"{os.getenv('FRONTEND_URL')}/api/admin/validate/{new_user.validation_token}/reject"

        content = (
            f"Bonjour {admin.nom},\n\n"
            f"Nouvelle inscription de {new_user.nom} {new_user.prenom} ({new_user.email}).\n\n"
            f"Pour VALIDER : {accept_link}\n"
            f"Pour REFUSER : {reject_link}\n\n"
            "Cordialement,\nL'équipe CODE"
        )

        background_tasks.add_task(
            send_email_sync,
            to=admin.email,
            subject=subject,
            body=content
        )

        print(f"[DEBUG] Email envoyé à {admin.email} pour {new_user.email}")


# ---------------- Liste des inscrits ----------------
@router.get("/liste-inscrits")
def liste_inscrits(
    page: int = 1,
    page_size: int = 10,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    # --------------------------------------------------
    # Requête des utilisateurs
    #
    # On compte le nombre de documents attribués
    # à chaque utilisateur.
    #
    # Les utilisateurs ayant le plus de documents
    # seront placés en premier.
    # --------------------------------------------------

    query = (
        db.query(
            User,
            func.count(DocumentActivation.id).label("documents_count")
        )
        .outerjoin(
            DocumentActivation,
            DocumentActivation.user_id == User.id
        )
        .filter(
            User.email != "deogratiashounsou@gmail.com"
        )
        .group_by(User.id)
        .order_by(
            func.count(DocumentActivation.id).desc(),
            User.created_at.desc()
        )
    )

    total = query.count()

    # --------------------------------------------------
    # Pagination
    # --------------------------------------------------

    results = (
        query
        .offset((page - 1) * page_size)
        .limit(page_size)
        .all()
    )

    online_threshold = datetime.utcnow() - timedelta(minutes=1)

    data = []

    # --------------------------------------------------
    # Construction des données
    # --------------------------------------------------

    for user, documents_count in results:

        # ----------------------------------------------
        # Filleuls
        # ----------------------------------------------

        filleuls = (
            db.query(User.email)
            .filter(
                User.parrain_email == user.email
            )
            .all()
        )

        # ----------------------------------------------
        # Documents de l'utilisateur
        # ----------------------------------------------

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
                "document_name": document.document_name,
                "activation_code": document.activation_code,
                "is_activated": document.is_activated,
                "activated_at": (
                    document.activated_at.isoformat()
                    if document.activated_at
                    else None
                ),
                "activation_type": document.activation_type,
            }
            for document in documents
        ]

        # ----------------------------------------------
        # Informations utilisateur
        # ----------------------------------------------

        user_data = {

            "id": user.id,

            "nom": user.nom,

            "prenom": user.prenom,

            "email": user.email,

            "telephone": user.telephone,

            "is_validated": user.is_validated,

            "status": (
                user.status
                if user.status
                else UserStatus.ACTIVE.value
            ),

            "is_admin": user.is_admin,

            "is_blocked": user.is_blocked,

            "last_warning": user.last_warning,

            "parrain_email": user.parrain_email,

            "pays_residence": user.pays_residence,

            "date_inscription": (
                user.created_at
                if hasattr(user, "created_at")
                else None
            ),

            "is_online": bool(
                user.last_seen
                and user.last_seen > online_threshold
            ),

            "filleuls_emails": [
                f[0]
                for f in filleuls
            ],

            # 🔑 Documents de l'utilisateur
            "documents": documents_data,

            # 🔢 Nombre de documents
            "documents_count": documents_count,
        }

        data.append(user_data)

    return {
        "total": total,
        "inscrits": data,
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
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    activations = (
        db.query(DocumentActivation)
        .order_by(DocumentActivation.id.asc())
        .all()
    )

    result = []

    for index, activation in enumerate(activations, start=1):

        user = None

        if activation.user_id:
            user = (
                db.query(User)
                .filter(User.id == activation.user_id)
                .first()
            )

        result.append({
            "numero": index,

            "document_name": activation.document_name,

            "user_id": activation.user_id,

            "nom": user.nom if user else None,
            "prenom": user.prenom if user else None,

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

            "is_activated": bool(
                activation.is_activated
            ),

            "activation_code": activation.activation_code,

            "buyer_email": activation.buyer_email,

            "beneficiary_email": (
                activation.beneficiary_email
            ),

            "activation_type": (
                activation.activation_type
            ),

            "activated_at": (
                activation.activated_at.isoformat()
                if activation.activated_at
                else None
            )
        })

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
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs"
        )

    activations = (
        db.query(DocumentActivation)
        .order_by(DocumentActivation.id.asc())
        .all()
    )

    result = []

    for index, activation in enumerate(activations, start=1):

        result.append({
            "id": activation.id,

            "numero": index,

            "activation_code": (
                activation.activation_code
            ),

            "document_name": (
                activation.document_name
            ),

            "buyer_email": (
                activation.buyer_email
            ),

            "beneficiary_email": (
                activation.beneficiary_email
            ),

            "user_id": (
                activation.user_id
            ),

            "is_activated": bool(
                activation.is_activated
            ),

            "activated_at": (
                activation.activated_at.isoformat()
                if activation.activated_at
                else None
            ),

            "activation_type": (
                activation.activation_type
            )
        })

    return result


# ---------------- Historique des connexions ----------------
@router.get("/historique-connections", response_model=List[ConnectionRecord])
def get_historique_connections(
    date: Optional[str] = None,
    limit: int = 500,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès admin requis")

    query = db.query(UserConnectionLog)

    if date:
        try:
            date_obj = datetime.strptime(date, "%Y-%m-%d").date()
            query = query.filter(UserConnectionLog.date == date_obj)
        except ValueError:
            raise HTTPException(status_code=400, detail="Format date invalide")

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

                date=log.date.strftime("%Y-%m-%d"),

                heure_connexion=log.heure_connexion.strftime("%H:%M"),

                heure_deconnexion=(
                    log.heure_deconnexion.strftime("%H:%M")
                    if log.heure_deconnexion
                    else "-"
                )

            )

        )

    return results


# ---------------- Création utilisateur admin ----------------
@router.post("/create-user")
def create_user(
    user_data: dict,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db)
):

    if db.query(User).filter(User.email == user_data["email"]).first():
        raise HTTPException(status_code=400, detail="Email déjà utilisé")

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

    send_admin_validation_emails(new_user, background_tasks, db)

    return {
        "message": f"Utilisateur {new_user.email} créé et notifications envoyées aux admins."
    }


# ---------------- Relancer les emails ----------------
@router.post("/resend-pending-emails")
def resend_pending_emails(
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    pending_users = db.query(User).filter(User.is_validated == False).all()

    for u in pending_users:
        send_admin_validation_emails(u, background_tasks, db)

    return {
        "message": f"Emails envoyés pour {len(pending_users)} utilisateurs en attente."
    }


# ---------------- Valider inscrit ----------------
@router.post("/valider-inscrit/{user_id}")
def valider_inscrit(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    user.is_validated = True
    user.status = UserStatus.VALIDATED.value
    user.token_used = True

    db.commit()

    return {"message": f"Utilisateur {user.email} validé avec succès."}


# ---------------- Refuser inscrit ----------------
@router.post("/refuser-inscrit/{user_id}")
def refuser_inscrit(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    db.delete(user)
    db.commit()

    return {"message": f"Utilisateur {user.email} supprimé (refusé)."}


# ---------------- Validation via token ----------------
@router.get("/validate/{token}/{action}")
def validate_inscription(
    token: str,
    action: str,
    db: Session = Depends(get_db)
):

    user = db.query(User).filter(User.validation_token == token).first()

    if not user:
        raise HTTPException(status_code=404)

    if user.token_used:
        raise HTTPException(status_code=400, detail="Lien déjà utilisé.")

    if action == "accept":

        user.is_validated = True
        user.status = UserStatus.VALIDATED.value

    elif action == "reject":

        user.is_validated = False
        user.status = UserStatus.SUSPENDED.value

    else:
        raise HTTPException(status_code=400, detail="Action invalide")

    user.token_used = True
    db.commit()

    return {"message": f"Inscription de {user.nom} traitée."}


# ---------------- Bloquer utilisateur ----------------
@router.post("/block-user/{user_id}")
def block_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    user.is_blocked = True
    db.commit()

    return {"message": f"Utilisateur {user.email} bloqué"}


# ---------------- Réactiver utilisateur ----------------
@router.post("/reactivate-user/{user_id}")
def reactivate_user(
    user_id: int,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    user.is_blocked = False
    db.commit()

    return {"message": f"Utilisateur {user.email} réactivé"}


# ---------------- Avertissement ----------------
@router.post("/send-warning/{user_id}")
def send_warning(
    user_id: int,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    if user.last_warning and (datetime.utcnow() - user.last_warning).days < 21:

        jours_restants = 21 - (datetime.utcnow() - user.last_warning).days

        return {
            "message": f"Avertissement déjà envoyé. Prochain possible dans {jours_restants} jours."
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

    return {"message": "Email d'avertissement envoyé"}


# ---------------- Supprimer utilisateur ----------------
@router.delete("/delete-user/{user_id}")
def delete_user(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):

    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()

    if not user:
        raise HTTPException(status_code=404)

    db.delete(user)
    db.commit()

    return {"message": f"Utilisateur {user.email} supprimé"}


# ---------------- Vérification admin ----------------
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
        .filter(User.is_admin == True)
        .first()
    )

    if not admin:
        raise HTTPException(
            status_code=404,
            detail="Aucun administrateur trouvé"
        )

    token = create_access_token(admin.id)

    return {
        "access": True,
        "token": token,
        "user": {
            "id": admin.id,
            "nom": admin.nom,
            "prenom": admin.prenom,
            "email": admin.email,
            "is_admin": True
        }
    }