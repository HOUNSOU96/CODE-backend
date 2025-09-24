from sqlalchemy import Column, String, Integer, DateTime, Boolean
from sqlalchemy.orm import declarative_base
from datetime import datetime

Base = declarative_base()

class PendingUser(Base):
    __tablename__ = "pending_users"

    id = Column(Integer, primary_key=True, autoincrement=True)
    nom = Column(String(255), nullable=False)
    prenom = Column(String(255), nullable=False)
    sexe = Column(String(1), nullable=True)
    email = Column(String(255), nullable=False, unique=True)
    hashed_password = Column(String(255), nullable=False)
    telephone = Column(String(50), nullable=True)
    date_naissance = Column(DateTime, nullable=True)
    lieu_naissance = Column(String(255), nullable=True)
    nationalite = Column(String(100), nullable=True)
    pays_residence = Column(String(100), nullable=True)
    validation_token = Column(String(255), nullable=True)
    is_validated = Column(Boolean, default=False)
    created_at = Column(DateTime, default=datetime.utcnow)
    date_inscription = Column(DateTime, default=datetime.utcnow)
