from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime
from datetime import datetime

from database import Base


class ProjectIdea(Base):
    __tablename__ = "project_ideas"

    id = Column(Integer, primary_key=True, index=True)

    # ==========================================================
    # INFORMATIONS PRIVÉES DU DÉPOSANT
    # ==========================================================

    nom = Column(
        String(100),
        nullable=False
    )

    prenom = Column(
        String(100),
        nullable=False
    )

    email = Column(
        String(255),
        nullable=False
    )

    telephone = Column(
        String(50),
        nullable=False
    )

    pays = Column(
        String(100),
        nullable=False
    )

    # ==========================================================
    # INFORMATIONS SUR LE PROJET
    # ==========================================================

    titre = Column(
        String(255),
        nullable=False
    )

    description = Column(
        Text,
        nullable=False
    )

    probleme = Column(
        Text,
        nullable=True
    )

    # Nouvelle information :
    # solution proposée par l'auteur du projet
    solution = Column(
        Text,
        nullable=True
    )

    vision = Column(
        Text,
        nullable=True
    )

    # Nouvelle information :
    # impact attendu du projet
    impact = Column(
        Text,
        nullable=True
    )

    categorie = Column(
        String(100),
        nullable=True
    )

    # ==========================================================
    # GESTION PAR CODE
    # ==========================================================

    statut = Column(
        String(30),
        nullable=False,
        default="pending"
    )

    # ==========================================================
    # CONSENTEMENTS
    # ==========================================================

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

    # ==========================================================
    # DATES
    # ==========================================================

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

    # ==========================================================
    # REPRÉSENTATION
    # ==========================================================

    def __repr__(self):
        return (
            f"<ProjectIdea("
            f"id={self.id}, "
            f"titre={self.titre}, "
            f"statut={self.statut}"
            f")>"
        )