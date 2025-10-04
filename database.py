# 📁 backend/database.py
import os
import urllib.parse
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# Fonction utilitaire pour récupérer les variables d'environnement
def get_env_var(name: str, default: str = None) -> str:
    """Récupère une variable d'environnement et lève une erreur si absente et pas de valeur par défaut."""
    value = os.getenv(name, default)
    if value is None:
        raise ValueError(f"Variable d'environnement {name} non définie")
    return str(value)

# Récupération des variables d'environnement
DB_USER = get_env_var("DB_USER")
DB_PASSWORD = get_env_var("DB_PASSWORD")
DB_HOST = get_env_var("DB_HOST", "localhost")  # valeur par défaut localhost si non défini
DB_PORT = get_env_var("DB_PORT", "3306")       # valeur par défaut MySQL 3306
DB_NAME = get_env_var("DB_DATABASE")

# Encodage du mot de passe pour gérer les caractères spéciaux
DB_PASSWORD_ENCODED = urllib.parse.quote_plus(DB_PASSWORD)

# Construire l’URL de connexion
DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD_ENCODED}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# Debug : n'affiche pas le mot de passe
print(f"🔗 DATABASE_URL (sans mot de passe) = mysql+pymysql://{DB_USER}:****@{DB_HOST}:{DB_PORT}/{DB_NAME}")

# Créer l’engine SQLAlchemy
engine = create_engine(
    DATABASE_URL,
    echo=True,   # log SQL, utile pour debug
    future=True
)

# Session
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Dépendance pour récupérer une session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
