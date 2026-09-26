import sys
from fastapi import FastAPI, Query, HTTPException, Request, Depends, UploadFile, File, Form
from fastapi.responses import JSONResponse
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from pydantic import BaseModel, ConfigDict
from typing import Dict, List, Optional, Set
import json
import os
import asyncio
from fastapi import Request, BackgroundTasks
from apscheduler.schedulers.background import BackgroundScheduler
from zoneinfo import ZoneInfo
import logging
import requests
import random
from routes.activation import router as activation_router
from routes.admin_routes import router as admin_router
from routes.teacher import router as teacher_router
from routes.project_ideas import router as project_ideas_router
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
from routes.ia import router as ia_router
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
app.include_router(teacher_router)


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




class PageTranslationRequest(BaseModel):

    source_language: str = "fr"

    target_language: str = "en"

    texts: list[str]






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
app.include_router(project_ideas_router)
app.include_router(admin_dashboard_router)
app.include_router(question_messages_router)
app.include_router(ia_router)

# -------------------- Debug Middleware -------------------- #
async def update_last_seen_in_db(user_id: int):
    db = next(get_db())

    try:
        user = db.query(User).filter(User.id == user_id).first()

        if user:
            user.last_seen = datetime.utcnow()
            db.add(user)
            db.commit()
            print(f"✅ last_seen mis à jour pour {user.email}")

    except Exception as e:
        db.rollback()
        print(f"⚠️ Erreur lors de la mise à jour last_seen : {e}")

    finally:
        db.close()


@app.middleware("http")
async def update_last_seen_middleware(
    request: Request,
    call_next
):
    public_routes = [
        "/api/auth/login",
        "/api/auth/register",
        "/api/announcements/current",
    ]

    # Les requêtes OPTIONS doivent passer directement
    if request.method == "OPTIONS":
        return await call_next(request)

    # Les routes publiques passent directement
    if any(
        request.url.path.startswith(route)
        for route in public_routes
    ):
        return await call_next(request)

    background_tasks = BackgroundTasks()

    auth_header = request.headers.get("Authorization")

    user_id = None

    if auth_header:
        print(
            f"🔐 Authorization Header reçu : {auth_header}"
        )

        try:
            token = (
                auth_header.split(" ")[1]
                if " " in auth_header
                else auth_header
            )

            db = next(get_db())

            try:
                current_user = get_current_user(
                    token,
                    db
                )

                if current_user:
                    user_id = current_user.id

            finally:
                db.close()

        except Exception as e:
            print(
                "⚠️ Erreur lors de la récupération "
                f"de l'utilisateur : {e}"
            )

    else:
        print("🚫 Aucun token reçu dans la requête")

    if user_id:
        background_tasks.add_task(
            update_last_seen_in_db,
            user_id
        )

    response = await call_next(request)

    response.background = background_tasks

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
    matiere: str
    niveau: str
    serie: Optional[str] = "none"
    test_id: str
    resultats: List[ReponseUnique]

    model_config = ConfigDict(from_attributes=True)

class ResultatRemediation(BaseModel):
    id: str
    question: str

    classe: str | None = None

    choix: list[str] = Field(
        default_factory=list
    )

    correcte: bool = False

    bonne_reponse: str | None = None

    reponse_apprenant: str | None = None

    notion: str | None = None

    situation: dict | None = None

    enseignant: str | None = None

    matiere: str | None = None

    serie: str | list[str] | None = None

    model_config = ConfigDict(
        from_attributes=True
    )

from pydantic import BaseModel, ConfigDict, Field

class ResultatTest(BaseModel):
    matiere: str | None = None
    niveau: str | None = None
    serie: str | None = None

    note: int

    mention: str

    notionsNonAcquises: List[str]

    questionsRemediation: List[
        ResultatRemediation
    ] = Field(
        default_factory=list
    )

    model_config = ConfigDict(
        from_attributes=True
    )
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




# ============================================================
# NORMALISATION DES DONNÉES DES QUESTIONS
# ============================================================

def normalize_text(value: Optional[str]) -> str:
    """
    Normalise une chaîne :
    - supprime les espaces inutiles
    - supprime les accents
    - met en minuscule
    """
    if value is None:
        return ""

    value = str(value).strip()

    return (
        unicodedata
        .normalize("NFD", value)
        .encode("ascii", "ignore")
        .decode("ascii")
        .lower()
        .strip()
    )


def normalize_matiere(value: Optional[str]) -> str:
    """
    Normalise la matière utilisée dans les URLs et questions.json.
    """

    value = normalize_text(value)

    correspondances = {
        "mathematiques": "maths",
        "mathematique": "maths",
        "math": "maths",

        "francais": "francais",
        "francais": "francais",

        "physiquechimie": "pct",
        "physique_chimie": "pct",

        "intelligence artificielle": "intelligenceartificielle",
    }

    return correspondances.get(value, value)


