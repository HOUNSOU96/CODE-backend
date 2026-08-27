import json
from collections import defaultdict

# ⚡ Chemin vers ton fichier
file_path = "questions.json"

# Lire le fichier existant
with open(file_path, "r", encoding="utf-8") as f:
    data = json.load(f)

# Dictionnaire pour compter les occurrences d'ID
id_count = defaultdict(int)

# Parcourir toutes les questions et corriger les doublons
for question in data:
    qid = question.get("id")
    if id_count[qid] > 0:
        # Ajouter un suffixe pour rendre l'ID unique
        new_id = f"{qid}_{id_count[qid]}"
        question["id"] = new_id
    id_count[qid] += 1

# Réécrire le fichier avec les IDs corrigés
with open(file_path, "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)

print("✅ Les doublons d'ID ont été corrigés dans backend/data/questions.json")
