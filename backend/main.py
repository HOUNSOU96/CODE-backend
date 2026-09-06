from fastapi import FastAPI, Query, HTTPException, Request, Depends, UploadFile, File, Form
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel, ConfigDict
from typing import Dict, List, Optional, Set
import json
import os
from fastapi import Request, BackgroundTasks
from apscheduler.schedulers.background import BackgroundScheduler
from zoneinfo import ZoneInfo
import logging
import random
from routes.activation import router as activation_router
from routes.admin_routes import router as admin_router
import threading
import uuid
from pathlib import Path
from collections import defaultdict
from datetime import datetime, timedelta
from fastapi import BackgroundTasks
from dotenv import load_dotenv
from database import get_db
from sqlalchemy.orm import Session
from utils.email import send_email, send_email_sync
from email.utils import make_msgid
import base64, os, uuid, logging
from utils.evaluation import evaluer_reponses
from utils.tests import sauvegarder_test, charger_test, supprimer_test
from models.user import User
from dependencies import get_current_user
from routes import  progression, remediation_progress, auth, products
from models import init_models
import unicodedata
from routes.admin_dashboard import router as admin_dashboard_router
from routes.question_messages import router as question_messages_router
from pydantic import BaseModel, ConfigDict, Field



# -------------------- Initialisation -------------------- #
init_models()
load_dotenv()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DATA_DIR = os.path.join(BASE_DIR, "data")
RESULTATS_FILE = os.path.join(DATA_DIR, "resultats.json")
QUESTIONS_FILE = os.path.join(DATA_DIR, "questions.json")
STATIC_DIR = os.path.join(BASE_DIR, "static")
os.makedirs(STATIC_DIR, exist_ok=True)

app = FastAPI()

ADMIN_EMAIL = os.getenv("ADMIN_EMAIL") or "deogratiashounsou@gmail.com"

if not os.path.exists(STATIC_DIR):
    print(f"Erreur : le dossier {STATIC_DIR} n'existe pas !")

app.mount("/static", StaticFiles(directory=STATIC_DIR), name="static")
app.mount("/images", StaticFiles(directory="Images"), name="images")

app.include_router(activation_router)
app.include_router(products.router)

logger = logging.getLogger(__name__)
class Apprenant(BaseModel):
    nom: str
    email: str

class EnvoiPDFRequest(BaseModel):
    pdfBase64: str
    apprenant: Apprenant



class NotifyRequest(BaseModel):
    email: str




class Announcement(BaseModel):
    id: int
    message: str
    type: str  # "alerte", "avantage", "info"
    start_date: Optional[datetime] = None
    end_date: Optional[datetime] = None


class NotifyRemediation(BaseModel):
    user_id: int
    video_id: str


class RemediationVideo(BaseModel):
    niveau: str
    video_titre: str
    next_video_titre: Optional[str] = None
    start_month: str


class ExitEvent(BaseModel):
    email: str



class VideoFinishRequest(BaseModel):
    video_titre: str
    next_video_titre: Optional[str] = None





class Config:
        json_encoders = {
            datetime: lambda v: v.isoformat()
        }



class RemediationRequest(BaseModel):
    niveau: str



class CheckProgressRequest(BaseModel):
    email: str
    video_id: int





class TZFormatter(logging.Formatter):
    def formatTime(self, record, datefmt=None):
        tz = ZoneInfo("Africa/Lagos")  # GMT+1
        dt = datetime.fromtimestamp(record.created, tz)
        if datefmt:
            return dt.strftime(datefmt)
        return dt.isoformat()

# -------------------- DONNEES -------------------- #



# -------------------- Middleware -------------------- #
origins = [
    "http://localhost:5173",
    "https://code-frontend-rho.vercel.app",
    "https://moravi.vercel.app",
]

if os.environ.get("FRONTEND_CODE"):
    origins.append(os.environ["FRONTEND_CODE"])

if os.environ.get("FRONTEND_MORAVI"):
    origins.append(os.environ["FRONTEND_MORAVI"])



app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

announcements: List[Announcement] = [
    Announcement(
        id=1,
        type="alerte",
        message="📩 Cette plateforme est purement éducative.",
        start_date=datetime(2026, 8, 28),
        end_date=datetime(2026, 12, 30),
    ),
    Announcement(
        id=2,
        type="avantage",
        message="📩 Pour nous soutenir, contactez-nous par WhatsApp : +229 01 61 86 64 53     ou    par mail : deogratiashounsou@gmail.com",
        start_date=datetime(2026, 8, 28),
        end_date=datetime(2026, 12, 31),
    ),
    Announcement(
        id=3,
        type="info",
        message="📩 Pour vos différentes publicités, contactez-nous par WhatsApp : +229 01 61 86 64 53 (HOUNSOU Déo-Gratias S.)     ou    par mail : deogratiashounsou@gmail.com",
        start_date=datetime(2026, 8, 28),
        end_date=datetime(2026, 12, 31),
    ),
]




