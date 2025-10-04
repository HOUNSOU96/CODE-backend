# backend/routes/auth.py
from fastapi import APIRouter, Depends, HTTPException, Request, BackgroundTasks, Query
from sqlalchemy.orm import Session
from database import get_db
from models.user import User
from models.pending_user import PendingUser
import uuid
from pydantic import BaseModel, EmailStr
from jose import jwt
from datetime import datetime, timedelta
from passlib.context import CryptContext
import os
from utils.hashing import hash_password
from dotenv import load_dotenv
from models.user import User, UserStatus

from utils.email import send_email
from typing import List, Optional

load_dotenv()
router = APIRouter(tags=["auth"])



class LoginRequest(BaseModel):
    email: EmailStr
    password: str




# 🔑 JWT & sécurité
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
SECRET_KEY = os.getenv("SECRET_KEY", "dev-secret")
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60
ADMIN_EMAILS = [
    "deogratiashounsou@gmail.com",
    "admin2@exemple.com",
    "admin3@exemple.com"
]

# === UTILITAIRES ===
def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

def create_access_token(user_id: int):
    expire = datetime.utcnow() + timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES)
    to_encode = {"user_id": user_id, "exp": expire}
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def get_current_user(request: Request, db: Session = Depends(get_db)) -> User:
    auth_header: str = request.headers.get("Authorization")
    if not auth_header or not auth_header.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="Token manquant")

    token = auth_header.split("Bearer ")[-1]
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id = payload.get("user_id")
        if user_id is None:
            raise HTTPException(status_code=401, detail="Token invalide")
    except Exception:
        raise HTTPException(status_code=401, detail="Token invalide")

    user = db.query(User).filter(User.id == int(user_id)).first()
    if not user:
        raise HTTPException(status_code=401, detail="Utilisateur introuvable")

    return user



@router.post("/login")
def login(data: LoginRequest, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.email == data.email).first()
    if not user:
        raise HTTPException(status_code=401, detail="Email ou mot de passe incorrect.")

    if not verify_password(data.password, user.hashed_password):
        raise HTTPException(status_code=401, detail="Email ou mot de passe incorrect.")

    # 🔹 Gestion des statuts spéciaux pour le frontend
    if user.is_blocked:
        raise HTTPException(status_code=403, detail="USER_BLOCKED")
    if not user.is_validated:
        raise HTTPException(status_code=403, detail="USER_NOT_VALIDATED")

    # Création du token JWT
    token = create_access_token(user.id)

    return {
        "access_token": token,
        "user": {
            "id": user.id,
            "nom": user.nom,
            "prenom": user.prenom,
            "email": user.email,
            "is_admin": user.is_admin,
            "is_validated": user.is_validated
        }
    }






class RegisterRequest(BaseModel):
    nom: str
    prenom: str
    sexe: str
    date_naissance: str
    lieu_naissance: str
    nationalite: str
    pays_residence: str
    telephone: str
    email: EmailStr
    password: str

# ------------------- Fonction d'envoi aux admins -------------------
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
        background_tasks.add_task(send_email, to=admin.email, subject=subject, body=content)


# ------------------- Route d'inscription -------------------
@router.post("/register")
def register_user(data: RegisterRequest, background_tasks: BackgroundTasks, db: Session = Depends(get_db)):
    # Vérifier si email existe
    if db.query(User).filter(User.email == data.email).first():
        raise HTTPException(status_code=400, detail="Email déjà utilisé")

    # Hasher le mot de passe et créer le token de validation
    hashed_password = pwd_context.hash(data.password)
    validation_token = str(uuid.uuid4())

    # Créer l'utilisateur
    new_user = User(
        nom=data.nom,
        prenom=data.prenom,
        email=data.email,
        hashed_password=hashed_password,
        is_validated=False,
        is_admin=False,
        date_inscription=datetime.utcnow(),
        validation_token=validation_token,
        status=UserStatus.PENDING.value
    )
    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    # Envoyer email aux admins
    send_admin_validation_emails(new_user, background_tasks, db)

    return {"message": "Inscription réussie. Les admins vont la valider."}




