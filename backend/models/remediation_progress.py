from sqlalchemy import Column, Integer, String, Boolean, ForeignKey
from sqlalchemy.orm import relationship
from database import Base
from models.user import User

class RemediationProgress(Base):
    __tablename__ = "remediation_progress"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)

    matiere = Column(String(100), nullable=False)
    notion = Column(String(255), nullable=False)
    niveau = Column(String(10), nullable=True)
    statut = Column(String(50), nullable=True, default="incomplet")
    video_actuelle_id = Column(String(255), nullable=True)

    test_termine = Column(Boolean, default=False)
    test_score = Column(Integer, default=0)

    user = relationship("User", back_populates="remediations")