def get_current_announcement():
    """
    Retourne l’annonce courante avec le cycle :
    - 30s affichée
    - 20s vide
    - puis suivante
    """
    now = datetime.now()
    valid_announcements = [
        ann for ann in announcements
        if (not ann.start_date or ann.start_date <= now)
        and (not ann.end_date or ann.end_date >= now)
    ]

    if not valid_announcements:
        return None

    display_time = 30  # secondes affichage
    pause_time = 20    # secondes pause
    cycle_duration = display_time + pause_time
    total_announcements = len(valid_announcements)

    # On calcule le temps écoulé depuis la première annonce valide
    first_start = valid_announcements[0].start_date or now
    elapsed = int((now - first_start).total_seconds())
    if elapsed < 0:
        return None  # l'annonce n'a pas encore commencé

    # Où en sommes-nous dans le cycle global
    position_in_total = elapsed % (cycle_duration * total_announcements)
    current_index = position_in_total // cycle_duration
    position_in_cycle = position_in_total % cycle_duration

    if position_in_cycle < display_time:
        return valid_announcements[current_index]  # affichage de l'annonce
    else:
        return None  # pause


# -------------------- ENDPOINTS -------------------- #

@app.get("/api/announcements/current")
def get_announcement():
    """Retourne l'annonce actuellement affichable ou null."""

    announcement = get_current_announcement()

    if announcement is None:
        return JSONResponse(content=None, status_code=200)

    return JSONResponse(
        content=announcement.model_dump(mode="json"),
        status_code=200
    )
# -------------------- Modèles -------------------- #




@app.exception_handler(HTTPException)
async def http_exception_handler(request: Request, exc: HTTPException):
    return JSONResponse(status_code=exc.status_code, content={"message": exc.detail})

video_dir = os.path.join(BASE_DIR, "RemediationVideos")
if not os.path.exists(video_dir):
    raise RuntimeError(f"Le dossier '{video_dir}' est introuvable.")
app.mount("/RemediationVideos", StaticFiles(directory=video_dir), name="remediation_videos")

# -------------------- Routes -------------------- #
app.include_router(auth.router, prefix="/api/auth", tags=["auth"])
app.include_router(remediation_progress.router, prefix="/api/remediation-progress", tags=["RemediationProgress"])
app.include_router(progression.router)
app.include_router(admin_router)
app.include_router(admin_dashboard_router)
app.include_router(question_messages_router)


# -------------------- Debug Middleware -------------------- #
async def update_last_seen_in_db(user, db):
    try:
        user.last_seen = datetime.utcnow()
        db.add(user)
        db.commit()
        print(f"✅ last_seen mis à jour pour {user.email}")
    except Exception as e:
        print(f"⚠️ Erreur lors de la mise à jour last_seen : {e}")

@app.middleware("http")
async def update_last_seen_middleware(request: Request, call_next, db: Session = Depends(get_db)):
    public_routes = [
        "/api/auth/login",
        "/api/auth/register",
        "/api/announcements/current"
    ]

    if request.method == "OPTIONS" or any(request.url.path.startswith(route) for route in public_routes):
        return await call_next(request)

    # Créer BackgroundTasks
    background_tasks = BackgroundTasks()
    
    auth_header = request.headers.get("Authorization")
    if auth_header:
        print(f"🔐 Authorization Header reçu : {auth_header}")
        try:
            token = auth_header.split(" ")[1] if " " in auth_header else auth_header
            current_user = await get_current_user(token, db)
            if current_user:
                background_tasks.add_task(update_last_seen_in_db, current_user, db)
        except Exception as e:
            print(f"⚠️ Erreur lors de la mise à jour last_seen : {e}")
    else:
        print("🚫 Aucun token reçu dans la requête")

    response = await call_next(request)
    response.background = background_tasks  # Attacher la tâche en arrière-plan
    return response




# -------------------- Gestion des séries -------------------- #
series = {lettre: [lettre] + [f"{lettre}{i}" for i in range(1, 10)] for lettre in "ABCDEFG"}
classes_sans_serie = {"6e", "5e", "4e", "3e"}

def est_serie_valide(niveau: str, serie: Optional[str]) -> bool:
    niveau = niveau.lower()
    if niveau in classes_sans_serie:
        return serie is None
    if not serie:
        return False
    serie = serie.upper()
    return any(serie in sous_series for sous_series in series.values())

# -------------------- Chargement questions -------------------- #
if not os.path.exists(QUESTIONS_FILE):
    raise RuntimeError(f"Fichier questions introuvable : {QUESTIONS_FILE}")

with open(QUESTIONS_FILE, "r", encoding="utf-8") as f:
    questions = json.load(f)

niveaux = sorted(set(q["niveau"].lower() for q in questions))
notions_ordonnees = sorted(set(q["notion"] for q in questions))

# -------------------- SQLAlchemy Models -------------------- #
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import Column, Integer, String, Text, JSON, DateTime

Base = declarative_base()

class Question(Base):
    __tablename__ = "questions"
    id = Column(Integer, primary_key=True, index=True)
    niveau = Column(String, index=True)
    serie = Column(String, nullable=True)
    notion = Column(String, index=True)
    question = Column(Text)
    choix = Column(JSON)
    bonne_reponse = Column(String)

