# 📁 models/question.py
from sqlalchemy import Column, Integer, String, Text
from database import Base

class Question(Base):
    __tablename__ = "questions"

    id = Column(Integer, primary_key=True, index=True)
    niveau = Column(String(10), nullable=False)          # ex. "3e", "4e"
    notion = Column(String(255), nullable=False)         # notion précise (ex. "fractions")
    question = Column(Text, nullable=False)              # énoncé de la question
    reponse_correcte = Column(Text, nullable=False)      # réponse attendue