def normalize_niveau(value: Optional[str]) -> str:
    """
    Transforme les différentes écritures du niveau
    vers le format utilisé par les URLs CODE.

    Exemples :
        Terminale -> tle
        Tle       -> tle
        1ère      -> 1ere
        Première  -> 1ere
        2nde      -> 2nde
    """

    value = normalize_text(value)

    correspondances = {
        "6eme": "6e",
        "5eme": "5e",
        "4eme": "4e",
        "3eme": "3e",

        "2nde": "2nde",
        "seconde": "2nde",

        "1ere": "1ere",
        "premiere": "1ere",

        "tle": "tle",
        "terminale": "tle",
    }

    return correspondances.get(value, value)


def normalize_serie(value: Optional[str]) -> str:
    if value is None:
        return "none"

    value = str(value).strip()

    if not value:
        return "none"

    return value.lower()


def question_serie_contient(
    question_serie,
    serie_recherchee: Optional[str]
) -> bool:
    """
    Vérifie une série dans questions.json.

    Accepte :

        "F2"

    ou :

        ["F1", "F2", "F3", "F4"]

    ou :

        None / "none"
    """

    serie_recherchee = normalize_serie(
        serie_recherchee
    )

    # Pour le collège
    if serie_recherchee == "none":
        return True

    if question_serie is None:
        return False

    # Cas :
    # "F2"
    if isinstance(question_serie, str):
        return (
            normalize_serie(question_serie)
            == serie_recherchee
        )

    # Cas :
    # ["F1", "F2", "F3", "F4"]
    if isinstance(question_serie, list):
        return any(
            normalize_serie(s)
            == serie_recherchee
            for s in question_serie
        )

    return False


def question_matiere_correspond(
    question: dict,
    matiere_recherchee: str
) -> bool:
    """
    Vérifie que la question appartient à la matière demandée.
    """

    matiere_question = normalize_matiere(
        question.get("matiere")
    )

    matiere_recherchee = normalize_matiere(
        matiere_recherchee
    )

    return (
        matiere_question
        == matiere_recherchee
    )


def question_niveau_correspond(
    question: dict,
    niveau_recherche: str
) -> bool:
    """
    Vérifie le niveau d'une question
    indépendamment de son écriture dans JSON.
    """

    niveau_question = normalize_niveau(
        question.get("niveau")
    )

    return (
        niveau_question
        == normalize_niveau(
            niveau_recherche
        )
    )

# ============================================================
# HIÉRARCHIE DES NIVEAUX POUR LE DIAGNOSTIC
# ============================================================

NIVEAUX_ORDRE = [
    "6e",
    "5e",
    "4e",
    "3e",
    "2nde",
    "1ere",
    "tle",
]

NIVEAUX_COLLEGE = {
    "6e",
    "5e",
    "4e",
    "3e",
}

NIVEAUX_LYCEE = {
    "2nde",
    "1ere",
    "tle",
}


def niveaux_diagnostiques(
    niveau_actuel: str
) -> List[str]:
    """
    Retourne les niveaux qui doivent être évalués
    pour le diagnostic.

    6e       -> 6e
    5e       -> 6e
    4e       -> 6e + 5e
    3e       -> 6e + 5e + 4e
    2nde     -> 6e + 5e + 4e + 3e
    1ere     -> 6e + 5e + 4e + 3e + 2nde
    tle      -> 6e + 5e + 4e + 3e + 2nde + 1ere

    Le niveau actuel est exclu pour le diagnostic,
    sauf pour la 6e qui constitue le point de départ.
    """

    niveau = normalize_niveau(niveau_actuel)

    if niveau not in NIVEAUX_ORDRE:
        raise ValueError(
            f"Niveau inconnu : {niveau_actuel}"
        )

    index = NIVEAUX_ORDRE.index(niveau)

    # Pour la 6e, il faut quand même des questions de 6e
    if niveau == "6e":
        return ["6e"]

    return NIVEAUX_ORDRE[:index]



# ============================================================
# TRADUCTION GLOBALE DES PAGES — ARGOS TRANSLATE
# ============================================================

TRANSLATE_PYTHON = Path(sys.executable)

TRANSLATE_WORKER = (
    Path(__file__).resolve().parent
    / "translation_worker.py"
)