class Resultat(Base):
    __tablename__ = "resultats"
    id = Column(Integer, primary_key=True, index=True)
    niveau = Column(String)
    serie = Column(String, nullable=True)
    note = Column(Integer)
    mention = Column(String)
    notions_non_acquises = Column(JSON)
    questions_remediation = Column(JSON)
    date = Column(DateTime, default=datetime.utcnow)

# -------------------- Pydantic Schemas -------------------- #
class ReponseUnique(BaseModel):
    id: str
    reponse: str
    model_config = ConfigDict(from_attributes=True)

class ReponsesModel(BaseModel):
    resultats: List[ReponseUnique]
    model_config = ConfigDict(from_attributes=True)


class ResultatRemediation(BaseModel):
    id: str
    question: str
    classe: str | None = None
    choix: list[str] = Field(default_factory=list)
    correcte: bool = False
    bonne_reponse: str
    reponse_apprenant: str
    notion: str | None = None
    situation: dict | None = None

from pydantic import BaseModel, ConfigDict, Field

class ResultatTest(BaseModel):
    note: int
    mention: str
    notionsNonAcquises: List[str]
    questionsRemediation: List[ResultatRemediation] = Field(default_factory=list)

    model_config = ConfigDict(from_attributes=True)
class EnvoiPDFRequest(BaseModel):
    apprenant: dict
    niveau: str
    pdfBase64: str
    model_config = ConfigDict(from_attributes=True)




class RemediationRequest(BaseModel):
    niveau: str


# -------------------- Fonctions utilitaires -------------------- #
def get_mention(note: int) -> str:
    return (
        "Excellente" if note >= 18 else
        "Très Bien" if note >= 16 else
        "Bien" if note >= 14 else
        "Assez Bien" if note >= 12 else
        "Passable" if note >= 10 else
        "Insuffisant"
    )

_resultats_lock = threading.Lock()

def sauvegarder_resultat(resultat: Dict):
    with _resultats_lock:
        historiques = []
        if os.path.exists(RESULTATS_FILE):
            with open(RESULTATS_FILE, "r", encoding="utf-8") as f:
                historiques = json.load(f)
        historiques.append(resultat)
        with open(RESULTATS_FILE, "w", encoding="utf-8") as f:
            json.dump(historiques, f, indent=2, ensure_ascii=False)

# -------------------- Routes Questions -------------------- #
@app.get("/api/questions/{niveau}")
def get_questions_par_niveau(niveau: str, serie: Optional[str] = Query(None)):
    niveau = niveau.lower()
    if not est_serie_valide(niveau, serie):
        raise HTTPException(400, f"Série invalide pour le niveau {niveau} : {serie}")
    filtered = [q for q in questions if q["niveau"].lower() == niveau and (serie is None or q.get("serie", "").lower() == serie.lower())]
    if not filtered:
        raise HTTPException(404, "Aucune question trouvée.")
    for q in filtered:
        random.shuffle(q["choix"])
    return [{k: v for k, v in q.items() if k != "bonne_reponse"} | {"options": q["choix"]} for q in filtered]







@app.get("/api/me")
def get_me(current_user: User = Depends(get_current_user)):
    return {
        "id": current_user.id,
        "email": current_user.email,
        "nom": current_user.nom,
        "prenom": current_user.prenom,
    }



@app.get("/api/admin/parrain/{email}")
def get_parrain_details(email: str, db: Session = Depends(get_db)):
    # Récupération du parrain
    parrain = db.query(User).filter(User.email == email).first()
    if not parrain:
        raise HTTPException(status_code=404, detail="Parrain non trouvé")

    # Récupération des filleuls dont le parrain_email correspond, mais en excluant le parrain lui-même
    filleuls = (
        db.query(User)
        .filter(User.parrain_email == email)
        .filter(User.email != email)  # <-- exclure le parrain lui-même
        .all()
    )

    return {
        "id": parrain.id,
        "nom": parrain.nom,
        "prenom": parrain.prenom,
        "email": parrain.email,
        "telephone": parrain.telephone,
        "date_inscription": parrain.date_inscription,
        "is_blocked": parrain.is_blocked,
        "total_filleuls": len(filleuls),
        "filleuls": [
            {
                "id": f.id,
                "nom": f.nom,
                "prenom": f.prenom,
                "email": f.email,
                "telephone": f.telephone,
                "date_inscription": f.date_inscription,
                "is_blocked": f.is_blocked,
                "is_online": f.is_online,
            }
            for f in filleuls
        ],
    }




@app.get("/api/questions_fichier/{niveau}")
def get_questions_par_fichier(niveau: str, serie: Optional[str] = Query(None)):
    niveau = niveau.lower()
    if not est_serie_valide(niveau, serie):
        raise HTTPException(400, "Niveau ou série invalide.")
    chemin = os.path.join(DATA_DIR, f"{niveau}_{serie.lower()}.json" if serie else f"{niveau}.json")
    if not os.path.exists(chemin):
        raise HTTPException(404, f"Fichier {chemin} introuvable.")
    with open(chemin, "r", encoding="utf-8") as f:
        data = json.load(f)
    for q in data:
        random.shuffle(q["choix"])
    return [{k: v for k, v in q.items() if k != "bonne_reponse"} | {"options": q["choix"]} for q in data]

