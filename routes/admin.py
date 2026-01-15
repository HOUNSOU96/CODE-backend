from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from datetime import timedelta
from jose import jwt
from moravi_auth import create_admin_token
import time

router = APIRouter(prefix="/api/admin", tags=["admin"])

SECRET_KEY = "CHANGE_CECI_IMPERATIVEMENT"
ALGORITHM = "HS256"

class AdminLogin(BaseModel):
    password: str

MORAVI_PASSWORD = os.getenv("MORAVI_PASSWORD", "moravi")


import time

def create_access_token(data: dict, expires_delta: timedelta):
    to_encode = data.copy()
    expire = int(time.time() + expires_delta.total_seconds())
    to_encode.update({"exp": expire})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)


@router.post("/check-admin")
async def check_admin(login: AdminLogin):
    if login.password != MORAVI_PASSWORD:
        raise HTTPException(status_code=401, detail="Mot de passe incorrect")

    token = create_access_token(
        data={"sub": "admin", "is_admin": True},
        expires_delta=timedelta(hours=12)
    )

    return {
        "access": True,
        "token": token
    }
