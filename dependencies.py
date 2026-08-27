# backend/dependencies.py
from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import JWTError, jwt
from pydantic import BaseModel
from typing import Optional
from dotenv import load_dotenv
import os

from sqlalchemy.orm import Session
from database import get_db
from models.user import User  # ✅ Import du modèle User

# Charge les variables d'environnement depuis le fichier .env
load_dotenv()

# Récupère la clé secrète et l'algorithme depuis .env
SECRET_KEY = os.getenv("SECRET_KEY", "fallback_key")
ALGORITHM = "HS256"

# OAuth2 token schema
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

# Modèle pour les données extraites du token
class TokenData(BaseModel):
    user_id: Optional[int] = None

# Fonction pour extraire l'utilisateur à partir du token
def get_current_user(
    token: str = Depends(oauth2_scheme),
    db: Session = Depends(get_db),
) -> User:
    credentials_exception = HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail="Impossible d'authentifier l'utilisateur",
        headers={"WWW-Authenticate": "Bearer"},
    )

    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user_id: Optional[int] = payload.get("user_id")
        if user_id is None:
            raise credentials_exception

        user = db.query(User).filter(User.id == user_id).first()
        if user is None:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Utilisateur introuvable"
            )

        return user

    except JWTError:
        raise credentials_exception

# Vérifie que l'utilisateur a validé son OTP
def get_verified_user(user: User = Depends(get_current_user)):
    if not user.is_verified:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Compte non vérifié. Veuillez valider votre OTP.",
        )
    return user