@app.get("/api/questions/{niveau}/selection")
def get_questions_par_notions_aleatoires(niveau: str, serie: Optional[str] = Query(None)):
    niveau = niveau.lower()
    niveau_avec_serie = ['2nde', '1ere', 'tle']
    niveau_sans_serie = ['6e', '5e', '4e', '3e']

    if niveau in niveau_sans_serie and serie is not None:
        raise HTTPException(400, f"Aucune série ne doit être précisée pour le niveau {niveau}.")
    
    if niveau in niveau_avec_serie:
        if serie is None:
            raise HTTPException(400, f"La série est obligatoire pour le niveau {niveau}.")
        serie = serie.upper()
        series_valides = {'A', 'B', 'C', 'D', 'E', 'F', 'G'}
        sous_series_map = {"A": ["A1", "A2"], "F": ["F1", "F2", "F3", "F4"], "G": ["G1", "G2", "G3"]}
        toutes_series_valides = set(series_valides)
        for s, sous_s in sous_series_map.items():
            toutes_series_valides.update(sous_s)
        if serie not in toutes_series_valides:
            raise HTTPException(400, f"Série '{serie}' invalide pour le niveau {niveau}.")
    
    elif niveau not in niveau_sans_serie:
        raise HTTPException(400, f"Niveau scolaire '{niveau}' invalide.")

    filtered = [
        q for q in questions
        if q["niveau"].lower() == niveau and (
            niveau in niveau_sans_serie or
            q.get("serie", "").lower() == serie.lower()
        )
    ]

    questions_par_notion = defaultdict(list)
    for q in filtered:
        questions_par_notion[q["notion"]].append(q)

    resultat = []
    for groupe in questions_par_notion.values():
        resultat.extend(random.sample(groupe, min(2, len(groupe))))
    random.shuffle(resultat)

    for q in resultat:
        random.shuffle(q["choix"])

    return [
        {k: v for k, v in q.items() if k != "bonne_reponse"} | {"options": q["choix"], "duree": q.get("duration", 60)}
        for q in resultat
    ]
@app.get("/api/questions/{niveau}/generation")
def generer_test(
    niveau: str,
    serie: Optional[str] = Query(None),
    current_user: User = Depends(get_current_user)
):
    niveau = niveau.lower()
    ordres_niveaux = ['6e', '5e', '4e', '3e', '2nde', '1ere', 'tle']

    if niveau not in ordres_niveaux:
        raise HTTPException(status_code=400, detail="Niveau invalide")

    niveau_index = ordres_niveaux.index(niveau)

    # Déterminer les niveaux à inclure
    niveaux_a_inclure = ordres_niveaux[:niveau_index + 1]

    # Filtrage des questions
    filtered = []
    for q in questions:
        q_niveau = q.get("niveau", "").strip().lower()
        q_serie = q.get("serie", None)
        if q_niveau in ['6e','5e','4e','3e']:  # Collège
            if q_niveau in niveaux_a_inclure:
                filtered.append(q)
        else:  # Lycée
            if serie is None:
                raise HTTPException(status_code=400, detail="La série est obligatoire pour le lycée")
            if q_niveau in niveaux_a_inclure and q_serie and q_serie.upper() == serie.upper():
                filtered.append(q)

    if not filtered:
        raise HTTPException(status_code=404, detail="Aucune question disponible pour ce niveau/serie")

    # Limiter à 20 questions au total, aléatoires
    nb_questions = min(20, len(filtered))
    questions_posees = random.sample(filtered, nb_questions)

    # Créer test_id et sauvegarder
    test_id = str(uuid.uuid4())
    sauvegarder_test({
        "test_id": test_id,
        "user_id": current_user.id,
        "niveau": niveau,
        "serie": serie,
        "questions_ids": [q["id"] for q in questions_posees],
        "date": datetime.now().isoformat()
    })

    return {"test_id": test_id, "questions": questions_posees}





