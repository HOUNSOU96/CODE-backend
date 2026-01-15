from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

# ---------- Modèle de requête ----------
class AdminLogin(BaseModel):
    password: str

# ---------- Mot de passe MORAVI ----------
MORAVI_PASSWORD = "moravi"  # change si nécessaire

# ---------- Route POST pour vérifier le mot de passe ----------
@router.post("/check-admin")
async def check_admin(login: AdminLogin):
    if login.password == MORAVI_PASSWORD:
        return {"access": True, "message": "Connexion réussie."}
    else:
        return {"access": False, "message": "Mot de passe incorrect."}
