# 📁 backend/reset_selected_tables.py
from models import init_models
from database import engine
from sqlalchemy import text
from sqlalchemy.exc import SQLAlchemyError

# Liste des tables à supprimer
tables_to_drop = [
    "questions",
    "resultats",
    "tests_en_cours",
    "video_questions",
    "remediation_videos"
]

if __name__ == "__main__":
    print("🔗 DATABASE_URL =", engine.url)
    print("⚠️ Réinitialisation des tables sélectionnées :")

    with engine.connect() as conn:
        # Désactive les contraintes de clés étrangères
        conn.execute(text("SET FOREIGN_KEY_CHECKS=0;"))

        for table in tables_to_drop:
            print(f" - Suppression de {table}")
            try:
                conn.execute(text(f"DROP TABLE IF EXISTS {table}"))
            except SQLAlchemyError as e:
                print(f"   ❌ Erreur lors de la suppression de {table} : {e}")
                continue

        # Réactive les contraintes de clés étrangères
        conn.execute(text("SET FOREIGN_KEY_CHECKS=1;"))
        conn.commit()

    # Recréation des tables à partir des modèles
    try:
        init_models()
        print("✅ Tables sélectionnées recréées avec succès !")
    except SQLAlchemyError as e:
        print(f"❌ Erreur lors de la création des tables : {e}")