@app.post(
    "/api/questions/{niveau}/resultats",
    response_model=ResultatTest
)
def evaluer_test_par_niveau(
    niveau: str,
    payload: ReponsesModel,
    test_id: str = Query(...),
    current_user: User = Depends(get_current_user)
):
    print("\n")
    print("================================================")
    print("🚀 ÉVALUATION DU TEST")
    print("================================================")

    # --------------------------------------------------
    # 1. RÉCUPÉRATION DU TEST
    # --------------------------------------------------

    test_data = charger_test(test_id)

    print("🆔 TEST ID :", test_id)
    print("📦 TEST DATA :", test_data)

    if not test_data:
        raise HTTPException(
            404,
            detail="Test introuvable"
        )

    if test_data["user_id"] != current_user.id:
        raise HTTPException(
            404,
            detail="Test introuvable ou non autorisé"
        )

    # --------------------------------------------------
    # 2. RÉCUPÉRATION DES RÉPONSES DE L'ÉLÈVE
    # --------------------------------------------------

    reponses = {
        str(r.id): r.reponse
        for r in payload.resultats
    }

    print("📥 RÉPONSES REÇUES :", reponses)

    # --------------------------------------------------
    # 3. QUESTIONS DISPONIBLES
    # --------------------------------------------------

    print("📚 NOMBRE QUESTIONS GLOBAL :", len(questions))

    print(
        "📚 IDS QUESTIONS GLOBAL :",
        [str(q["id"]) for q in questions]
    )

    # --------------------------------------------------
    # 4. QUESTIONS DU TEST
    # --------------------------------------------------

    questions_test = test_data.get("questions")

    print("📝 QUESTIONS DU TEST :", questions_test)

    if questions_test is None:
        print(
            "⚠️ Le test sauvegardé ne contient pas de clé 'questions'."
        )

        # Si ton architecture utilise encore la variable globale
        questions_test = questions

    print(
        "📚 NOMBRE QUESTIONS TEST :",
        len(questions_test)
    )

    print(
        "📚 IDS QUESTIONS TEST :",
        [str(q["id"]) for q in questions_test]
    )

    # --------------------------------------------------
    # 5. FILTRAGE PAR IDS
    # --------------------------------------------------

    questions_ids = {
        str(qid)
        for qid in test_data.get("questions_ids", [])
}

    filtered = [
        q
        for q in questions
        if str(q["id"]) in questions_ids
        and str(q["id"]) in reponses
]

    print("🎯 FILTERED :", filtered)

    print(
        "🎯 NOMBRE FILTERED :",
        len(filtered)
    )

    # --------------------------------------------------
    # 6. AUCUNE QUESTION
    # --------------------------------------------------

    if not filtered:
        print("❌ AUCUNE QUESTION CORRESPONDANTE")

        raise HTTPException(
            404,
            detail="Aucune question valide dans ce test"
        )

    # --------------------------------------------------
    # 7. CONSTRUCTION DES QUESTIONS DE REMÉDIATION
    # --------------------------------------------------

    questions_remediation = []

    for q in filtered:

        question_id = str(q["id"])

        reponse_apprenant = reponses.get(question_id)

        bonne_reponse = q.get("bonne_reponse")

        correcte = (
            reponse_apprenant is not None
            and bonne_reponse is not None
            and str(reponse_apprenant).strip().lower()
            ==
            str(bonne_reponse).strip().lower()
        )

        question_remediation = {
            "id": question_id,
            "question": q.get("question"),
            "classe": q.get("niveau"),
            "choix": q.get("choix", []),
            "correcte": correcte,
            "bonne_reponse": bonne_reponse,
            "reponse_apprenant": reponse_apprenant,
            "notion": q.get("notion"),
            "situation": q.get("situation"),
        }

        questions_remediation.append(
            question_remediation
        )

    # --------------------------------------------------
    # 8. DEBUG FINAL
    # --------------------------------------------------

    print("================================================")
    print("📚 QUESTIONS REMEDIATION")
    print(
        "📚 NOMBRE :",
        len(questions_remediation)
    )
    print(
        "📚 DONNÉES :",
        questions_remediation
    )
    print("================================================")

    # --------------------------------------------------
    # 9. ÉVALUATION
    # --------------------------------------------------

    note, mention, non_acquises = evaluer_reponses(
        filtered,
        reponses
    )

    # --------------------------------------------------
    # 10. SAUVEGARDE
    # --------------------------------------------------
    print("\n")
    print("=" * 80)
    print("🔎 DEBUG AVANT SAUVEGARDE DU RÉSULTAT")
    print("=" * 80)

    print("📌 Nombre de questions de remédiation :",
      len(questions_remediation))

    print("📌 Type de questions_remediation :",
      type(questions_remediation))

    print("📌 questions_remediation :")
    print(questions_remediation)

    print("-" * 80)

    for i, qr in enumerate(questions_remediation, start=1):
        print(f"📝 QUESTION DE REMÉDIATION #{i}")
        print("   id                  :", qr.get("id"))
        print("   question            :", qr.get("question"))
        print("   classe              :", qr.get("classe"))
        print("   choix               :", qr.get("choix"))
        print("   correcte            :", qr.get("correcte"))
        print("   bonne_reponse       :", qr.get("bonne_reponse"))
        print("   reponse_apprenant   :", qr.get("reponse_apprenant"))
        print("   notion              :", qr.get("notion"))
        print("   situation           :", qr.get("situation"))
        print("-" * 80)

        print("📚 Notions non acquises :", non_acquises)

        print("=" * 80)
        print("💾 SAUVEGARDE EN COURS...")
        print("=" * 80)

    sauvegarder_resultat({
        "user_id": current_user.id,
        "niveau": test_data["niveau"],
        "serie": test_data["serie"],
        "note": note,
        "mention": mention,
        "nbQuestions": len(filtered),
        "nbBonnesReponses": sum(
            1
            for q in filtered
            if (
                str(q["id"]) in reponses
                and
                str(q["bonne_reponse"]).strip().lower()
                ==
                str(reponses[str(q["id"])]).strip().lower()
            )
        ),
        "notionsNonAcquises": non_acquises,
        "questionsRemediation": questions_remediation,
        "date": datetime.now().isoformat()
    })

    # --------------------------------------------------
    # 11. SUPPRESSION DU TEST TEMPORAIRE
    # --------------------------------------------------

    supprimer_test(test_id)

    # --------------------------------------------------
    # 12. RÉPONSE
    # --------------------------------------------------

    resultat = ResultatTest(
        note=note,
        mention=mention,
        notionsNonAcquises=non_acquises,
        questionsRemediation=questions_remediation
    )

    print("================================================")
    print("📤 RÉPONSE FINALE")
    print("📤 RESULTAT :", resultat)
    print("📤 QUESTIONS REMEDIATION :", resultat.questionsRemediation)
    print("================================================")

    return resultat

