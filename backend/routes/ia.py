import os
import logging
from typing import Literal

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, Field
from dotenv import load_dotenv
from google import genai


# ============================================================
# CONFIGURATION
# ============================================================

load_dotenv()

logger = logging.getLogger(__name__)

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
GEMINI_MODEL = os.getenv("GEMINI_MODEL", "gemini-3.8-flash")

router = APIRouter(
    prefix="/api/ia",
    tags=["IA"]
)


# ============================================================
# MODÈLES DE DONNÉES
# ============================================================

class HistoriqueMessage(BaseModel):
    role: Literal["eleve", "ia"] = "eleve"
    contenu: str = ""


class ExplicationQuestionRequest(BaseModel):
    question: str
    choix: list[str] = Field(default_factory=list)

    reponse_apprenant: str = ""
    bonne_reponse: str = ""

    notion: str = ""
    niveau: str = ""

    mode: Literal[
        "comprendre",
        "corriger",
        "approfondir"
    ] = "corriger"

    etape: Literal[
        "accueil",
        "raisonnement",
        "diagnostic",
        "indice",
        "recherche",
        "verification",
        "approfondissement",
        "termine"
    ] = "accueil"

    tentative: int = 1
    niveau_aide: int = 0

    reponse_correcte: bool = False

    historique: list[HistoriqueMessage] = Field(
        default_factory=list
    )


class DiagnosticResponse(BaseModel):
    comprehension: Literal[
        "inconnue",
        "fragile",
        "partielle",
        "solide"
    ]

    erreur: str | None = None

    notions_maitrisees: list[str] = Field(
        default_factory=list
    )

    notions_fragiles: list[str] = Field(
        default_factory=list
    )


class ExplicationQuestionResponse(BaseModel):
    type: Literal[
        "question_socratique",
        "indice",
        "diagnostic",
        "verification",
        "approfondissement",
        "validation"
    ]

    message: str

    diagnostic: DiagnosticResponse

    niveau_aide: int

    prochaine_etape: Literal[
        "raisonnement",
        "diagnostic",
        "indice",
        "recherche",
        "verification",
        "approfondissement",
        "termine"
    ]

    doit_reveler_solution: bool

    attend_reponse_eleve: bool


# ============================================================
# INSTRUCTIONS PÉDAGOGIQUES DE CODE IA
# ============================================================

SYSTEM_PROMPT = """
Tu es CODE IA, le tuteur pédagogique intelligent de la plateforme
CODE — Cours, Organisation, Diagnostic, Exercices.

Ton rôle n'est PAS simplement de donner la bonne réponse.

Ton objectif est de comprendre le raisonnement de l'apprenant,
d'identifier précisément ses difficultés et de l'aider progressivement
à construire lui-même la bonne compréhension.

PRINCIPES PÉDAGOGIQUES :

1. MÉTHODE SOCRATIQUE
Pose des questions courtes qui permettent à l'apprenant de réfléchir.

2. NE PAS RÉVÉLER IMMÉDIATEMENT LA SOLUTION
Si l'apprenant se trompe, ne donne pas automatiquement la solution.
Commence par chercher :
- la règle utilisée ;
- la formule utilisée ;
- le raisonnement suivi ;
- l'étape où apparaît l'erreur.

3. UNE ERREUR NE SIGNIFIE PAS QUE TOUT EST INCOMPRIS
Une réponse incorrecte peut révéler qu'une seule étape est fragile.

4. UNE BONNE RÉPONSE NE PROUVE PAS À ELLE SEULE LA COMPRÉHENSION
Si l'apprenant répond correctement, demande parfois une justification
courte ou une explication de son raisonnement.

5. PROGRESSION DES AIDES

Niveau d'aide 0 :
question de réflexion.

Niveau d'aide 1 :
petit indice.

Niveau d'aide 2 :
indice plus précis.

Niveau d'aide 3 :
rappel ciblé de la règle ou propriété.

Niveau d'aide 4 :
explication guidée étape par étape.

Niveau d'aide 5 :
solution détaillée uniquement si cela devient pédagogiquement nécessaire.

6. ADAPTATION AU NIVEAU
Adapte ton vocabulaire et la profondeur de ton explication au niveau
scolaire indiqué.

7. MODE COMPRENDRE
Cherche d'abord à déterminer si l'apprenant comprend le concept.

8. MODE CORRIGER
Cherche l'origine de l'erreur et accompagne l'apprenant vers la correction.

9. MODE APPROFONDIR
Une fois la compréhension suffisamment solide, propose une réflexion,
une application ou une difficulté supérieure.

10. RÉPONSES COURTES ET INTERACTIVES
Ne produis pas un long cours à chaque message.
Une interaction doit généralement contenir une idée pédagogique claire
et, lorsque cela est approprié, une question à laquelle l'apprenant peut répondre.

11. DIAGNOSTIC
Mets à jour :
- la compréhension ;
- les notions maîtrisées ;
- les notions fragiles ;
- l'erreur principale.

12. RÉPONSE STRUCTURÉE
Tu dois respecter exactement le schéma JSON demandé.

IMPORTANT :
- Ne mets aucun Markdown autour du JSON.
- Ne mets aucun texte avant ou après le JSON.
- Le champ "message" doit être directement adressé à l'apprenant.
"""


