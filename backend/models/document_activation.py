from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
    LargeBinary,
)
from sqlalchemy.orm import relationship

from database import Base


class DocumentActivation(Base):
    __tablename__ = "document_activations"

    id = Column(Integer, primary_key=True, index=True)

    # ============================================================
    # CODE D'ACTIVATION
    # ============================================================

    # CODE unique imprimé/fourni avec le document
    activation_code = Column(
        String(100),
        unique=True,
        nullable=False,
        index=True
    )

    # ============================================================
    # ACHETEUR
    # ============================================================

    # Identité de l'acheteur
    buyer_email = Column(
        String(255),
        nullable=True,
        index=True
    )

    # ============================================================
    # BÉNÉFICIAIRE
    # ============================================================

    # Email du bénéficiaire final.
    # Peut être différent de celui de l'acheteur.
    beneficiary_email = Column(
        String(255),
        nullable=True,
        index=True
    )

    # ============================================================
    # DOCUMENT
    # ============================================================

    document_name = Column(
        String(255),
        nullable=False
    )

    # ============================================================
    # UTILISATEUR
    # ============================================================

    # ID de l'utilisateur qui bénéficiera finalement du document
    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=True,
        index=True
    )

    # Relation avec User
    user = relationship(
        "User",
        back_populates="document_activations"
    )

    # ============================================================
    # INFORMATIONS D'ACTIVATION
    # ============================================================

    is_activated = Column(
        Boolean,
        default=False
    )

    activated_at = Column(
        DateTime,
        nullable=True
    )

    # Pour savoir si le document est donné
    # à l'acheteur ou à une autre personne
    activation_type = Column(
        String(20),
        nullable=True
    )

    # ============================================================
    # PDF PERSONNALISÉ DU DOCUMENT
    # ============================================================
    #
    # Le PDF généré lors de l'activation est conservé directement
    # dans PostgreSQL.
    #
    # Cela permet à l'utilisateur de retrouver son document depuis
    # "Mes documents", même après redémarrage ou redéploiement du
    # backend.
    #
    # nullable=True est volontaire afin de ne pas casser les
    # anciennes activations qui n'ont pas encore de PDF enregistré.
    #

    pdf_data = Column(
        LargeBinary,
        nullable=True
    )

    # Nom du fichier PDF conservé pour l'affichage/téléchargement
    pdf_filename = Column(
        String(255),
        nullable=True
    )

    # ============================================================
    # RELATION AVEC LES AUTORISATIONS PAR APPAREIL
    # ============================================================
    #
    # Une activation peut être associée à un ou plusieurs appareils
    # autorisés selon les règles définies dans
    # DocumentDeviceAccess.
    #

    device_accesses = relationship(
        "DocumentDeviceAccess",
        back_populates="activation",
        cascade="all, delete-orphan",
    )