@app.get("/api/resultats/dernier", response_model=ResultatTest)
def get_last_result(
    niveau: str,
    serie: Optional[str] = Query(None),
    current_user: User = Depends(get_current_user)
):
    if not os.path.exists(RESULTATS_FILE):
        raise HTTPException(404, "Aucun résultat trouvé.")

    with open(RESULTATS_FILE, "r", encoding="utf-8") as f:
        historiques = json.load(f)

    niveau = niveau.lower()
    serie = serie.lower() if serie else None
    user_id = current_user.id

    # Filtrer les résultats avec flexibilité sur serie
    def serie_eq(r_serie, query_serie):
        if query_serie is None:
            return r_serie is None or r_serie == ""
        return (r_serie or "").lower() == query_serie

    filtres = [
        r for r in historiques
        if r.get("user_id") == user_id
        and r.get("niveau", "").lower() == niveau
        and serie_eq(r.get("serie"), serie)
    ]

    if not filtres:
        raise HTTPException(404, "Aucun résultat trouvé pour ce niveau et cette série.")

    # Trier par date (le plus récent en premier)
    filtres.sort(key=lambda r: datetime.fromisoformat(r["date"]), reverse=True)
    dernier = filtres[0]

    return ResultatTest(
        note=dernier["note"],
        mention=dernier["mention"],
        notionsNonAcquises=dernier["notionsNonAcquises"],
        questionsRemediation=dernier.get("questionsRemediation",[])
)

async def send_email_with_pdf(to_email: str, pdf_path: str, nom_fichier: str):
    """
    Envoie la fiche de résultats PDF via l'API Brevo.
    """

    html_content = f"""
    <html>
      <body style="font-family: Arial, sans-serif; background-color: #f5f5f5; padding: 30px;">
        <div style="max-width: 600px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1);">
          <div style="text-align: center;">
            <h2 style="color: #0055a5;">Résultats de votre évaluation diagnostique</h2>
          </div>

          <p>Bonjour,</p>

          <p>
            Veuillez trouver ci-joint votre fiche de résultats générée
            par notre plateforme <strong>CODE</strong>.
          </p>

          <p style="margin-top: 20px;">
            Bonne continuation dans vos apprentissages&nbsp;!
          </p>

          <p style="margin-top: 30px;">
            Cordialement,<br>
            L'équipe <strong>CODE</strong>
          </p>

          <hr style="margin-top: 40px;" />

          <p style="font-size: 12px; color: #888888; text-align: center;">
            Ce message a été généré automatiquement. Merci de ne pas y répondre.
          </p>
        </div>
      </body>
    </html>
    """

    return await send_email(
        to=to_email,
        subject="📝 Vos résultats CODE – Fiche PDF",
        body="Veuillez trouver ci-joint votre fiche de résultats CODE.",
        html_body=html_content,
        attachments=[
            {
                "path": pdf_path,
                "name": nom_fichier,
            }
        ],
    )

@app.post("/api/send-result-pdf")
async def envoyer_resultat_pdf(
    file: UploadFile = File(...),
    niveau: str = Form(...),
    apprenant: str = Form(...)
):
    try:
        data = json.loads(apprenant)
        email = data.get("email")
        prenom = data.get("prenom")
        nom = data.get("nom")

        if not email or not prenom or not nom:
            raise HTTPException(status_code=400, detail="Données incomplètes pour l'apprenant.")

        # Sauvegarde du fichier PDF temporairement
        contenu = await file.read()
        os.makedirs("pdfs", exist_ok=True)
        filename = f"{prenom}_{nom}_{niveau}.pdf"
        chemin = os.path.join("pdfs", filename)
        with open(chemin, "wb") as f:
            f.write(contenu)

        # Envoi de l'e-mail avec pièce jointe
        await send_email_with_pdf(to_email=email, pdf_path=chemin, nom_fichier=filename)

        return {"message": f"PDF envoyé à {email}"}

    except json.JSONDecodeError:
        raise HTTPException(status_code=400, detail="Format JSON invalide dans le champ 'apprenant'")
    except Exception as e:
        import traceback
        traceback.print_exc()
        raise HTTPException(status_code=500, detail=f"Erreur serveur : {str(e)}")



async def send_notification_email(to_email: str, subject: str, content: str):
    """
    Envoie une notification email via le système centralisé
    défini dans utils/email.py.
    """
    return await send_email(
        to=to_email,
        subject=subject,
        body=content,
    )



@app.get("/debug-routes")
def debug_routes():
    return [route.path for route in app.routes]