# === ROUTES ADMIN POUR LISTE INSCRITS ===
@router.get("/admin/liste-inscrits")
def liste_inscrits(
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1),
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")

    query = db.query(User).order_by(User.date_inscription.desc())
    total = query.count()
    inscrits = query.offset((page - 1) * page_size).limit(page_size).all()

    # Préparer données pour le frontend
    result = []
    for u in inscrits:
        result.append({
            "id": u.id,
            "nom": u.nom,
            "prenom": u.prenom,
            "email": u.email,
            "telephone": getattr(u, "telephone", ""),  # si champ optionnel
            "date_inscription": u.date_inscription.isoformat(),
            "plain_password": getattr(u, "plain_password", None),
            "is_validated": u.is_validated,
            "is_blocked": getattr(u, "is_blocked", False),
            "last_warning": getattr(u, "last_warning", None),
        })

    return {"total": total, "inscrits": result}

# 🔹 Valider / Refuser
@router.post("/admin/valider-inscrit/{user_id}")
def valider_inscrit(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")
    user.is_validated = True
    db.commit()
    return {"message": "Utilisateur validé"}

@router.post("/admin/refuser-inscrit/{user_id}")
def refuser_inscrit(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")
    db.delete(user)
    db.commit()
    return {"message": "Utilisateur refusé et supprimé"}

# 🔹 Bloquer / Réactiver
@router.post("/admin/block-user/{user_id}")
def block_user(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")
    user.is_blocked = True
    db.commit()
    return {"message": "Utilisateur bloqué"}

@router.post("/admin/reactivate-user/{user_id}")
def reactivate_user(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")
    user.is_blocked = False
    db.commit()
    return {"message": "Utilisateur réactivé"}

# 🔹 Envoyer avertissement
@router.post("/admin/send-warning/{user_id}")
def send_warning(
    user_id: int,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")

    # Vérifier si 21 jours se sont écoulés depuis le dernier avertissement
    if user.last_warning:
        jours_ecoules = (datetime.utcnow() - user.last_warning).days
        if jours_ecoules < 21:
            return {"message": f"Avertissement déjà envoyé il y a {jours_ecoules} jours. Prochain envoi possible dans {21 - jours_ecoules} jours."}

    # Mettre à jour la date du dernier avertissement
    user.last_warning = datetime.utcnow()
    db.commit()

    # Préparer et envoyer l'email
    subject = "Avertissement CODE"
    content = (
        f"Bonjour {user.nom} {user.prenom},\n\n"
        "Vous devez renouveller votre abonnement pour ne pas avoir un accès bloqué sur CODE.\n\n"
        "Cordialement,\nL'équipe CODE"
    )
    background_tasks.add_task(send_email, to=user.email, subject=subject, body=content)

    return {"message": "Email d'avertissement envoyé"}




@router.delete("/admin/delete-user/{user_id}")
def delete_user(user_id: int, current_user: User = Depends(get_current_user), db: Session = Depends(get_db)):
    # Seuls les admins peuvent supprimer
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")

    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="Utilisateur introuvable")

    db.delete(user)
    db.commit()
    return {"message": f"Utilisateur {user.email} supprimé avec succès."}




# === ROUTE ME ===
@router.get("/me")
def me(current_user: User = Depends(get_current_user)):
    return {
        "id": current_user.id,
        "email": current_user.email,
        "nom": current_user.nom,
        "prenom": current_user.prenom,
        "is_active": current_user.is_active,
        "is_verified": current_user.is_verified,
        "is_admin": current_user.is_admin 
    }

__all__ = [
    "get_current_user",
    "login",
    "register_user",
    "me",
    "liste_inscrits",
    "valider_inscrit",
    "refuser_inscrit",
    "block_user",
    "reactivate_user",
    "send_warning"
]
