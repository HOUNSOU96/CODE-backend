# backend/moravi_auth.py
from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from jose import jwt, JWTError
from datetime import timedelta

# SECRET_KEY et ALGORITHM pour MORAVI
SECRET_KEY = "CHANGE_CECI_IMPERATIVEMENT"  # idéal : mettre dans .env
ALGORITHM = "HS256"

# OAuth2 schema
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/admin/check-admin")

# Créer un JWT pour admin
def create_admin_token(expires_delta: timedelta = timedelta(hours=12)):
    payload = {"sub": "admin", "is_admin": True}
    expire = timedelta.total_seconds(expires_delta)
    payload.update({"exp": int(expire)})
    token = jwt.encode(payload, SECRET_KEY, algorithm=ALGORITHM)
    return token

# Dépendance pour vérifier l'admin
def get_current_admin(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=401,
        detail="Accès admin non autorisé",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        if not payload.get("is_admin"):
            raise credentials_exception
        return payload
    except JWTError:
        raise credentials_exception
