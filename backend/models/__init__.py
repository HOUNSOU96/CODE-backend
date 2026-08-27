# 📁 backend/models/__init__.py
import os, sys

from sqlalchemy.orm import Session
import json
from database import engine, Base

# Importation de tous les modèles
from .user import User
from .pending_user import PendingUser
from .question import Question
from .remediation_progress import RemediationProgress
from .remediation_videos import RemediationVideo
from .video_questions import VideoQuestion
from .connection_log import UserConnectionLog
from .document_activation import DocumentActivation
from .order import Order

# ----------------- INITIALISATION -----------------
def init_models():
    """Crée toutes les tables du modèle dans la base de données"""
    Base.metadata.create_all(bind=engine)
    print("✅ Toutes les tables ont été créées avec succès dans la base de données PostgreSQL !")

# ----------------- UTILITAIRE IMPORT JSON -----------------

def generate_unique_id(existing_ids, base_id):
    """Génère un ID unique pour éviter les doublons"""
    new_id = base_id
    i = 1
    while new_id in existing_ids:
        new_id = f"{base_id}_{i}"
        i += 1
    return new_id


def import_json_to_db(
    questions_file="questions.json",
    videos_file="remediation_videos.json",
    video_questions_file="video_questions.json"
):
    """Importe les questions, vidéos et video_questions depuis JSON en évitant les doublons."""

    with Session(bind=engine) as db:
        # ---- Questions ----
        try:
            with open(questions_file, "r", encoding="utf-8") as f:
                questions_data = json.load(f)

            existing_ids = {q[0] for q in db.query(Question.id).all()}

            for q in questions_data:
                q_id = generate_unique_id(existing_ids, q["id"])
                existing_ids.add(q_id)
                question = Question(
                    id=q_id,
                    niveau=q.get("niveau"),
                    notion=q.get("notion"),
                    question=q.get("question"),
                    reponse_correcte=q.get("reponse_correcte"),
                    choix=q.get("choix"),
                    situation=q.get("situation"),
                )
                db.merge(question)
            db.commit()
            print("✅ Import des questions terminé")
        except FileNotFoundError:
            print(f"❌ Fichier {questions_file} non trouvé.")

        # ---- Remediation Videos ----
        try:
            with open(videos_file, "r", encoding="utf-8") as f:
                videos_data = json.load(f)

            existing_ids = {v[0] for v in db.query(RemediationVideo.id).all()}

            for v in videos_data:
                v_id = generate_unique_id(existing_ids, v.get("id"))
                existing_ids.add(v_id)
                video = RemediationVideo(
                    id=v_id,
                    titre=v.get("titre"),
                    niveau=v.get("niveau"),
                    serie=v.get("serie"),
                    matiere=v.get("matiere"),
                    mois=v.get("mois"),
                    videoUrl=v.get("videoUrl"),
                    notions=v.get("notions"),
                    prerequis=v.get("prerequis"),
                )
                db.merge(video)
            db.commit()
            print("✅ Import des vidéos terminé")
        except FileNotFoundError:
            print(f"❌ Fichier {videos_file} non trouvé.")

        # ---- Video Questions ----
        try:
            with open(video_questions_file, "r", encoding="utf-8") as f:
                vq_data = json.load(f)

            existing_ids = {vq[0] for vq in db.query(VideoQuestion.id).all()}

            for vq in vq_data:
                vq_id = generate_unique_id(existing_ids, vq.get("id"))
                existing_ids.add(vq_id)
                vq_entry = VideoQuestion(
                    id=vq_id,
                    question=vq.get("question"),
                    choix=vq.get("choix"),
                    bonne_reponse=vq.get("bonne_reponse"),
                    niveau=vq.get("niveau"),
                    serie=vq.get("serie"),
                    matiere=vq.get("matiere"),
                    notion=vq.get("notion"),
                    duration=vq.get("duration"),
                    remediation_video_id=vq.get("remediation_video_id"),
                )
                db.merge(vq_entry)
            db.commit()
            print("✅ Import des video_questions terminé")
        except FileNotFoundError:
            print(f"❌ Fichier {video_questions_file} non trouvé.")