# -------------------- Chargement des vidéos -------------------- #
DATA_PATH = Path(__file__).parent / "data" / "remediationVideos.json"

# -------------------- Fonctions utilitaires --------------------
def normalize_string(s: str) -> str:
    if not s:
        return ""
    return unicodedata.normalize("NFKD", s).encode("ASCII", "ignore").decode().lower().strip()

def get_niveaux_inferieurs(niveau: str) -> List[str]:
    niveaux_ordre = ['6e', '5e', '4e', '3e', '2nde', '1ere', 'Tle']
    niveau_norm = normalize_string(niveau)
    for i, n in enumerate(niveaux_ordre):
        if normalize_string(n) == niveau_norm:
            return niveaux_ordre[:i+1]
    return [niveau]

def load_videos() -> List[dict]:
    try:
        with open(DATA_PATH, "r", encoding="utf-8") as f:
            data = json.load(f)
        return data if isinstance(data, list) else [data]
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Erreur lecture JSON : {e}")

def filter_videos(all_videos: List[dict], niveau: str, notion_cible: Optional[str] = None) -> List[dict]:
    """
    Retourne la séquence de vidéos pour une notion donnée et ses prérequis,
    en respectant l'ordre exact défini dans le JSON et les niveaux inférieurs.
    """
    seen_ids: Set[str] = set()
    final_videos: List[dict] = []
    niveaux_valides = get_niveaux_inferieurs(niveau)

    # Mapping notion -> liste de vidéos pour accès rapide
    notion_to_videos = defaultdict(list)
    for v in all_videos:
        v_niveau = v.get("niveau")
        if v_niveau and normalize_string(v_niveau) in [normalize_string(n) for n in niveaux_valides]:
            for n in v.get("notions", []):
                notion_to_videos[normalize_string(n)].append(v)

    def add_video_recursive(video: dict):
        vid_id = video.get("id")
        if not vid_id or vid_id in seen_ids:
            return
        for prereq in video.get("prerequis", []):
    # Recherche la vidéo correspondante par son titre
         for prereq_vid in all_videos:
          if normalize_string(prereq_vid["titre"]) == normalize_string(prereq):
            add_video_recursive(prereq_vid)

        final_videos.append(video)
        seen_ids.add(vid_id)

    # Cas notion cible
    if notion_cible:
        cible_vids = notion_to_videos.get(normalize_string(notion_cible), [])
        for v in cible_vids:
            add_video_recursive(v)
    else:
        # Sinon toutes les vidéos du niveau et inférieurs
        for v in all_videos:
            if normalize_string(v.get("niveau")) in [normalize_string(n) for n in niveaux_valides]:
                add_video_recursive(v)

    return final_videos

# -------------------- API Notions --------------------
@app.get("/api/notions")
def get_notions(niveau: str):
    """
    Retourne la liste des notions disponibles pour un niveau donné,
    dans l'ordre exact du JSON.
    """
    videos = load_videos()
    seen_notions: Set[str] = set()
    ordered_notions: List[str] = []

    for vid in videos:
        vid_notions = vid.get("notions", [])
        niveaux_vid = {q.get("niveau") for q in vid.get("questions", []) if q.get("niveau")}
        if niveau in niveaux_vid:
            for n in vid_notions:
                if n not in seen_notions:
                    ordered_notions.append(n)
                    seen_notions.add(n)

    return {"notions": [{"notion": n} for n in ordered_notions]}


# -------------------- API Vidéos Remédiation --------------------
@app.get("/api/videos/remediation")
def get_remediation_videos(niveau: str = Query(...)):
    all_videos = load_videos()
    niveaux_valides = get_niveaux_inferieurs(niveau)

    seen_ids: Set[str] = set()
    result: List[dict] = []

    def add_video_recursive(video: dict):
        vid_id = video.get("id")
        if not vid_id or vid_id in seen_ids:
            return

        # Ajouter d'abord les prérequis
        for prereq_titre in video.get("prerequis", []):
            prereq_video = next(
                (v for v in all_videos
                 if normalize_string(v.get("titre")) == normalize_string(prereq_titre)),
                None
            )
            if prereq_video:
                add_video_recursive(prereq_video)

        # Ajouter la vidéo courante
        result.append(video)
        seen_ids.add(vid_id)

    # Ajouter les vidéos dans l’ordre
    for video in all_videos:
        if normalize_string(video.get("niveau")) in [normalize_string(n) for n in niveaux_valides]:
            add_video_recursive(video)

    return [
    {
        "id": v["id"],
        "titre": v["titre"],
        "niveau": v["niveau"],
        "fichier": v.get("fichier") or v.get("videoUrl"),
        "mois": v.get("mois"),     # optionnel
        "notions": v.get("notions"),
        "prerequis": v.get("prerequis"),
        "questions": v.get("questions"),
        "videoUrl": v.get("videoUrl"),

        # 👉 Ajout demandé : Exercices transmis au frontend
        #    Optionnel : renvoie None si absent, ne casse rien
        "exercices": v.get("exercices"),
    }
    for v in result
]




