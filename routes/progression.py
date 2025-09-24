from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Dict

router = APIRouter()

# Stockage temporaire en mémoire (tu peux remplacer par une BDD)
progress_data: Dict[str, Dict] = {}

class NotionProgression(BaseModel):
    statut: str
    niveauActuel: str
    niveauMax: str
    testTermine: bool = False
    testScore: int = 0

class UserProgression(BaseModel):
    email: str
    progression: Dict[str, NotionProgression]

@router.post("/api/progression/save")
def save_progression(data: UserProgression):
    progress_data[data.email] = data.progression
    return {"message": "Progression enregistrée avec succès"}

@router.get("/api/progression/{email}")
def get_progression(email: str):
    if email not in progress_data:
        raise HTTPException(status_code=404, detail="Aucune progression trouvée.")
    return progress_data[email]
