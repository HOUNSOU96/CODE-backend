import json
from collections import Counter

# Fichier JSON
FICHIER = "questions.json"  # adapte le chemin si besoin (ex: backend/data/questions.json)

# Niveaux attendus
NIVEAUX_VALIDES = {"6e", "5e", "4e", "3e", "2nde", "1ere", "tle"}

def main():
    try:
        with open(FICHIER, "r", encoding="utf-8") as f:
            data = json.load(f)
    except Exception as e:
        print(f"❌ Erreur de lecture du fichier {FICHIER}: {e}")
        return

    ids = []
    niveaux = []
    erreurs = []

    for q in data:
        qid = q.get("id")
        niveau = str(q.get("niveau", "")).lower().strip()

        # Collecte des infos
        ids.append(qid)
        niveaux.append(niveau)

        # Vérifie le type de l'ID
        if isinstance(qid, str):
            erreurs.append(f"⚠️ ID '{qid}' est une chaîne (devrait être un int ?)")

        # Vérifie niveau
        if niveau not in NIVEAUX_VALIDES:
            erreurs.append(f"⚠️ Niveau '{q.get('niveau')}' invalide pour ID={qid}")

    # Doublons d'ID
    doublons = [item for item, count in Counter(ids).items() if count > 1]

    print("===== ANALYSE QUESTIONS.JSON =====")
    print(f"✅ Nombre total de questions : {len(data)}")
    print(f"✅ Niveaux trouvés : {set(niveaux)}")

    if doublons:
        print(f"❌ Doublons détectés : {doublons}")
    else:
        print("✅ Aucun doublon d'ID")

    if erreurs:
        print("\n=== Erreurs détectées ===")
        for e in erreurs:
            print(e)
    else:
        print("✅ Aucune incohérence trouvée")

if __name__ == "__main__":
    main()
