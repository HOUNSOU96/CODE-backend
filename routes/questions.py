from fastapi import APIRouter, HTTPException, Depends, Request
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from typing import Dict, Optional
import os
import json

from utils.evaluation import evaluer_test
from dependencies import get_current_user  # 🔐 Vérifie l'utilisateur avec le token

router = APIRouter()

# Modèle pour les réponses
class ResultatInput(BaseModel):
    resultats: Dict[str, str]  # { question_id: réponse_choisie }

# 📥 Endpoint GET - Récupération des questions
@router.get("/questions/{niveau}}")
def get_questions(
    niveau: str,
    serie: Optional[str] = None,
    user: dict = Depends(get_current_user)  # 🔐 Authentification requise
):
    chemin = "data/questions"

    # 🔎 Construction du nom de fichier selon classe + série + sous-série
    nom_fichier = f"{niveau}"
    if serie:
        nom_fichier += f"_{serie}"
    nom_fichier += ".json"

    chemin_complet = os.path.join(chemin, nom_fichier)

    # 📂 Vérification du fichier
    if not os.path.exists(chemin_complet):
        raise HTTPException(status_code=404, detail=f"Fichier introuvable: {nom_fichier}")

    # 📖 Lecture du fichier
    with open(chemin_complet, encoding="utf-8") as f:
        questions = json.load(f)

    return questions

# 📤 Endpoint POST - Évaluation des réponses
@router.post("/resultats/{niveau}")
def post_resultats(
    niveau: str,
    payload: ResultatInput,
    serie: Optional[str] = None,
    user: dict = Depends(get_current_user)  # 🔐 Authentification requise
):
    chemin = "data/questions"
    nom_fichier = f"{niveau}"
    if serie:
        nom_fichier += f"_{serie}"
    nom_fichier += ".json"
    chemin_complet = os.path.join(chemin, nom_fichier)

    if not os.path.exists(chemin_complet):
        raise HTTPException(status_code=404, detail=f"Fichier introuvable: {nom_fichier}")

    with open(chemin_complet, encoding="utf-8") as f:
        questions = json.load(f)

    if not payload.resultats:
        raise HTTPException(status_code=400, detail="Aucune réponse reçue.")

    evaluation = evaluer_test(questions, payload.resultats)
    return evaluation