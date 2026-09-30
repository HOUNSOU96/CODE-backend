# backend/models/school.py

from datetime import datetime

from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
    UniqueConstraint,
    Index,
)
from sqlalchemy.orm import relationship

from database import Base


# ============================================================
# SCHOOL
# ============================================================

class School(Base):
    __tablename__ = "schools"

    __table_args__ = (
        UniqueConstraint(
            "nom",
            "ville",
            "departement",
            name="uq_school_nom_ville_departement",
        ),
    )

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    # --------------------------------------------------------
    # IDENTITÉ
    # --------------------------------------------------------

    nom = Column(
        String(255),
        nullable=False,
        index=True,
    )

    # --------------------------------------------------------
    # LOCALISATION
    # --------------------------------------------------------

    adresse = Column(
        String(500),
        nullable=True,
    )

    ville = Column(
        String(100),
        nullable=True,
        index=True,
    )

    departement = Column(
        String(100),
        nullable=True,
        index=True,
    )

    pays = Column(
        String(100),
        nullable=False,
        default="Bénin",
    )

    # --------------------------------------------------------
    # TYPE ET STATUT
    # --------------------------------------------------------

    # Exemples :
    # - Secondaire général
    # - Technique et professionnel
    # - Technique agricole
    # - Secondaire général et technique
    #
    # Le champ reste volontairement assez large pour permettre
    # l'évolution future de CODE.
    type_enseignement = Column(
        String(500),
        nullable=True,
        index=True,
    )

    # Exemples :
    # - Public
    # - Privé
    statut = Column(
        String(50),
        nullable=True,
        index=True,
    )

    # --------------------------------------------------------
    # CONTACT
    # --------------------------------------------------------

    email = Column(
        String(255),
        nullable=True,
    )

    telephone = Column(
        String(50),
        nullable=True,
    )

    # --------------------------------------------------------
    # ÉTAT
    # --------------------------------------------------------

    is_active = Column(
        Boolean,
        nullable=False,
        default=True,
    )

    created_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    # --------------------------------------------------------
    # RELATIONS
    # --------------------------------------------------------

    memberships = relationship(
        "SchoolMembership",
        back_populates="school",
        cascade="all, delete-orphan",
    )

    directors = relationship(
        "SchoolDirector",
        back_populates="school",
        cascade="all, delete-orphan",
    )

    def __repr__(self):
        return (
            f"<School("
            f"id={self.id}, "
            f"nom={self.nom}, "
            f"ville={self.ville}, "
            f"departement={self.departement}"
            f")>"
        )


# ============================================================
# SCHOOL MEMBERSHIP
# ============================================================

class SchoolMembership(Base):
    __tablename__ = "school_memberships"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    user_id = Column(
        Integer,
        ForeignKey(
            "users.id",
            ondelete="CASCADE",
        ),
        nullable=False,
        index=True,
    )

    school_id = Column(
        Integer,
        ForeignKey(
            "schools.id",
            ondelete="CASCADE",
        ),
        nullable=False,
        index=True,
    )

    # student / teacher
    role = Column(
        String(30),
        nullable=False,
        index=True,
    )

    # pending / approved / rejected
    status = Column(
        String(30),
        nullable=False,
        default="pending",
        index=True,
    )

    # Exemple : 2026-2027
    academic_year = Column(
        String(9),
        nullable=False,
        index=True,
    )

    requested_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    approved_at = Column(
        DateTime,
        nullable=True,
    )

    approved_by = Column(
        Integer,
        ForeignKey(
            "users.id",
            ondelete="SET NULL",
        ),
        nullable=True,
    )

    rejected_at = Column(
        DateTime,
        nullable=True,
    )

    rejected_by = Column(
        Integer,
        ForeignKey(
            "users.id",
            ondelete="SET NULL",
        ),
        nullable=True,
    )

    # --------------------------------------------------------
    # RELATIONS
    # --------------------------------------------------------

    user = relationship(
        "User",
        foreign_keys=[user_id],
        back_populates="school_memberships",
    )

    school = relationship(
        "School",
        back_populates="memberships",
    )

    approver = relationship(
        "User",
        foreign_keys=[approved_by],
    )

    rejecter = relationship(
        "User",
        foreign_keys=[rejected_by],
    )

    # --------------------------------------------------------
    # CONTRAINTES / INDEX
    # --------------------------------------------------------

    __table_args__ = (
        UniqueConstraint(
            "user_id",
            "school_id",
            "academic_year",
            name="uq_user_school_academic_year",
        ),

        Index(
            "ix_school_membership_school_status",
            "school_id",
            "status",
        ),

        Index(
            "ix_school_membership_user_year",
            "user_id",
            "academic_year",
        ),
    )

    def __repr__(self):
        return (
            f"<SchoolMembership("
            f"user_id={self.user_id}, "
            f"school_id={self.school_id}, "
            f"role={self.role}, "
            f"status={self.status}, "
            f"year={self.academic_year}"
            f")>"
        )


# ============================================================
# SCHOOL DIRECTOR
# ============================================================

class SchoolDirector(Base):
    __tablename__ = "school_directors"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    user_id = Column(
        Integer,
        ForeignKey(
            "users.id",
            ondelete="CASCADE",
        ),
        nullable=False,
        index=True,
    )

    school_id = Column(
        Integer,
        ForeignKey(
            "schools.id",
            ondelete="CASCADE",
        ),
        nullable=False,
        index=True,
    )

    is_active = Column(
        Boolean,
        nullable=False,
        default=True,
    )

    assigned_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    assigned_by = Column(
        Integer,
        ForeignKey(
            "users.id",
            ondelete="SET NULL",
        ),
        nullable=True,
    )

    # --------------------------------------------------------
    # RELATIONS
    # --------------------------------------------------------

    director = relationship(
        "User",
        foreign_keys=[user_id],
        back_populates="school_directorships",
    )

    school = relationship(
        "School",
        back_populates="directors",
    )

    assigned_by_user = relationship(
        "User",
        foreign_keys=[assigned_by],
    )

    # --------------------------------------------------------
    # CONTRAINTES / INDEX
    # --------------------------------------------------------

    __table_args__ = (
        UniqueConstraint(
            "user_id",
            "school_id",
            name="uq_school_director",
        ),

        Index(
            "ix_school_director_school_active",
            "school_id",
            "is_active",
        ),
    )

    def __repr__(self):
        return (
            f"<SchoolDirector("
            f"user_id={self.user_id}, "
            f"school_id={self.school_id}, "
            f"active={self.is_active}"
            f")>"
        )