@app.post("/api/translate/page")
async def translate_page(
    payload: PageTranslationRequest,
):
    """
    Traduit plusieurs textes d'une page avec
    Argos Translate.

    Le moteur Argos est installé dans l'environnement
    isolé translate_env afin de ne pas modifier
    l'environnement Python principal du backend.
    """

    # ========================================================
    # 1. VÉRIFICATION DU MOTEUR
    # ========================================================

    if not TRANSLATE_PYTHON.exists():

        raise HTTPException(
            status_code=500,
            detail=(
                "Le moteur de traduction local est introuvable : "
                f"{TRANSLATE_PYTHON}"
            ),
        )

    if not TRANSLATE_WORKER.exists():

        raise HTTPException(
            status_code=500,
            detail=(
                "Le worker de traduction est introuvable : "
                f"{TRANSLATE_WORKER}"
            ),
        )

    # ========================================================
    # 2. VÉRIFICATION DES LANGUES
    # ========================================================

    source_language = (
        payload.source_language or "fr"
    ).strip().lower()

    target_language = (
        payload.target_language or "en"
    ).strip().lower()

    if not source_language or not target_language:

        raise HTTPException(
            status_code=400,
            detail="Les langues source et cible sont obligatoires.",
        )

    # ========================================================
    # 3. AUCUN TEXTE
    # ========================================================

    if not payload.texts:

        return {
            "success": True,
            "source_language": source_language,
            "target_language": target_language,
            "translations": [],
        }

    # ========================================================
    # 4. NETTOYAGE DES TEXTES
    # ========================================================

    texts = []

    for text in payload.texts:

        if text is None:
            texts.append("")
            continue

        texts.append(str(text))

    # ========================================================
    # 5. LIMITATION DE SÉCURITÉ
    # ========================================================

    if len(texts) > 500:

        raise HTTPException(
            status_code=400,
            detail=(
                "Trop de textes envoyés en une seule requête. "
                "Maximum : 500 textes."
            ),
        )

    total_characters = sum(
        len(text)
        for text in texts
    )

    if total_characters > 100000:

        raise HTTPException(
            status_code=400,
            detail=(
                "Le contenu envoyé est trop volumineux. "
                "Maximum : 100 000 caractères."
            ),
        )

    # ========================================================
    # 6. CONSTRUCTION DU PAYLOAD POUR ARGOS
    # ========================================================

    worker_payload = {
        "source_language": source_language,
        "target_language": target_language,
        "texts": texts,
    }

    # ========================================================
    # 7. LANCEMENT DU WORKER ARGOS
    # ========================================================

    try:

        translate_env = os.environ.copy()

        process = await asyncio.create_subprocess_exec(
            str(TRANSLATE_PYTHON),
            str(TRANSLATE_WORKER),
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
            env=translate_env,
)

    except Exception as exc:

        print(
            "❌ Impossible de lancer Argos Translate :",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Impossible de démarrer "
                "le moteur de traduction."
            ),
        )

    # ========================================================
    # 8. ENVOI DES DONNÉES AU WORKER
    # ========================================================

    try:

        input_data = json.dumps(
            worker_payload,
            ensure_ascii=False,
        ).encode("utf-8")

        stdout, stderr = await asyncio.wait_for(

            process.communicate(input_data),

            timeout=120,
        )

    except asyncio.TimeoutError:

        try:
            process.kill()
        except Exception:
            pass

        print(
            "❌ Timeout du moteur de traduction."
        )

        raise HTTPException(
            status_code=504,
            detail=(
                "La traduction a pris trop de temps."
            ),
        )

    except Exception as exc:

        print(
            "❌ Erreur pendant l'exécution "
            "du moteur de traduction :",
            repr(exc),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Erreur lors de l'exécution "
                "du moteur de traduction."
            ),
        )

    # ========================================================
    # 9. AFFICHAGE DES ERREURS ARGOS
    # ========================================================

    if stderr:

        stderr_text = stderr.decode(
            "utf-8",
            errors="replace",
        ).strip()

        if stderr_text:

            print(
                "ℹ️ Argos Translate :",
                stderr_text,
            )

    # ========================================================
    # 10. VÉRIFICATION DU CODE DE SORTIE
    # ========================================================

    if process.returncode != 0:

        stdout_text = stdout.decode(
            "utf-8",
            errors="replace",
        ).strip()

        print(
            "❌ Argos Translate a échoué."
        )

        print(
            "Sortie :",
            stdout_text,
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Le moteur de traduction "
                "a rencontré une erreur."
            ),
        )

    # ========================================================
    # 11. LECTURE DE LA RÉPONSE
    # ========================================================

    try:

        result = json.loads(
            stdout.decode(
                "utf-8",
                errors="replace",
            )
        )

    except Exception as exc:

        print(
            "❌ Réponse invalide du worker Argos :",
            repr(exc),
        )

        print(
            "Sortie brute :",
            stdout.decode(
                "utf-8",
                errors="replace",
            ),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Le moteur de traduction "
                "a retourné une réponse invalide."
            ),
        )

    # ========================================================
    # 12. VÉRIFICATION DU WORKER
    # ========================================================

    if not result.get("success"):

        print(
            "❌ Erreur Argos :",
            result.get("error"),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                result.get(
                    "error",
                    "Erreur inconnue du moteur de traduction.",
                )
            ),
        )

    translations = result.get(
        "translations",
        [],
    )

    # ========================================================
    # 13. VÉRIFICATION DU NOMBRE DE TRADUCTIONS
    # ========================================================

    if len(translations) != len(texts):

        print(
            "❌ Nombre de traductions incorrect :",
            len(translations),
            "/",
            len(texts),
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Le nombre de traductions retournées "
                "ne correspond pas au nombre de textes envoyés."
            ),
        )

    # ========================================================
    # 14. RÉPONSE AU FRONTEND
    # ========================================================

    return {
        "success": True,

        "source_language":
            source_language,

        "target_language":
            target_language,

        "translations":
            translations,
    }





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

# ============================================================
# GÉNÉRATION D'UN TEST DIAGNOSTIQUE GÉNÉRIQUE
# ============================================================

