from fastapi import APIRouter, Query, HTTPException
from typing import Optional
import os
import json


BACKEND_URL = os.environ.get("BACKEND_URL")


router = APIRouter(prefix="/api/v1/products", tags=["Products"])

# Chemins vers les dossiers d'images
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
IMAGE_FOLDERS = {
    "Vins": os.path.join(BASE_DIR, "../Images/vins"),
    "Alimentaire": os.path.join(BASE_DIR, "../Images/alimentaire"),
    "Entretien": os.path.join(BASE_DIR, "../Images/entretien"),
}

# Charger les prix depuis un JSON existant (products.json)
products_json_path = os.path.join(BASE_DIR, "../products.json")
if os.path.exists(products_json_path):
    with open(products_json_path, "r", encoding="utf-8") as f:
        existing_products = json.load(f)
else:
    existing_products = []

# Créer un dictionnaire de lookup pour retrouver prix ET description par nom
product_lookup = {
    p["name"]: {
        "price": p.get("price", 0),
        "promoPrice": p.get("promoPrice", 0),
        "short_description": p.get("short_description", f"Description courte pour {p['name']}.")
    }
    for p in existing_products
}

PRODUCTS = []
current_id = 1

for category, folder in IMAGE_FOLDERS.items():
    if os.path.exists(folder):
        for filename in sorted(os.listdir(folder)):
            if filename.lower().endswith((".jpg", ".jpeg", ".png")):
                slug = filename.rsplit(".", 1)[0].lower().replace(" ", "-")
                product_name = f"{category} {current_id}"
                data = product_lookup.get(product_name, {
                    "price": 5.0,
                    "promoPrice": 0,
                    "short_description": f"Description courte pour {product_name}."
                })
                PRODUCTS.append({
                    "id": current_id,
                    "name": product_name,
                    "slug": slug,
                    "category": category.lower(),
                    "price": data["price"],
                    "promoPrice": data.get("promoPrice", 0),
                    "image_url": f"/images/{category.lower()}/{filename}",
                    "featured": True,
                    "short_description": data["short_description"]
                })
                current_id += 1


# 🔹 Liste des produits
@router.get("/")
def get_products(
    featured: Optional[bool] = Query(None),
    limit: Optional[int] = Query(None),
    category: Optional[str] = Query(None)
):
    filtered = PRODUCTS
    if featured is not None:
        filtered = [p for p in filtered if p["featured"] == featured]
    if category:
        filtered = [p for p in filtered if p["category"].lower() == category.lower()]
    if limit:
        filtered = filtered[:limit]
    return {"products": filtered}

# 🔹 Récupérer un produit par ID
@router.get("/{id}")
def get_product_by_id(id: int):
    product = next((p for p in PRODUCTS if p["id"] == id), None)
    if not product:
        raise HTTPException(status_code=404, detail="Produit introuvable")
    return product

# 🔹 Récupérer un produit par slug
@router.get("/slug/{slug}")
def get_product_by_slug(slug: str):
    product = next((p for p in PRODUCTS if p["slug"] == slug), None)
    if not product:
        raise HTTPException(status_code=404, detail="Produit introuvable")
    return product