def get_timestamp():
    tz = ZoneInfo("Africa/Lagos")  # GMT+1 (peut aussi utiliser "Europe/Paris")
    return datetime.now(tz).strftime("%d/%m/%Y à %H:%M:%S")


# ⚙️ Configuration du logger
handler = logging.StreamHandler()
formatter = TZFormatter(
    fmt="%(asctime)s | %(levelname)s | %(message)s",
    datefmt="%d/%m/%Y à %H:%M:%S"
)
handler.setFormatter(formatter)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)
logger.addHandler(handler)


@app.post("/api/notify/remediation")
async def notify_remediation(
    data: RemediationVideo,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user)
):
    niveau = data.niveau
    videos = get_remediation_videos(niveau)
    titres = [
    f"{v.get('titre', 'Sans titre')} (Disponible à partir du mois de {data.start_month or v.get('mois', [''])[0]})"
    for v in videos
]


    subject = "📌🔔CODE Plan du cours🔔"
    content = (
        f"Date et Heure: {get_timestamp()}\n\n"
        f"{current_user.nom} {current_user.prenom} doit visualiser les vidéos suivantes :\n\n"
        + "\n".join(f"- {t}" for t in titres)
    )

    background_tasks.add_task(send_notification_email,to_email=current_user.email, subject=subject, content=content)

    # Log structuré
    logger.info(f"Notification Remédiation envoyée à {current_user.email} | Niveau: {niveau}")

    return {"message": "Notification envoyée (RemediationVideo)"}


@app.post("/api/notify/videofinish")
async def notify_videofinish(
    data: VideoFinishRequest,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user)
):
    subject = "🎬🔔CODE Progression Vidéo🔔"

    if data.next_video_titre is not None:
      content = (
        f"{current_user.nom} {current_user.prenom} a terminé '{data.video_titre}' le {get_timestamp()}"
        f" et passe maintenant à '{data.next_video_titre}'."
    )
    else:
      content = (
        f"{current_user.nom} {current_user.prenom} a terminé '{data.video_titre}' le {get_timestamp()}"
        f" et n’a plus de vidéo pour cette matière."
    )

    
    background_tasks.add_task(send_notification_email, 
    to_email=current_user.email,
    subject=subject,
    content=content
)


    logger.info(f"🎬 Vidéo terminée : {data.video_titre} | Utilisateur: {current_user.email}")

    return {"message": "Notification envoyée (Vidéo terminée)"}


@app.post("/api/notify/connect")
async def notify_connect(
    payload: NotifyRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db)
):
    user = db.query(User).filter(User.email == payload.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.is_online = True
    db.commit()

    try:
        subject = "✅🔔CODE Connexion🔔"
        content = (
            
            f" {user.nom} {user.prenom} vient de se connecter le {get_timestamp()}"
        )
        await send_notification_email(to_email=user.email, subject=subject, content=content)

    except Exception as e:
        logger.error(f"Erreur envoi email connexion : {e}")

    logger.info(f"✅ Connexion réussie | Utilisateur: {user.email}")

    return {"status": "ok", "message": f"{user.email} is now connected"}


@app.post("/api/notify/disconnect")
async def notify_disconnect(
    payload: NotifyRequest,
    background_tasks: BackgroundTasks,
    db: Session = Depends(get_db)
):
    user = db.query(User).filter(User.email == payload.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.is_online = False
    db.commit()

    try:
        subject = "❌🔔CODE Déconnexion🔔"
        content = (
            
            f"{user.nom} {user.prenom}  a quitté CODE le {get_timestamp()}"
        )
        await send_notification_email(to_email=user.email, subject=subject, content=content)

    except Exception as e:
        logger.error(f"Erreur envoi email déconnexion : {e}")

    logger.info(f"❌ Déconnexion réussie | Utilisateur: {user.email}")

    return {"status": "ok", "message": f"{user.email} is now disconnected"}


   


def send_warning_automatique():
    db: Session = next(get_db())
    utilisateurs = db.query(User).all()
    
    for user in utilisateurs:
        # Si jamais d'avertissement n'a été envoyé ou que 21 jours se sont écoulés
        if not user.last_warning or (datetime.utcnow() - user.last_warning).days >= 20:
            user.last_warning = datetime.utcnow()
            db.commit()
            
            subject = "Avertissement CODE"
            content = (
                f"Bonjour {user.nom} {user.prenom},\n\n"
                "Vous devez renouveller votre abonnement pour ne pas avoir un accès bloqué sur CODE.\n\n"
                "Cordialement,\nL'équipe CODE"
            )
            # On peut utiliser threading ou background_tasks si tu veux l'intégrer à FastAPI
            send_email_sync(to=user.email, subject=subject, body=content)
            print(f"Avertissement envoyé à {user.email}")

# Scheduler qui s'exécute tous les jours à minuit
scheduler = BackgroundScheduler()
scheduler.add_job(send_warning_automatique, 'interval', days=1)
scheduler.start()














# -------------------- Startup -------------------- #
@app.on_event("startup")
async def startup_event():
    print("🚀 Liste des routes enregistrées :")
    for route in app.router.routes:
        print(f"🛣️  {route.path} -> {route.name}")