# 📁 backend/database.py
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

# Charger les variables d'environnement depuis .env
load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_DATABASE")

if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_NAME]):
    raise ValueError("❌ Une ou plusieurs variables d'environnement DB ne sont pas définies !")

# ✅ Chaîne de connexion adaptée à Neon (avec SSL obligatoire)
DATABASE_URL = f"postgresql+psycopg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?sslmode=require"

print(f"🔗 DATABASE_URL = postgresql+psycopg://{DB_USER}:****@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Création du moteur SQLAlchemy
engine = create_engine(
    DATABASE_URL,
    echo=True,        # Affiche les requêtes SQL dans la console
    future=True
)

# Configuration de la session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Base pour les modèles SQLAlchemy
Base = declarative_base()

# Dépendance FastAPI pour obtenir la session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
