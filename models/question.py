from sqlalchemy import Column, String, Integer, Text
from sqlalchemy.dialects.postgresql import JSON
from database import Base

class Question(Base):
    __tablename__ = "questions"

    id = Column(String(255), primary_key=True, index=True)
    niveau = Column(String(10), nullable=False)
    notion = Column(String(255), nullable=False)
    question = Column(Text, nullable=False)
    reponse_correcte = Column(Text, nullable=False)
    choix = Column(JSON, nullable=True)
    situation = Column(JSON, nullable=True)
