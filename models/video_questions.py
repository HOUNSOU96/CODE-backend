from sqlalchemy import Column, String, Integer, ForeignKey
from sqlalchemy.dialects.postgresql import JSON
from database import Base

class VideoQuestion(Base):
    __tablename__ = "video_questions"

    id = Column(String(255), primary_key=True)
    question = Column(String(500), nullable=True)
    choix = Column(JSON, nullable=True)
    bonne_reponse = Column(String(255), nullable=True)
    niveau = Column(String(50), nullable=True)
    serie = Column(String(50), nullable=True)
    matiere = Column(String(50), nullable=True)
    notion = Column(String(100), nullable=True)
    duration = Column(Integer, nullable=True)
    remediation_video_id = Column(String(255), ForeignKey("remediation_videos.id"), nullable=False)