@app.get("/api/questions/{niveau}/generation")
def generer_test(
    niveau: str,
    matiere: str = Query(...),
    serie: Optional[str] = Query(None),
    exclure_niveau_actuel: bool = Query(True),
    current_user: User = Depends(get_current_user)
):
    """
    Génère un test diagnostique.

    Les choix sont mélangés avant d'être envoyés
    au frontend.

    La position réelle de la bonne réponse est sauvegardée
    dans bonne_reponse_lettre.

    Les questions exactes du test sont également sauvegardées
    afin que l'évaluation utilise exactement le même ordre
    que celui présenté à l'apprenant.
    """

    # ========================================================
    # 1. NORMALISATION
    # ========================================================

    niveau = normalize_niveau(niveau)
    matiere = normalize_matiere(matiere)
    serie = normalize_serie(serie)

    print("\n" + "=" * 80)
    print("🧠 GÉNÉRATION TEST DIAGNOSTIQUE")
    print("=" * 80)
    print("📚 Matière :", matiere)
    print("🎓 Niveau actuel :", niveau)
    print("📖 Série :", serie)
    print("👤 Utilisateur :", current_user.id)

    # ========================================================
    # 2. VÉRIFICATION DU NIVEAU
    # ========================================================

    if niveau not in NIVEAUX_ORDRE:
        raise HTTPException(
            status_code=400,
            detail=f"Niveau invalide : {niveau}"
        )

    # ========================================================
    # 3. VÉRIFICATION DE LA SÉRIE
    # ========================================================

    if niveau in NIVEAUX_COLLEGE:
        serie = "none"

    elif niveau in NIVEAUX_LYCEE:

        if serie == "none":
            raise HTTPException(
                status_code=400,
                detail=f"La série est obligatoire pour le niveau {niveau}."
            )

    # ========================================================
    # 4. NIVEAUX À ÉVALUER
    # ========================================================

    niveaux_a_inclure = niveaux_diagnostiques(niveau)

    if not exclure_niveau_actuel:

        index = NIVEAUX_ORDRE.index(niveau)

        niveaux_a_inclure = NIVEAUX_ORDRE[:index + 1]

    print(
        "📚 Niveaux diagnostiques :",
        niveaux_a_inclure
    )

    # ========================================================
    # 5. FILTRAGE DES QUESTIONS
    # ========================================================

    filtered = []

    for q in questions:

        # Matière
        if not question_matiere_correspond(
            q,
            matiere
        ):
            continue

        # Niveau
        q_niveau = normalize_niveau(
            q.get("niveau")
        )

        if q_niveau not in niveaux_a_inclure:
            continue

        # ----------------------------------------------------
        # COLLÈGE
        # ----------------------------------------------------

        if q_niveau in NIVEAUX_COLLEGE:

            filtered.append(q)

            continue

        # ----------------------------------------------------
        # LYCÉE
        # ----------------------------------------------------

        if q_niveau in NIVEAUX_LYCEE:

            if serie == "none":
                continue

            if not question_serie_contient(
                q.get("serie"),
                serie
            ):
                continue

            filtered.append(q)

    # ========================================================
    # 6. DEBUG
    # ========================================================

    print(
        "📊 Nombre total de questions trouvées :",
        len(filtered)
    )

    repartition = defaultdict(int)

    for q in filtered:

        q_niveau = normalize_niveau(
            q.get("niveau")
        )

        repartition[q_niveau] += 1

    print(
        "📊 Répartition par niveau :",
        dict(repartition)
    )

    # ========================================================
    # 7. AUCUNE QUESTION
    # ========================================================

    if not filtered:

        raise HTTPException(
            status_code=404,
            detail=(
                "Aucune question disponible "
                f"pour la matière '{matiere}', "
                f"le niveau '{niveau}', "
                f"la série '{serie}', "
                f"et les niveaux diagnostiques "
                f"{niveaux_a_inclure}."
            )
        )

    # ========================================================
    # 8. COPIE + MÉLANGE DES QUESTIONS
    # ========================================================

    questions_disponibles = []

    lettres = ["a", "b", "c", "d", "e"]

    for q in filtered:

        q_copy = dict(q)

        choix = q_copy.get("choix")

        if isinstance(choix, list):

            # Texte original de la bonne réponse
            bonne_reponse_texte = q_copy.get(
                "bonne_reponse"
            )

            # Copie indépendante des choix
            choix_melanges = list(choix)

            # Mélange
            random.shuffle(choix_melanges)

            # Recherche de la nouvelle position
            # de la bonne réponse
            bonne_reponse_lettre = None

            if bonne_reponse_texte is not None:

                for index, choix_actuel in enumerate(
                    choix_melanges
                ):

                    if normalize_text(
                        choix_actuel
                    ) == normalize_text(
                        bonne_reponse_texte
                    ):

                        if index < len(lettres):
                            bonne_reponse_lettre = lettres[index]

                        break

            # On conserve les choix mélangés
            q_copy["choix"] = choix_melanges

            # On conserve le texte original
            q_copy["bonne_reponse"] = bonne_reponse_texte

            # On ajoute la lettre correspondant
            # à la position après mélange
            q_copy["bonne_reponse_lettre"] = (
                bonne_reponse_lettre
            )

        # Durée
        q_copy["duree"] = q_copy.get(
            "duration",
            q_copy.get(
                "duree",
                60
            )
        )

        questions_disponibles.append(
            q_copy
        )

    # ========================================================
    # 9. LIMITER À 20 QUESTIONS
    # ========================================================

    nb_questions = min(
        20,
        len(questions_disponibles)
    )

    questions_posees = random.sample(
        questions_disponibles,
        nb_questions
    )

    # ========================================================
    # 10. CRÉATION DU TEST ID
    # ========================================================

    test_id = str(uuid.uuid4())

    # ========================================================
    # 11. SAUVEGARDE DU TEST EXACT
    # ========================================================

    sauvegarder_test(
        {
            "test_id": test_id,
            "user_id": current_user.id,
            "matiere": matiere,
            "niveau": niveau,
            "serie": serie,
            "niveaux_evalues": niveaux_a_inclure,
            "exclure_niveau_actuel": exclure_niveau_actuel,

            "questions_ids": [
                q["id"]
                for q in questions_posees
            ],

            # IMPORTANT :
            # on sauvegarde les questions exactement
            # comme elles ont été présentées.
            "questions": questions_posees,

            "date": datetime.now().isoformat(),
        }
    )

    # ========================================================
    # 12. DEBUG FINAL
    # ========================================================

    print("\n🆔 Test ID :", test_id)
    print(
        "📝 Nombre de questions :",
        len(questions_posees)
    )
    print(
        "📚 Niveaux évalués :",
        niveaux_a_inclure
    )

    # Vérification de quelques questions
    for q in questions_posees[:3]:

        print(
            "🧪 QUESTION :",
            q.get("id")
        )

        print(
            "   Bonne réponse :",
            q.get("bonne_reponse")
        )

        print(
            "   Lettre correcte :",
            q.get("bonne_reponse_lettre")
        )

        print(
            "   Choix :",
            q.get("choix")
        )

    print("=" * 80)

    # ========================================================
    # 13. RÉPONSE AU FRONTEND
    # ========================================================

    return {
        "test_id": test_id,
        "matiere": matiere,
        "niveau": niveau,
        "serie": serie,
        "niveaux_evalues": niveaux_a_inclure,
        "questions": questions_posees,
    }

