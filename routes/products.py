from fastapi import APIRouter, Query, HTTPException
from typing import Optional, List
import os
import json

router = APIRouter(prefix="/api/v1/products", tags=["Products"])

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PRODUCTS_JSON_PATH = os.path.join(BASE_DIR, "../products.json")

if not os.path.exists(PRODUCTS_JSON_PATH):
    raise RuntimeError("Le fichier products.json est introuvable")

with open(PRODUCTS_JSON_PATH, "r", encoding="utf-8") as f:
    PRODUCTS: List[dict] = json.load(f)

# URL de base pour les images servies par FastAPI
IMAGES_BASE_URL = "/images"

def sanitize_product(product: dict) -> dict:
    """
    Produit retourné au frontend avec URL d'image correcte
    """
    image_path = product.get("image_url", "")
    # Remplacer le préfixe /Images par /images pour correspondre à StaticFiles
    if image_path:
        image_url = image_path.replace("/Images", IMAGES_BASE_URL)
    else:
        image_url = None

    return {
        "id": product.get("id"),
        "name": product.get("name"),
        "slug": product.get("slug"),
        "price": product.get("price"),
        # "promoPrice": product.get("promoPrice"), # désactivé pour l'instant
        "image_url": image_url,
        "short_description": product.get("short_description"),
        "category": product.get("category"),
    }

@router.get("/")
def get_products(
    category: Optional[str] = Query(None),
    limit: Optional[int] = Query(None)
):
    results = PRODUCTS

    if category:
        results = [
            p for p in results
            if p.get("category", "").lower() == category.lower()
        ]

    if limit:
        results = results[:limit]

    return {
        "count": len(results),
        "products": [sanitize_product(p) for p in results]
    }

@router.get("/{id}")
def get_product_by_id(id: int):
    product = next((p for p in PRODUCTS if p.get("id") == id), None)

    if not product:
        raise HTTPException(status_code=404, detail="Produit introuvable")

    return sanitize_product(product)

@router.get("/slug/{slug}")
def get_product_by_slug(slug: str):
    product = next((p for p in PRODUCTS if p.get("slug") == slug), None)

    if not product:
        raise HTTPException(status_code=404, detail="Produit introuvable")

    return sanitize_product(product)
