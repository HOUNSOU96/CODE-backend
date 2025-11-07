import os
import re
import json
from slugify import slugify  # pip install python-slugify

BACKEND_URL = os.environ.get("BACKEND_URL", "http://localhost:8000")

# --- CONFIG ---
promo_folder = "Images/promotions"

# --- SCRIPT ---
def generate_promotions_json():
    # Charger le JSON existant pour récupérer les prix ou descriptions
    existing_promotions = []
    if os.path.exists("promotions.json"):
        with open("promotions.json", "r", encoding="utf-8") as f:
            existing_promotions = json.load(f)

    lookup = {p["name"]: {"price": p.get("price", 0), "promoPrice": p.get("promoPrice", 0),
                          "short_description": p.get("short_description", f"Description courte pour {p['name']}.")}
              for p in existing_promotions}

    all_promotions = []
    global_id = 1

    if not os.path.exists(promo_folder):
        print(f"⚠️ Le dossier {promo_folder} n'existe pas, skipping...")
        return []

    files = sorted(os.listdir(promo_folder))
    counter = 1
    pattern = re.compile(r"^promo\d+\.(jpg|jpeg|png)$", re.IGNORECASE)

    for filename in files:
        old_path = os.path.join(promo_folder, filename)
        if os.path.isfile(old_path) and filename.lower().endswith((".jpg", ".jpeg", ".png")):
            # Renommage automatique
            if not pattern.match(filename):
                ext = filename.split(".")[-1].lower()
                new_name = f"promo{counter}.{ext}"
                new_path = os.path.join(promo_folder, new_name)
                os.rename(old_path, new_path)
                print(f"{filename} -> {new_name}")
                filename = new_name
            counter += 1

            # Création de l'objet promotion JSON
            promo_name = f"Promotion {counter-1}"
            promo_slug = slugify(promo_name)
            image_url = f"{BACKEND_URL}/images/promotions/{filename}"
            data = lookup.get(promo_name, {"price": 0, "promoPrice": 0, "short_description": f"Description courte pour {promo_name}."})

            all_promotions.append({
                "id": global_id,
                "name": promo_name,
                "slug": promo_slug,
                "price": data["price"],
                "promoPrice": data["promoPrice"],
                "image_url": image_url,
                "short_description": data["short_description"],
                "category": "promotions",
                "featured": True
            })
            global_id += 1

    # Écriture JSON
    with open("promotions.json", "w", encoding="utf-8") as f:
        json.dump(all_promotions, f, ensure_ascii=False, indent=2)

    print("✅ JSON mis à jour : promotions.json")
    return all_promotions


if __name__ == "__main__":
    generate_promotions_json()
