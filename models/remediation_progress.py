# backend/models/remediation_progress.py
from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from database import Base
from models.user import User

class RemediationProgress(Base):
    __tablename__ = "remediation_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    matiere = Column(String(100), nullable=False)        # ex. "Maths", "Physique"
    notion = Column(String(255), nullable=False)         # notion précise
    niveau = Column(String(10), nullable=True)           # ex. "4e", "3e"
    statut = Column(String(50), nullable=True, default="incomplet")  
    video_actuelle_id = Column(String(255), nullable=True)  # id/URL de la dernière vidéo vue

    test_termine = Column(Boolean, default=False)
    test_score = Column(Integer, default=0)

    user = relationship("User", back_populates="remediations")
