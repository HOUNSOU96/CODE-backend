# 📁 backend/database.py
import os
import socket
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

# Résoudre explicitement l'adresse IPv4 de Neon.
# Render peut résoudre le hostname en IPv6, mais son environnement
# ne permet pas actuellement d'atteindre cette adresse IPv6.
try:
    ipv4_addresses = socket.getaddrinfo(
        DB_HOST,
        int(DB_PORT),
        socket.AF_INET,
        socket.SOCK_STREAM
    )

    if not ipv4_addresses:
        raise RuntimeError(f"Aucune adresse IPv4 trouvée pour {DB_HOST}")

    DB_HOSTADDR = ipv4_addresses[0][4][0]

    print(f"🌐 IPv4 Neon utilisée : {DB_HOSTADDR}")

except Exception as e:
    raise RuntimeError(
        f"❌ Impossible de résoudre {DB_HOST} en IPv4 : {e}"
    ) from e

# Création du moteur SQLAlchemy
# DB_HOST conserve le nom DNS Neon pour SSL/SNI.
# hostaddr force la connexion réseau vers l'IPv4.
engine = create_engine(
    DATABASE_URL,
    connect_args={"hostaddr": DB_HOSTADDR},
    echo=True,
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
