# 📁 backend/database.py
import os
import urllib.parse
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

# Charger les variables d'environnement
load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", 5432)
DB_NAME = os.getenv("DB_DATABASE")

# Encodage du mot de passe (utile si contient @, #, %, etc.)
DB_PASSWORD = urllib.parse.quote_plus(DB_PASSWORD)

# Construire l’URL de connexion PostgreSQL
DATABASE_URL = f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

# Debug
print("🔗 DATABASE_URL =", DATABASE_URL)

# Créer l’engine SQLAlchemy
engine = create_engine(
    DATABASE_URL,
    echo=True,   # log SQL
    future=True
)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

# Dépendance pour récupérer une session
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
