import os
import re

# --- CONFIG ---
categories = {
    "vins": "Images/vins",
    "alimentaire": "Images/alimentaire",
    "entretien": "Images/entretien"
}

# --- SCRIPT ---
for prefix, folder in categories.items():
    print(f"📁 Traitement de la catégorie '{prefix}' dans {folder}")
    if not os.path.exists(folder):
        print(f"⚠️ Le dossier {folder} n'existe pas, skipping...")
        continue

    files = sorted(os.listdir(folder))
    counter = 1
    pattern = re.compile(rf"^{prefix}\d+\.(jpg|jpeg|png)$", re.IGNORECASE)

    for filename in files:
        old_path = os.path.join(folder, filename)
        if os.path.isfile(old_path) and filename.lower().endswith((".jpg", ".jpeg", ".png")):
            if pattern.match(filename):
                continue
            ext = filename.split(".")[-1].lower()
            new_name = f"{prefix}{counter}.{ext}"
            new_path = os.path.join(folder, new_name)
            os.rename(old_path, new_path)
            print(f"{filename} -> {new_name}")
            counter += 1

    print(f"✅ Renommage terminé pour '{prefix}'\n")
