import os
import re
import json
from slugify import slugify  # pip install python-slugify

BACKEND_URL = os.environ.get("BACKEND_URL")

# --- CONFIG ---
categories = {
    "vins": "Images/vins",
    "alimentaire": "Images/alimentaire",
    "entretien": "Images/entretien"
}

# --- SCRIPT ---
def generate_products_json():
    # Charger le JSON existant pour récupérer les prix
    existing_products = []
    if os.path.exists("products.json"):
        with open("products.json", "r", encoding="utf-8") as f:
            existing_products = json.load(f)

    price_lookup = {p["name"]: {"price": p["price"], "promoPrice": p.get("promoPrice", 0)} for p in existing_products}

    all_products = []
    global_id = 1

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
                # Renommage
                if not pattern.match(filename):
                    ext = filename.split(".")[-1].lower()
                    new_name = f"{prefix}{counter}.{ext}"
                    new_path = os.path.join(folder, new_name)
                    os.rename(old_path, new_path)
                    print(f"{filename} -> {new_name}")
                    filename = new_name
                counter += 1

                # Création produit JSON
                product_name = f"{prefix.capitalize()} {counter-1}"
                product_slug = slugify(product_name)
                image_url = f"/Images/{prefix}/{filename}"  # chemin relatif frontend
                short_description = f"Description courte pour {product_name}."
                prices = price_lookup.get(product_name, {"price": 0, "promoPrice": 0})
                price = prices["price"]
                promo_price = prices["promoPrice"]

                all_products.append({
                    "id": global_id,
                    "name": product_name,
                    "slug": product_slug,
                    "price": price,
                    "promoPrice": promo_price,
                    "image_url": image_url,
                    "short_description": short_description,
                    "category": prefix
                })
                global_id += 1

    # Écriture JSON
    with open("products.json", "w", encoding="utf-8") as f:
        json.dump(all_products, f, ensure_ascii=False, indent=2)

    print("✅ JSON mis à jour : products.json")
    return all_products

if __name__ == "__main__":
    generate_products_json()
