from fastapi import APIRouter, Query, HTTPException
from typing import Optional
import os
import json
from slugify import slugify  # pip install python-slugify si nécessaire

# URL de base du backend
BACKEND_URL = os.environ.get("BACKEND_URL", "http://localhost:8000")

router = APIRouter(prefix="/api/v1/promotions", tags=["Promotions"])

# Chemins vers le dossier d'images
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PROMO_FOLDER = os.path.join(BASE_DIR, "../Images/promotions")

# Charger le JSON des promotions si existant
promotions_json_path = os.path.join(BASE_DIR, "../promotions.json")
if os.path.exists(promotions_json_path):
    with open(promotions_json_path, "r", encoding="utf-8") as f:
        existing_promotions = json.load(f)
else:
    existing_promotions = []

# Créer un dictionnaire de lookup par nom pour prix et description
promo_lookup = {
    p["name"]: {
        "price": p.get("price", 0),
        "promoPrice": p.get("promoPrice", 0),
        "short_description": p.get("short_description", f"Description courte pour {p['name']}."),
        "category": p.get("category", "promotions")
    }
    for p in existing_promotions
}

PROMOTIONS = []
current_id = 1

# Génération automatique des promotions à partir des images
if os.path.exists(PROMO_FOLDER):
    for filename in sorted(os.listdir(PROMO_FOLDER)):
        if filename.lower().endswith((".jpg", ".jpeg", ".png")):
            promo_name = f"Promotion {current_id}"
            data = promo_lookup.get(promo_name, {
                "price": 0,
                "promoPrice": 0,
                "short_description": f"Description courte pour {promo_name}.",
                "category": "promotions"
            })
            slug = slugify(promo_name)
            PROMOTIONS.append({
                "id": current_id,
                "name": promo_name,
                "slug": slug,
                "price": data["price"],
                "promoPrice": data["promoPrice"],
                "category": data["category"],
                "image_url": f"{BACKEND_URL}/images/promotions/{filename}",
                "featured": True,
                "short_description": data["short_description"]
            })
            current_id += 1

# 🔹 Liste des promotions
@router.get("/")
def get_promotions(
    featured: Optional[bool] = Query(None),
    limit: Optional[int] = Query(None)
):
    filtered = PROMOTIONS
    if featured is not None:
        filtered = [p for p in filtered if p["featured"] == featured]
    if limit:
        filtered = filtered[:limit]
    return {"promotions": filtered}

# 🔹 Récupérer une promotion par ID
@router.get("/{id}")
def get_promotion_by_id(id: int):
    promo = next((p for p in PROMOTIONS if p["id"] == id), None)
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion introuvable")
    return promo

# 🔹 Récupérer une promotion par slug
@router.get("/slug/{slug}")
def get_promotion_by_slug(slug: str):
    promo = next((p for p in PROMOTIONS if p["slug"] == slug), None)
    if not promo:
        raise HTTPException(status_code=404, detail="Promotion introuvable")
    return promo
