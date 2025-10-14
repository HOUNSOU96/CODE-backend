# 📁 backend/database.py
import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

# Charger les variables depuis .env
load_dotenv()

# Fonction utilitaire pour récupérer les variables d'environnement
def get_env_var(name: str, default: str = None) -> str:
    value = os.getenv(name, default)
    if value is None:
        raise ValueError(f"Variable d'environnement {name} non définie")
    return str(value)

# Variables d'environnement pour PostgreSQL
DB_USER = get_env_var("DB_USER")
DB_PASSWORD = get_env_var("DB_PASSWORD")
DB_HOST = get_env_var("DB_HOST", "localhost")
DB_PORT = get_env_var("DB_PORT", "5432")  # PostgreSQL par défaut
DB_NAME = get_env_var("DB_DATABASE")

# URL de connexion SQLAlchemy pour PostgreSQL
DATABASE_URL = f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

print(f"🔗 DATABASE_URL (sans mot de passe) = postgresql+psycopg2://{DB_USER}:****@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Créer l’engine SQLAlchemy
engine = create_engine(
    DATABASE_URL,
    echo=True,
    future=True
)

# Session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Dépendance pour FastAPI
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
