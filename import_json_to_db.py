# 📁 backend/import_json_to_db.py
import json
import os
from datetime import datetime
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from database import SessionLocal, engine, Base
from models import Question, Resultat, TestEnCours, RemediationVideo, VideoQuestion

# Créer les tables si elles n'existent pas encore
Base.metadata.create_all(bind=engine)

# Dossiers
DATA_DIR = os.path.join(os.path.dirname(__file__), "data")
VIDEOS_DIR = os.path.join(os.path.dirname(__file__), "RemediationVideos")

# ------------------------------
# Fonctions utilitaires
# ------------------------------
def load_json(file_name):
    path = os.path.join(DATA_DIR, file_name)
    with open(path, "r", encoding="utf-8") as f:
        return json.load(f)

def list_videos_by_niveau(niveau):
    niveau_dir = os.path.join(VIDEOS_DIR, niveau)
    if not os.path.exists(niveau_dir):
        return []
    return [os.path.join(niveau, f) for f in os.listdir(niveau_dir) if f.endswith((".mp4", ".webm", ".mkv"))]

# ------------------------------
# Import questions.json
# ------------------------------
def import_questions(db: Session):
    questions = load_json("questions.json")
    doublons = []
    for q in questions:
        question = Question(
            id=q["id"],
            niveau=q.get("niveau"),
            serie=q.get("serie"),
            matiere=q.get("matiere"),
            notion=q.get("notion"),
            duration=q.get("duration"),
            question=q.get("question"),
            choix=json.dumps(q.get("choix")) if q.get("choix") else None,
            bonne_reponse=q.get("bonne_reponse"),
            situation=json.dumps(q.get("situation")) if q.get("situation") else None
        )
        try:
            db.add(question)
            db.flush()
        except IntegrityError:
            db.rollback()
            db.merge(question)
            doublons.append(q["id"])
    db.commit()
    print(f"✅ {len(questions)} questions importées.")
    if doublons:
        print(f"⚠️ Doublons gérés pour les questions suivantes : {doublons}")

# ------------------------------
# Import resultats.json
# ------------------------------
def import_resultats(db: Session):
    resultats = load_json("resultats.json")
    for r in resultats:
        resultat = Resultat(
            user_id=r.get("user_id"),
            niveau=r.get("niveau"),
            serie=r.get("serie"),
            matiere=r.get("matiere"),
            note=r.get("note"),
            mention=r.get("mention"),
            nbQuestions=r.get("nbQuestions"),
            nbBonnesReponses=r.get("nbBonnesReponses"),
            notionsNonAcquises=json.dumps(r.get("notionsNonAcquises")) if r.get("notionsNonAcquises") else None,
            date=datetime.fromisoformat(r.get("date"))
        )
        db.add(resultat)
    db.commit()
    print(f"✅ {len(resultats)} résultats importés.")

# ------------------------------
# Import tests_en_cours.json
# ------------------------------
def import_tests_en_cours(db: Session):
    tests = load_json("tests_en_cours.json")
    doublons = []
    for key, t in tests.items():
        test = TestEnCours(
            test_id=t.get("test_id"),
            user_id=t.get("user_id"),
            niveau=t.get("niveau"),
            serie=t.get("serie"),
            matiere=t.get("matiere"),
            questions_ids=json.dumps(t.get("questions_ids")) if t.get("questions_ids") else None,
            date=datetime.fromisoformat(t.get("date"))
        )
        try:
            db.add(test)
            db.flush()
        except IntegrityError:
            db.rollback()
            db.merge(test)
            doublons.append(t.get("test_id"))
    db.commit()
    print(f"✅ {len(tests)} tests en cours importés.")
    if doublons:
        print(f"⚠️ Doublons gérés pour les tests suivants : {doublons}")

# ------------------------------
# Import remediationVideo.json + vidéos locales
# ------------------------------
def import_remediation_videos(db: Session):
    videos = load_json("remediationVideos.json")
    doublons_videos = []
    doublons_questions = []

    for v in videos:
        video = RemediationVideo(
            id=v.get("id"),
            titre=v.get("titre"),
            niveau=v.get("niveau"),
            serie=v.get("serie"),
            matiere=v.get("matiere"),
            mois=json.dumps(v.get("mois")) if v.get("mois") else None,
            videoUrl=v.get("videoUrl"),
            notions=json.dumps(v.get("notions")) if v.get("notions") else None,
            prerequis=json.dumps(v.get("prerequis")) if v.get("prerequis") else None
        )
        try:
            db.add(video)
        except IntegrityError:
            db.rollback()
            db.merge(video)
            doublons_videos.append(v.get("id"))

        # Ajouter les questions de la vidéo
        for q in v.get("questions", []):
            vq = VideoQuestion(
                id=q.get("id"),
                question=q.get("question"),
                choix=json.dumps(q.get("choix")) if q.get("choix") else None,
                bonne_reponse=q.get("bonne_reponse"),
                niveau=q.get("niveau"),
                serie=q.get("serie"),
                matiere=q.get("matiere"),
                notion=q.get("notion"),
                duration=q.get("duration"),
                remediation_video=video
            )
            try:
                db.add(vq)
            except IntegrityError:
                db.rollback()
                db.merge(vq)
                doublons_questions.append(q.get("id"))

        # Ajouter les vidéos locales
        local_videos = list_videos_by_niveau(v.get("niveau"))
        for i, path in enumerate(local_videos, start=1):
            local_video_id = f"{v['id']}_local_{i}"
            vq_local = VideoQuestion(
                id=local_video_id,
                question=f"Vidéo locale {i} ({path})",
                choix=json.dumps([]),
                bonne_reponse="",
                niveau=v.get("niveau"),
                serie=v.get("serie"),
                matiere=v.get("matiere"),
                notion=v.get("notions")[0] if v.get("notions") else "",
                duration=0,
                remediation_video=video
            )
            try:
                db.add(vq_local)
            except IntegrityError:
                db.rollback()
                db.merge(vq_local)
                doublons_questions.append(local_video_id)

    db.commit()
    print(f"✅ {len(videos)} vidéos de remédiation importées.")
    if doublons_videos:
        print(f"⚠️ Doublons gérés pour les vidéos suivantes : {doublons_videos}")
    if doublons_questions:
        print(f"⚠️ Doublons gérés pour les questions vidéos suivantes : {doublons_questions}")

# ------------------------------
# MAIN
# ------------------------------
def main():
    db = SessionLocal()
    try:
        import_questions(db)
        import_resultats(db)
        import_tests_en_cours(db)
        import_remediation_videos(db)
    finally:
        db.close()

if __name__ == "__main__":
    main()
