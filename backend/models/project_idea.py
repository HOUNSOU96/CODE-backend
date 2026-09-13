from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime
from datetime import datetime

from database import Base


class ProjectIdea(Base):
    __tablename__ = "project_ideas"

    id = Column(Integer, primary_key=True, index=True)

    # Informations privées du déposant
    nom = Column(String(100), nullable=False)
    prenom = Column(String(100), nullable=False)
    email = Column(String(255), nullable=False)
    telephone = Column(String(50), nullable=False)
    pays = Column(String(100), nullable=False)

    # Informations sur le projet
    titre = Column(String(255), nullable=False)
    description = Column(Text, nullable=False)
    probleme = Column(Text, nullable=True)
    vision = Column(Text, nullable=True)
    categorie = Column(String(100), nullable=True)

    # Gestion par CODE
    statut = Column(
        String(30),
        nullable=False,
        default="pending"
    )

    # Consentements
    consentement_publication = Column(
        Boolean,
        nullable=False,
        default=False
    )

    declaration_droits = Column(
        Boolean,
        nullable=False,
        default=False
    )

    # Dates
    date_soumission = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow
    )

    date_examen = Column(
        DateTime,
        nullable=True
    )

    date_publication = Column(
        DateTime,
        nullable=True
    )

    def __repr__(self):
        return (
            f"<ProjectIdea("
            f"id={self.id}, "
            f"titre={self.titre}, "
            f"statut={self.statut}"
            f")>"
        )