# ============================================================
# CLIENT GEMINI
# ============================================================

def get_gemini_client():
    if not GEMINI_API_KEY:
        raise RuntimeError(
            "GEMINI_API_KEY n'est pas configurée dans le fichier .env"
        )

    return genai.Client(api_key=GEMINI_API_KEY)


# ============================================================
# CONSTRUCTION DU CONTEXTE
# ============================================================

def construire_prompt(data: ExplicationQuestionRequest) -> str:

    choix = "\n".join(
        f"- {choix}"
        for choix in data.choix
    ) if data.choix else "(Pas de choix proposés)"

    historique = "\n".join(
        f"{message.role.upper()}: {message.contenu}"
        for message in data.historique[-12:]
    )

    if not historique:
        historique = "(Aucun échange précédent)"

    return f"""
Voici la situation pédagogique actuelle.

QUESTION :
{data.question}

CHOIX POSSIBLES :
{choix}

RÉPONSE DE L'APPRENANT :
{data.reponse_apprenant}

BONNE RÉPONSE ATTENDUE :
{data.bonne_reponse}

NOTION :
{data.notion}

NIVEAU / CLASSE :
{data.niveau}

MODE PÉDAGOGIQUE :
{data.mode}

ÉTAPE ACTUELLE :
{data.etape}

NUMÉRO DE TENTATIVE :
{data.tentative}

NIVEAU D'AIDE ACTUEL :
{data.niveau_aide}

LA RÉPONSE EST MARQUÉE COMME CORRECTE :
{data.reponse_correcte}

HISTORIQUE RÉCENT :
{historique}

À partir de ces informations :

1. Analyse le raisonnement possible de l'apprenant.
2. Détermine ce qu'il semble maîtriser.
3. Détermine ce qui semble fragile.
4. Identifie l'erreur principale si elle existe.
5. Décide de la prochaine intervention pédagogique.
6. Ne révèle pas la solution si une question ou un indice suffit.
7. Augmente progressivement le niveau d'aide si nécessaire.

Retourne UNIQUEMENT le JSON correspondant au schéma demandé.
"""


# ============================================================
# ENDPOINT PRINCIPAL
# ============================================================

@router.post(
    "/explication-question",
    response_model=ExplicationQuestionResponse
)
def explication_question(
    data: ExplicationQuestionRequest
):

    try:

        client = get_gemini_client()

        prompt = construire_prompt(data)

        interaction = client.interactions.create(
            model=GEMINI_MODEL,
            system_instruction=SYSTEM_PROMPT,
            input=prompt,
            response_format={
                "type": "text",
                "mime_type": "application/json",
                "schema": ExplicationQuestionResponse.model_json_schema(),
            },
        )

        resultat = ExplicationQuestionResponse.model_validate_json(
            interaction.output_text
        )

        return resultat

    except Exception as e:

        logger.exception(
            "Erreur Gemini /explication-question"
        )

        raise HTTPException(
            status_code=500,
            detail="Une erreur est survenue lors de la génération de l'explication IA."
        )