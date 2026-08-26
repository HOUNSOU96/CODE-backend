from typing import List, Dict
import unicodedata
import json
from pathlib import Path

# Ordre logique des notions pour tri cohérent
NOTIONS_ORDRE = [
    "Cube(6e)","Pavé-droit(6e)", "Cône de révolution(6e)", "Sphère(6e)", "Repérage(6e)", "Droites du plan(6e)","Segments de droites(6e)", "Cercles(6e)", "Angles(6e)","Triangles(6e)","Parallélogrammes(6e)","Entiers naturels(6e)","Nombres décimaux arithmétiques(6e)","Fractions(6e)","Calcul littéral(6e)", "Figures symétriques par rapport à une droite(6e)","Figures symétriques par rapport à un point(6e)","Glissement(6e)","Proportionnalité(6e)","Statistique(6e)", "Prisme droit(5e)", "Division dans IN(5e)","Distance(5e)", "Angles(5e)","Triangles(5e)","Cercles(5e)", "Parallélogrammes(5e)","Polygones particuliers(5e)","Nombres décimaux relatifs(5e)", "Fractions(5e)","Puissances(5e)","Figures symétriques par rapport à une droite(5e)","Figures symétriques par rapport à un point(5e)","Glissement(5e)","Equations(5e)","Proportionnalité(5e)", "Angles au centre d'un cercle(4e)","Distances(4e)","Triangles(4e)","Polygones réguliers(4e)","Nombres décimaux(4e)","Nombres rationnels(4e)","Puissances(4e)","Calculs sur les expressions algébriques(4e)","Pyramides(4e)","Cône(4e)","Perspective cavalière(4e)","Sphère-Boule(4e)","Notions de plans et droites de l'espace(4e)","Arithmétiques: PPCM-PGCD(4e)","Symétrie centrale(4e)","Symétrie orthogonale(4e)", "Translation(4e)","Projection(4e)", "Equations-Inéquations(4e)","Proportionnalité(4e)","Statistique(4e)", "Nombres réels(3e)","Valeur absolue(3e)","Trigonométrie(3e)","Propriétés de Thalès et sa réciproque(3e)","Triangles semblables(3e)","Triangle rectangle(3e)","Angles et cercles(3e)","Cône de révolution(3e)","Sections planes(3e)","Polynômes(3e)","Equations de droites(3e)","Equations et Inéquations(3e)","Opération sur les vecteurs: Somme et produit(3e)","Calcul sur les coordonnées de vecteurs(3e)","Application affine(3e)","Application linéaire(3e)","Statistique(3e)", "Fonction numérique d’une variable réelle:Généralités(2ndeA&B)","Notion de suite numérique(2ndeA&B)","Dénombrement(2ndeA&B)","Calcul dans IR(2ndeA&B)","Equation du premier degré dans IR(2ndeA&B)","Inéquations du premier degré dans IR(2ndeA&B)","Equation linéaire dans IRxIR(2ndeA&B)","Système d’équations linéaires dans IRxIR(2ndeA&B)","Etude et représentation graphique de fonctions(2ndeA&B)", "Représentation dans le plan d’objets de l’espace(2ndeC&D)","Positions relatives de deux droites de l’espace(2ndeC&D)","Positions relatives d’une droite et d’un plan de l’espace(2ndeC&D)","Positions relatives de deux plans de l’espace(2ndeC&D)","Etude du parallélisme de deux droites(2ndeC&D)","Calcul dans IR(2ndeC&D)","Polynômes et fractions rationnelles(2ndeC&D)","Généralités sur les fonctions(2ndeC&D)","Equations et Inéquations dans IR(2ndeC&D)","Etude de quelques fonctions(2ndeC&D)","Applications(2ndeC&D)","Statistique(2ndeC&D)","Vecteurs du plan(2ndeC&D)","Angles orientés-Trigonométrie(2ndeC&D)","Droites du plan(2ndeC&D)","Produit scalaire dans le plan(2ndeC&D)","Homothétie(2ndeC&D)","Rotation(2ndeC&D)","Symétrie orthogonale-symétrie centrale-translation(2ndeC&D)","Cercle dans le plan(2ndeC&D)","Angles inscrits ; relations métriques dans un triangle(2ndeC&D)","Angles inscrits et lieux géométriques(2ndeC&D)","Equations - Inéquations dans IRxIR(2ndeC&D)", "Calcul dans IR(2ndeF1&F2&F3&F4)","Fonctions polynômes(2ndeF1&F2&F3&F4)","Fonctions rationnelles(2ndeF1&F2&F3&F4)","Equations-Inéquations(2ndeF1&F2&F3&F4)","Fonction numérique d'une variable réelle(2ndeF1&F2&F3&F4)","Angles et introduction à la trigonométrie(2ndeF1&F2&F3&F4)","Géométrie plane(2ndeF1&F2&F3&F4)","Applications planes(2ndeF1&F2&F3&F4)","Géométrie dans l'espace(2ndeF1)","Statistique(2ndeF1&F2&F3&F4)", "Equations et Inéquations du second degré dans IR(1ereA&B)","Système d'Equations et d'Inéquations linéaires dans IRxIR(1ereA&B)","Suites arithmétiques(1ereA&B)","Suites géométriques(1ereA&B)","Statistique(1ereA&B)","Dénombrements(1ereA&B)","Fonctions-Applications(1ereA&B)","Notion de limite(1ereA&B)","Continuité(1ereA&B)","Dérivation(1ereA&B)","", "Droites orthogonales(1ereC&D)","Droite et plan orthogonaux(1ereC&D)","Plans perpendiculaires(1ereC&D)","Projection orthogonale sur un plan(1ereC&D)","Projection orthogonale sur une droite(1ereC&D)","Vecteurs de l’espace(1ereC&D)","Equations et inéquations dans (1ereC&D)","Statistique(1ereC&D)","Dénombrement(1ereC&D)","Fonctions(1ereC&D)","Limites et continuité(1ereC&D)","Dérivation–Etude de fonction(1ereC&D)","Primitives(1ereC&D)","Suites numériques(1ereC&D)","Angles orientés–trigonométrie(1ereC&D)","Barycentre de deux(1ereC&D), trois ou quatre points pondérés(1ereC&D)","Cercle dans le plan(1ereC&D)","Isométrie(1ereC&D)","Représentations graphiques de fonctions et transformations du plan(1ereC&D)", "Trigonométrie(1ereF1&F2&F3&F4)","Calcul matriciel-Résolution des systèmes d'équations linéaires à 2 et à 3 inconnues(1ereF1&F2&F3&F4)","Nombres complexes(1ereF1&F2&F3&F4)","Etude de fonctions(1ereF1&F2&F3&F4)","Suites numériques(1ereF1&F2&F3&F4)","Barycentres(1ereF1&F2&F3&F4)","Statistique(1ereF1&F2&F3&F4)","Géométrie dans l'espace(1ereF1)", "Calcul vectoriel(TleC)","Produit vectoriel(TleC)","Systèmes linéaires(TleC)","Applications affines de l’espace(TleC)","Arithmétique(TleC)","Nombres complexes(TleC)","Limites et Continuité(TleC)","Dérivabilité && Étude de fonctions(TleC)","Primitives de fonctions continues(TleC)","Fonctions logarithmes(TleC)","Fonctions exponentielles","Limites et Continuité(TleC)","Dérivabilité && Étude de fonctions","Primitives de fonctions continues(TleC)","Fonctions logarithmes(TleC)","Fonctions exponentielles(TleC)","Calcul intégral(TleC)","Equations différentielles(TleC)","Suites numériques(TleC)","Calculs des probabilités(TleC)","Isométries(TleC)","Applications affines du plan(TleC)","Similitudes planes(TleC)","Etude des coniques(TleC)", "Vecteurs de l’espace(TleD)","Barycentre de n points pondérés (n ∈ IN; n ≥ 2)(TleD)","Produit scalaire(TleD)","Equation cartésienne d’un plan-Représentations paramétriques d’un plan(TleD)","Système d’équations linéaires(TleD)","Système d’équations cartésiennes d’une droite de l’espace-Représentations paramétriques d’une droite de l’espace(TleD)","Produit vectoriel(TleD)","Nombres complexes(TleD)","Limites et continuité(TleD)","Dérivation -Étude de fonctions(TleD)","Fonction logarithme népérien(TleD)","Fonction exponentielle népérienne(TleD)","Primitives(TleD)","Fonctions exponentielles-Fonctions puissances(TleD)","Calcul intégral(TleD)","Equations différentielles linéaires à coefficients constants(TleD)","Probabilité(TleD)","Suites numériques(TleD)","Statistique(TleD)","Applications des nombres complexes aux transformations du plan(TleD)", "Nombres complexes(TleF1&F2&F3&F4)","Révision des éléments de géométrie vectorielle de la classe de première(TleF1&F2&F3&F4)","Coniques(TleF1&F2&F3&F4)","Suites numériques(TleF1&F2&F3&F4)","Notion de primitive(TleF1&F2&F3&F4)","Etude des fonctions usuelles(TleF1&F2&F3&F4)","Calcul intégral(TleF1&F2&F3&F4)","Equations différentielles(TleF1&F2&F3&F4)","Statistique(TleF1&F2&F3&F4)","Notions sur les courbes paramétrés du plan(TleF1)","Vecteur dérivé.Interprétation cinématique(Vecteur vitesse)(TleF1)","Tangente(lorsque le vecteur dérivé est non nul)(TleF1)","Résolution d'équations différentielles du premier ordre à varibles séparables(TleF2&F3)","Résolution d'équations différentielles linéaires(TleF2&F3)","Existence et unicité de la solution vérifiant des conditions initiales données(admis)(TleF2&F3)","Géométrie descriptive: Epure du point, de la droite, du plan(TleF4)","Géométrie descriptive: Intersections de droites et de plans(TleF4)","Géométrie descriptive: Changement de plan frontal(TleF4)","Géométrie descriptive: Rabattement sur un plan horizontal-Relèvement d'un point ou d'une droite(TleF4)","Géométrie desciptive: Distance(TleF4)","Géométrie descriptive: Angle de deux droites(TleF4)","Géométrie descriptive: Projection du cercle(épure)(TleF4)","Géométrie descriptive: Epure d'un cylindre de révolution, d'un cône de révolution dont la base circulaire est dans le plan horizontal de projection(TleF4)",
]

