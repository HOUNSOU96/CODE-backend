from sqlalchemy import Column, String
from sqlalchemy.dialects.postgresql import JSON
from database import Base

class RemediationVideo(Base):
    __tablename__ = "remediation_videos"

    id = Column(String(255), primary_key=True)
    titre = Column(String(200), nullable=True)
    niveau = Column(String(50), nullable=True)
    serie = Column(String(50), nullable=True)
    matiere = Column(String(50), nullable=True)
    mois = Column(JSON, nullable=True)
    videoUrl = Column(String(500), nullable=True)
    notions = Column(JSON, nullable=True)
    prerequis = Column(JSON, nullable=True)