# ============================================================
# SOUMISSION ET ÉVALUATION D'UN TEST DIAGNOSTIQUE
# ============================================================

@app.post("/api/questions/{niveau}/resultats")
def evaluer_test_par_niveau(
    niveau: str,
    data: ReponsesModel,
    current_user: User = Depends(get_current_user)
):
    """
    Évalue exactement le test diagnostique qui a été généré
    pour l'apprenant.

    PRINCIPES :

    1. Le test est identifié par test_id.
    2. Les questions utilisées sont celles sauvegardées
       lors de la génération du test.
    3. Le backend ne refiltre PAS les questions.
    4. Chaque réponse peut être envoyée :
       - sous forme de lettre : a, b, c, d, e
       - sous forme de texte.
    5. La correction utilise prioritairement :
       - bonne_reponse_lettre
       - puis bonne_reponse texte.
    6. La note est calculée sur le nombre exact
       de questions présentées.
    """

    print("\n")
    print("=" * 100)
    print("📝 ÉVALUATION DU TEST DIAGNOSTIQUE")
    print("=" * 100)

    # ========================================================
    # 1. NORMALISATION DES INFORMATIONS REÇUES
    # ========================================================

    niveau = normalize_niveau(niveau)
    matiere = normalize_matiere(data.matiere)
    serie = normalize_serie(data.serie)

    print("📚 Matière reçue :", matiere)
    print("🎓 Niveau reçu   :", niveau)
    print("📖 Série reçue   :", serie)
    print("🆔 Test ID       :", data.test_id)
    print("👤 Utilisateur   :", current_user.id)

    # ========================================================
    # 2. CHARGEMENT DU TEST
    # ========================================================

    try:
        test = charger_test(data.test_id)

    except Exception as e:

        print(
            "❌ Erreur lors du chargement du test :",
            repr(e)
        )

        raise HTTPException(
            status_code=500,
            detail="Erreur lors du chargement du test."
        )

    if not test:

        print("❌ Test introuvable.")

        raise HTTPException(
            status_code=404,
            detail="Test introuvable ou expiré."
        )

    print("✅ Test chargé.")

    # ========================================================
    # 3. VÉRIFICATION DE PROPRIÉTÉ DU TEST
    # ========================================================

    test_user_id = test.get("user_id")

    if (
        test_user_id is not None
        and str(test_user_id) != str(current_user.id)
    ):

        print(
            "🚫 Le test appartient à un autre utilisateur."
        )

        raise HTTPException(
            status_code=403,
            detail=(
                "Ce test n'appartient pas "
                "à cet utilisateur."
            )
        )

    # ========================================================
    # 4. RÉCUPÉRATION DES QUESTIONS EXACTES
    # ========================================================

    questions_test = test.get("questions", [])

    if not isinstance(questions_test, list):
        raise HTTPException(
            status_code=400,
            detail="Les questions du test sont invalides."
        )

    if not questions_test:
        raise HTTPException(
            status_code=400,
            detail="Le test ne contient aucune question."
        )

    nombre_questions = len(questions_test)

    print(
        "📊 Nombre de questions du test :",
        nombre_questions
    )

    # ========================================================
    # 5. VÉRIFICATION DE LA MATIÈRE
    # ========================================================

    test_matiere = normalize_matiere(
        test.get("matiere")
    )

    if test_matiere and test_matiere != matiere:

        print(
            "⚠️ Matière différente."
        )

        print(
            "   Matière sauvegardée :",
            test_matiere
        )

        print(
            "   Matière reçue :",
            matiere
        )

        raise HTTPException(
            status_code=400,
            detail=(
                "La matière envoyée ne correspond "
                "pas à celle du test."
            )
        )

    # ========================================================
    # 6. VÉRIFICATION DU NIVEAU
    # ========================================================

    test_niveau = normalize_niveau(
        test.get("niveau")
    )

    if test_niveau and test_niveau != niveau:

        print(
            "⚠️ Niveau différent."
        )

        print(
            "   Niveau sauvegardé :",
            test_niveau
        )

        print(
            "   Niveau reçu :",
            niveau
        )

        raise HTTPException(
            status_code=400,
            detail=(
                "Le niveau envoyé ne correspond "
                "pas à celui du test."
            )
        )

    # ========================================================
    # 7. CONSTRUCTION DES RÉPONSES DE L'APPRENANT
    # ========================================================

    reponses_apprenant = {}

    print("\n")
    print("📥 RÉPONSES REÇUES DU FRONTEND")
    print("-" * 100)

    for r in data.resultats:

        q_id = str(r.id).strip()

        reponse = (
            ""
            if r.reponse is None
            else str(r.reponse).strip()
        )

        # ----------------------------------------------------
        # Détection d'un doublon
        # ----------------------------------------------------

        if q_id in reponses_apprenant:

            print(
                f"⚠️ Doublon détecté pour la question {q_id}."
            )

        reponses_apprenant[q_id] = reponse

        print(
            f"   Question {q_id} -> {reponse!r}"
        )

    print("-" * 100)

    nombre_reponses_recues = len(
        reponses_apprenant
    )

    print(
        "📥 Nombre de réponses reçues :",
        nombre_reponses_recues
    )

    # ========================================================
    # 8. INDEX DES QUESTIONS
    # ========================================================

    questions_par_id = {}

    for q in questions_test:

        q_id = str(
            q.get("id")
        ).strip()

        if not q_id:
            print(
                "🚨 Question sans ID détectée :",
                q
            )
            continue

        if q_id in questions_par_id:

            print(
                "🚨 DOUBLON D'ID DANS LE TEST :",
                q_id
            )

            raise HTTPException(
                status_code=500,
                detail=(
                    f"L'identifiant de question "
                    f"{q_id} est présent plusieurs fois "
                    f"dans le test."
                )
            )

        questions_par_id[q_id] = q

    # ========================================================
    # 9. FONCTION DE NORMALISATION DES RÉPONSES
    # ========================================================

    def normaliser_reponse(
        valeur: Optional[str]
    ) -> str:

        if valeur is None:
            return ""

        return normalize_text(
            str(valeur)
        )

    # ========================================================
    # 10. FONCTION DE CORRECTION
    # ========================================================

    def reponse_est_correcte(
        reponse_apprenant: Optional[str],
        bonne_reponse_lettre: Optional[str],
        bonne_reponse_texte: Optional[str],
        choix: Optional[List[str]]
    ) -> tuple[bool, str]:

        """
        Retourne :

            (True, "lettre")
            (True, "texte")
            (False, "aucune")
        """

        if (
            reponse_apprenant is None
            or not str(reponse_apprenant).strip()
        ):
            return False, "aucune"

        reponse = normaliser_reponse(
            reponse_apprenant
        )

        # ----------------------------------------------------
        # A. Comparaison par lettre
        # ----------------------------------------------------

        if bonne_reponse_lettre:

            lettre_correcte = normaliser_reponse(
                bonne_reponse_lettre
            )

            if reponse == lettre_correcte:

                return True, "lettre"

        # ----------------------------------------------------
        # B. Comparaison par texte
        # ----------------------------------------------------

        if bonne_reponse_texte:

            texte_correct = normaliser_reponse(
                bonne_reponse_texte
            )

            if reponse == texte_correct:

                return True, "texte"

        # ----------------------------------------------------
        # C. Sécurité supplémentaire :
        #
        # Si le frontend envoie le texte d'une proposition,
        # on recherche cette proposition dans les choix.
        # ----------------------------------------------------

        if isinstance(choix, list):

            for choix_item in choix:

                if choix_item is None:
                    continue

                choix_normalise = normaliser_reponse(
                    choix_item
                )

                if (
                    reponse == choix_normalise
                    and bonne_reponse_texte
                    and choix_normalise
                    == normaliser_reponse(
                        bonne_reponse_texte
                    )
                ):

                    return True, "texte_choix"

        return False, "aucune"

    # ========================================================
    # 11. ÉVALUATION QUESTION PAR QUESTION
    # ========================================================

    nombre_correctes = 0

    notions_non_acquises = []

    questions_remediation = []

    print("\n")
    print("=" * 100)
    print("🔎 CORRECTION QUESTION PAR QUESTION")
    print("=" * 100)

    for index, q in enumerate(
        questions_test,
        start=1
    ):

        q_id = str(
            q.get("id")
        ).strip()

        question_text = q.get(
            "question",
            ""
        )

        choix = q.get(
            "choix",
            []
        )

        bonne_reponse_texte = q.get(
            "bonne_reponse"
        )

        bonne_reponse_lettre = q.get(
            "bonne_reponse_lettre"
        )

        reponse_apprenant = (
            reponses_apprenant.get(q_id)
        )

        # ----------------------------------------------------
        # DEBUG
        # ----------------------------------------------------

        print("\n")
        print("-" * 100)

        print(
            f"QUESTION {index}/{nombre_questions}"
        )

        print(
            "🆔 ID :",
            q_id
        )

        print(
            "❓ Question :",
            question_text
        )

        print(
            "📥 Réponse apprenant :",
            repr(reponse_apprenant)
        )

        print(
            "✅ Bonne réponse texte :",
            repr(bonne_reponse_texte)
        )

        print(
            "🔤 Bonne réponse lettre :",
            repr(bonne_reponse_lettre)
        )

        print(
            "🔀 Choix :",
            choix
        )

        # ----------------------------------------------------
        # CONTRÔLE DE LA BONNE RÉPONSE
        # ----------------------------------------------------

        if (
            not bonne_reponse_texte
            and not bonne_reponse_lettre
        ):

            print(
                "🚨 AUCUNE BONNE RÉPONSE ENREGISTRÉE"
            )

            correcte = False
            methode_correction = "erreur_donnees"

        else:

            (
                correcte,
                methode_correction
            ) = reponse_est_correcte(
                reponse_apprenant,
                bonne_reponse_lettre,
                bonne_reponse_texte,
                choix
            )

        # ----------------------------------------------------
        # QUESTION CORRECTE
        # ----------------------------------------------------

        if correcte:

            nombre_correctes += 1

            print(
                "✅ CORRECT"
            )

            print(
                "🔎 Méthode :",
                methode_correction
            )

        # ----------------------------------------------------
        # QUESTION INCORRECTE
        # ----------------------------------------------------

        else:

            print(
                "❌ INCORRECT"
            )

            if reponse_apprenant is None:
                print(
                    "⚠️ Aucune réponse reçue "
                    "pour cette question."
                )

            notion = q.get(
                "notion",
                "Notion non précisée"
            )

            if notion not in notions_non_acquises:

                notions_non_acquises.append(
                    notion
                )

            questions_remediation.append(
                {
                    "id": q_id,

                    "question": q.get(
                        "question",
                        ""
                    ),

                    "classe": q.get(
                        "niveau"
                    ),

                    "choix": q.get(
                        "choix",
                        []
                    ),

                    "correcte": False,

                    "bonne_reponse":
                        bonne_reponse_texte,

                    "reponse_apprenant":
                        reponse_apprenant,

                    "notion":
                        notion,

                    "situation":
                        q.get(
                            "situation"
                        ),

                    "enseignant":
                        q.get(
                            "enseignant"
                        ),

                    "matiere":
                        q.get(
                            "matiere"
                        ),

                    "serie":
                        q.get(
                            "serie"
                        ),
                }
            )

    # ========================================================
    # 12. CALCUL DE LA NOTE
    # ========================================================

    if nombre_questions > 0:

        note_exacte = (
            nombre_correctes
            / nombre_questions
        ) * 20

        note = round(
            note_exacte
        )

    else:

        note_exacte = 0.0
        note = 0

    mention = get_mention(
        note
    )

    nombre_erreurs = (
        nombre_questions
        - nombre_correctes
    )

    # ========================================================
    # 13. CONTRÔLES DE COHÉRENCE
    # ========================================================

    print("\n")
    print("=" * 100)
    print("📊 RÉSULTAT FINAL")
    print("=" * 100)

    print(
        "📝 Questions :",
        nombre_questions
    )

    print(
        "📥 Réponses reçues :",
        nombre_reponses_recues
    )

    print(
        "✅ Bonnes réponses :",
        nombre_correctes
    )

    print(
        "❌ Mauvaises réponses :",
        nombre_erreurs
    )

    print(
        "📐 Note exacte :",
        round(note_exacte, 4),
        "/20"
    )

    print(
        "🎯 Note finale :",
        note,
        "/20"
    )

    print(
        "🏆 Mention :",
        mention
    )

    print(
        "📚 Notions non acquises :",
        notions_non_acquises
    )

    print(
        "🎥 Questions de remédiation :",
        len(questions_remediation)
    )

    # --------------------------------------------------------
    # Vérification mathématique
    # --------------------------------------------------------

    if (
        nombre_correctes
        + nombre_erreurs
        != nombre_questions
    ):

        print(
            "🚨 ERREUR DE COHÉRENCE DU CALCUL"
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Erreur interne dans le calcul "
                "du résultat."
            )
        )

    print(
        "✅ Vérification mathématique :",
        nombre_correctes,
        "+",
        nombre_erreurs,
        "=",
        nombre_questions
    )

    # --------------------------------------------------------
    # Vérification des questions sans réponse
    # --------------------------------------------------------

    questions_sans_reponse = []

    for q in questions_test:

        q_id = str(
            q.get("id")
        ).strip()

        if q_id not in reponses_apprenant:

            questions_sans_reponse.append(
                q_id
            )

    if questions_sans_reponse:

        print(
            "⚠️ Questions sans réponse :",
            questions_sans_reponse
        )

    # ========================================================
    # 14. CONSTRUCTION DU RÉSULTAT
    # ========================================================

    resultat = {

        "user_id":
            current_user.id,

        "test_id":
            data.test_id,

        "matiere":
            matiere,

        "niveau":
            niveau,

        "serie":
            serie,

        "note":
            note,

        "note_exacte":
            round(
                note_exacte,
                4
            ),

        "mention":
            mention,

        "nombre_questions":
            nombre_questions,

        "nombre_correctes":
            nombre_correctes,

        "nombre_erreurs":
            nombre_erreurs,

        "nombre_reponses_recues":
            nombre_reponses_recues,

        "questions_sans_reponse":
            questions_sans_reponse,

        "notionsNonAcquises":
            notions_non_acquises,

        "questionsRemediation":
            questions_remediation,

        "date":
            datetime.now().isoformat(),
    }

    # ========================================================
    # 15. SAUVEGARDE
    # ========================================================

    try:

        sauvegarder_resultat(
            resultat
        )

        print(
            "💾 Résultat sauvegardé avec succès."
        )

    except Exception as e:

        print(
            "🚨 Erreur lors de la sauvegarde :",
            repr(e)
        )

        raise HTTPException(
            status_code=500,
            detail=(
                "Le test a été corrigé mais "
                "le résultat n'a pas pu être sauvegardé."
            )
        )

    # ========================================================
    # 16. RÉPONSE AU FRONTEND
    # ========================================================

    print("=" * 100)
    print("✅ ÉVALUATION TERMINÉE")
    print("=" * 100)

    return {

        "matiere":
            matiere,

        "niveau":
            niveau,

        "serie":
            serie,

        "note":
            note,

        "note_exacte":
            round(
                note_exacte,
                4
            ),

        "mention":
            mention,

        "notionsNonAcquises":
            notions_non_acquises,

        "questionsRemediation":
            questions_remediation,

        "nombre_questions":
            nombre_questions,

        "nombre_correctes":
            nombre_correctes,

        "nombre_erreurs":
            nombre_erreurs,

        "nombre_reponses_recues":
            nombre_reponses_recues,

        "questions_sans_reponse":
            questions_sans_reponse,

        "test_id":
            data.test_id,
    }

