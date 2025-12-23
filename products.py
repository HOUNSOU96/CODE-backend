import os
import json

# --- CONFIG ---
PRODUCTS_JSON_PATH = "products.json"
IMAGES_BASE_PATH = "Images"  # dossier racine des images
IMAGES_URL_PREFIX = "/images"  # préfixe à utiliser côté frontend


def generate_products_json():
    """
    Ce script NE MODIFIE PAS les données.
    Il recharge simplement products.json, vérifie les images,
    puis réécrit le fichier proprement.
    """

    if not os.path.exists(PRODUCTS_JSON_PATH):
        raise FileNotFoundError("❌ products.json introuvable")

    # 🔹 Charger le JSON existant
    with open(PRODUCTS_JSON_PATH, "r", encoding="utf-8") as f:
        products = json.load(f)

    cleaned_products = []

    for product in products:
        # 🔹 Vérification minimale des champs attendus
        required_fields = [
            "id",
            "name",
            "slug",
            "price",
            # "promoPrice",  # 🔕 promoPrice commenté pour l'instant
            "image_url",
            "short_description",
            "category"
        ]

        for field in required_fields:
            if field not in product:
                raise ValueError(
                    f"❌ Champ manquant '{field}' dans le produit ID {product.get('id')}"
                )

        # 🔹 Vérifier l'existence de l'image (optionnel mais recommandé)
        image_path = product["image_url"].lstrip("/")  # /Images/vins/vins1.jpeg → Images/vins/vins1.jpeg
        if not os.path.exists(image_path):
            print(f"⚠️ Image manquante : {image_path}")

        # 🔹 Adapter le chemin pour le frontend (remplacer /Images par /images)
        image_url = product["image_url"].replace("/Images", IMAGES_URL_PREFIX)

        # 🔹 On garde le produit TEL QUEL, promoPrice commenté pour l'instant
        cleaned_product = {
            "id": product.get("id"),
            "name": product.get("name"),
            "slug": product.get("slug"),
            "price": product.get("price"),
            # "promoPrice": product.get("promoPrice"),
            "image_url": image_url,
            "short_description": product.get("short_description"),
            "category": product.get("category")
        }

        cleaned_products.append(cleaned_product)

    # 🔹 Réécriture propre du JSON
    with open(PRODUCTS_JSON_PATH, "w", encoding="utf-8") as f:
        json.dump(cleaned_products, f, ensure_ascii=False, indent=2)

    print(f"✅ products.json validé et réécrit ({len(cleaned_products)} produits)")
    return cleaned_products


if __name__ == "__main__":
    generate_products_json()
