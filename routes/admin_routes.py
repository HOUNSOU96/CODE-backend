# 📁 admin_routes.py
from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from models.user import User, UserStatus
from dependencies import get_current_user
from utils.email import send_email, send_email_sync

from database import get_db
from utils.email import send_email
import uuid
import os

router = APIRouter(prefix="/api/admin", tags=["admin"])

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
        background_tasks.add_task(send_email_sync, to=admin.email, subject=subject, body=content)
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
        raise HTTPException(status_code=403, detail="Accès réservé aux administrateurs")

    query = db.query(User).filter(User.email != "deogratiashounsou@gmail.com")
    total = query.count()
    inscrits = query.offset((page - 1) * page_size).limit(page_size).all()

    online_threshold = datetime.utcnow() - timedelta(minutes=1)  # connecté si activité dans les 5 dernières minutes


    return {
        "total": total,
        "inscrits": [
            {
                "id": i.id,
                "nom": i.nom,
                "prenom": i.prenom,
                "email": i.email,
                "telephone": i.telephone,
                "is_validated": i.is_validated,
                "status": i.status if i.status else UserStatus.ACTIVE.value,
                "is_admin": i.is_admin,
                "is_blocked": i.is_blocked,
                "last_warning": i.last_warning,
                "date_inscription": i.created_at if hasattr(i, "created_at") else None,
                "is_online": bool(i.last_seen and i.last_seen > online_threshold)
            }
            for i in inscrits
        ],
    }

# ---------------- Création utilisateur admin ----------------
@router.post("/create-user")
def create_user(user_data: dict, background_tasks: BackgroundTasks, db: Session = Depends(get_db)):
    if db.query(User).filter(User.email == user_data['email']).first():
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

    return {"message": f"Utilisateur {new_user.email} créé et notifications envoyées aux admins."}

# ---------------- Relancer l’envoi d’email pour tous les utilisateurs en attente ----------------
@router.post("/resend-pending-emails")
def resend_pending_emails(background_tasks: BackgroundTasks, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    pending_users = db.query(User).filter(User.is_validated == False).all()
    for u in pending_users:
        send_admin_validation_emails(u, background_tasks, db)

    return {"message": f"Emails de validation envoyés pour {len(pending_users)} utilisateurs en attente."}

# ---------------- Valider / Refuser un inscrit ----------------
@router.post("/valider-inscrit/{user_id}")
def valider_inscrit(user_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
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

@router.post("/refuser-inscrit/{user_id}")
def refuser_inscrit(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404)

    db.delete(user)
    db.commit()
    return {"message": f"Utilisateur {user.email} supprimé (refusé) avec succès."}


# ---------------- Validation via token unique ----------------
@router.get("/validate/{token}/{action}")
def validate_inscription(token: str, action: str, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.validation_token == token).first()
    if not user:
        raise HTTPException(status_code=404)
    if user.token_used:
        raise HTTPException(status_code=400, detail="Ce lien de validation a déjà été utilisé.")

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
    return {"message": f"Inscription de {user.nom} {action}ée avec succès."}

# ---------------- Bloquer / Réactiver ----------------
@router.post("/block-user/{user_id}")
def block_user(user_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404)
    user.is_blocked = True
    db.commit()
    return {"message": f"Utilisateur {user.email} bloqué"}

@router.post("/reactivate-user/{user_id}")
def reactivate_user(user_id: int, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
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
def send_warning(user_id: int, background_tasks: BackgroundTasks, db: Session = Depends(get_db), current_user: User = Depends(get_current_user)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404)
    if user.last_warning and (datetime.utcnow() - user.last_warning).days < 21:
        jours_restants = 21 - (datetime.utcnow() - user.last_warning).days
        return {"message": f"Avertissement déjà envoyé. Prochain possible dans {jours_restants} jours."}
    user.last_warning = datetime.utcnow()
    db.commit()
    subject = "Avertissement CODE"
    content = f"Bonjour {user.nom} {user.prenom},\n\nVous devez renouveller votre abonnement.\n\nCordialement."
    background_tasks.add_task(send_email, to=user.email, subject=subject, body=content)
    return {"message": "Email d'avertissement envoyé"}

# ---------------- Supprimer utilisateur ----------------
@router.delete("/delete-user/{user_id}")
def delete_user(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404)
    db.delete(user)
    db.commit()
    return {"message": f"Utilisateur {user.email} supprimé avec succès."}


    






