import os
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

load_dotenv()  # ⚡ Assure que les variables .env sont chargées

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_DATABASE")

if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_NAME]):
    print("⚠️ Une ou plusieurs variables DB ne sont pas définies, l'engine sera désactivé")
    engine = None
else:
    DATABASE_URL = f"postgresql+psycopg://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
    print(f"🔗 DATABASE_URL = postgresql+psycopg://{DB_USER}:****@{DB_HOST}:{DB_PORT}/{DB_NAME}")
    engine = create_engine(DATABASE_URL, echo=True, future=True)

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    if engine is None:
        raise RuntimeError("Database engine non disponible !")
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