LOG_FILE = Path("evaluation_logs.json")

def normalize_text(s: str) -> str:
    """Normalise un texte pour ignorer accents, majuscules et espaces."""
    return unicodedata.normalize("NFD", s).encode("ascii", "ignore").decode().replace(" ", "").lower()

def evaluer_reponses(questions: List[Dict], reponses: Dict[str, str]) -> tuple[int, str, List[str]]:
    bonnes_reponses = 0
    total_questions = 0
    notions_non_acquises = set()
    lettres = ["a", "b", "c", "d", "e"]

    log_entries = []

    for q in questions:
        q_id = str(q.get("id"))
        bonne_reponse = q.get("bonne_reponse")
        notion = q.get("notion")
        choix = q.get("choix", [])

        if not q_id or not bonne_reponse or not notion or not choix:
            log_entries.append({"question_id": q_id, "status": "ignored", "note": "mal formée"})
            continue

        total_questions += 1
        reponse_user = reponses.get(q_id)
        is_correct = False

        # Vérification de la réponse par lettre
        if reponse_user is not None and reponse_user.lower() in lettres:
            index = lettres.index(reponse_user.lower())
            if index < len(choix):
                reponse_textuelle = choix[index]
                if normalize_text(reponse_textuelle) == normalize_text(bonne_reponse):
                    is_correct = True
        # Vérification de la réponse textuelle directe
        elif reponse_user is not None:
            if normalize_text(reponse_user) == normalize_text(bonne_reponse):
                is_correct = True

        if is_correct:
            bonnes_reponses += 1
            log_entries.append({
                "question_id": q_id,
                "notion": notion,
                "status": "correct",
                "reponse_user": reponse_user,
                "bonne_reponse": bonne_reponse
            })
        else:
            notions_non_acquises.add(notion)
            log_entries.append({
                "question_id": q_id,
                "notion": notion,
                "status": "incorrect",
                "reponse_user": reponse_user,
                "bonne_reponse": bonne_reponse
            })

    note = round((bonnes_reponses / total_questions) * 20) if total_questions > 0 else 0

    # Attribution de la mention
    if note >= 18:
        mention = "Excellente"
    elif note >= 16:
        mention = "Très Bien"
    elif note >= 14:
        mention = "Bien"
    elif note >= 12:
        mention = "Assez Bien"
    elif note >= 10:
        mention = "Passable"
    else:
        mention = "Insuffisant"

    # Tri des notions non acquises selon l’ordre défini
    notions_triees = sorted(
        notions_non_acquises,
        key=lambda x: NOTIONS_ORDRE.index(x) if x in NOTIONS_ORDRE else 999
    )

    # Sauvegarde des logs de manière filtrable
    try:
        if LOG_FILE.exists():
            with LOG_FILE.open("r", encoding="utf-8") as f:
                existing_logs = json.load(f)
        else:
            existing_logs = []

        existing_logs.append({
            "resultat": {
                "note": note,
                "mention": mention,
                "notions_non_acquises": notions_triees
            },
            "details_questions": log_entries
        })

        with LOG_FILE.open("w", encoding="utf-8") as f:
            json.dump(existing_logs, f, ensure_ascii=False, indent=2)

    except Exception as e:
        print(f"⚠️ Erreur lors de l'écriture du log : {e}")

    return note, mention, notions_triees