@app.get(
    "/api/resultats/dernier",
    response_model=ResultatTest
)
def get_last_result(
    niveau: str,
    matiere: Optional[str] = Query(None),
    serie: Optional[str] = Query(None),
    current_user: User = Depends(get_current_user)
):
    if not os.path.exists(RESULTATS_FILE):
        raise HTTPException(
            status_code=404,
            detail="Aucun résultat trouvé."
        )

    with open(
        RESULTATS_FILE,
        "r",
        encoding="utf-8"
    ) as f:
        historiques = json.load(f)

    niveau = normalize_niveau(niveau)

    matiere = (
        normalize_matiere(matiere)
        if matiere
        else None
    )

    serie = normalize_serie(serie)

    user_id = current_user.id

    # ========================================================
    # FILTRAGE
    # ========================================================

    filtres = []

    for r in historiques:

        # Utilisateur
        if r.get("user_id") != user_id:
            continue

        # Niveau
        if normalize_niveau(
            r.get("niveau")
        ) != niveau:
            continue

        # Matière
        if matiere is not None:

            if normalize_matiere(
                r.get("matiere")
            ) != matiere:
                continue

        # Série
        if normalize_serie(
            r.get("serie")
        ) != serie:
            continue

        filtres.append(r)

    # ========================================================
    # AUCUN RÉSULTAT
    # ========================================================

    if not filtres:
        raise HTTPException(
            status_code=404,
            detail=(
                "Aucun résultat trouvé pour "
                f"la matière '{matiere}', "
                f"le niveau '{niveau}' "
                f"et la série '{serie}'."
            )
        )

    # ========================================================
    # PLUS RÉCENT
    # ========================================================

    filtres.sort(
        key=lambda r: datetime.fromisoformat(
            r["date"]
        ),
        reverse=True
    )

    dernier = filtres[0]

    return ResultatTest(
        matiere=dernier.get("matiere"),

        niveau=dernier.get("niveau"),

        serie=dernier.get("serie"),

        note=dernier["note"],

        mention=dernier["mention"],

        notionsNonAcquises=
            dernier.get(
                "notionsNonAcquises",
                []
            ),

        questionsRemediation=
            dernier.get(
                "questionsRemediation",
                []
            ),
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
        "enseignant": v.get("enseignant"),
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