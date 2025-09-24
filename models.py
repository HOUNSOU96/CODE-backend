from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    ForeignKey,
    DateTime,
    Text,
    UniqueConstraint,
    Date,
)
from sqlalchemy.orm import relationship, declarative_base
from datetime import datetime

Base = declarative_base()

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    nom = Column(String, nullable=False)
    prenom = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False, index=True)
    telephone = Column(String, unique=True, nullable=True)
    date_naissance = Column(Date, nullable=True)
    hashed_password = Column(String, nullable=False)
    is_active = Column(Boolean, default=True)
    date_inscription = Column(DateTime, default=datetime.utcnow)

    


    # Relation avec la progression de remédiation
    progressions = relationship("RemediationProgress", back_populates="user")

    def __repr__(self):
        return f"<User(id={self.id}, email={self.email})>"


class Notion(Base):
    __tablename__ = "notions"

    id = Column(Integer, primary_key=True)
    nom = Column(String, unique=True, nullable=False, index=True)  # ex: "fractions", "équations"
    description = Column(Text, nullable=True)

    # Relation inverse vers progressions
    progressions = relationship("RemediationProgress", back_populates="notion")

    def __repr__(self):
        return f"<Notion(id={self.id}, nom={self.nom})>"


class RemediationProgress(Base):
    __tablename__ = "remediation_progress"

    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey("users.id"), nullable=False)
    notion_id = Column(Integer, ForeignKey("notions.id"), nullable=False)
    niveau = Column(String, nullable=False)  # ex: "6e", "4e", "2nde"
    statut = Column(String, nullable=False, default="en_cours")  # ex: "en_cours", "complet"
    score = Column(Integer, nullable=True)  # score max obtenu sur la notion (ex: sur 20)
    date_debut = Column(DateTime, default=datetime.utcnow)
    date_fin = Column(DateTime, nullable=True)
 

   

    user = relationship("User", back_populates="progressions")
    notion = relationship("Notion", back_populates="progressions")

    __table_args__ = (
        UniqueConstraint("user_id", "notion_id", "niveau", name="uix_user_notion_niveau"),
    )

    def __repr__(self):
        return (f"<RemediationProgress(user_id={self.user_id}, notion_id={self.notion_id}, "
                f"niveau={self.niveau}, statut={self.statut}, score={self.score})>")
