from sqlalchemy import Column, Integer, String, Boolean, DateTime, ForeignKey
from sqlalchemy.orm import relationship
from database import Base


class DocumentActivation(Base):
    __tablename__ = "document_activations"

    id = Column(Integer, primary_key=True, index=True)

    # CODE unique imprimé/fourni avec le document
    activation_code = Column(
        String(100),
        unique=True,
        nullable=False,
        index=True
    )

    # Identité de l'acheteur
    buyer_email = Column(
        String(255),
        nullable=True,
        index=True
    )


        # Email du bénéficiaire final
    # Peut être différent de celui de l'acheteur
    beneficiary_email = Column(
        String(255),
        nullable=True,
        index=True
    )

    # Document concerné
    document_name = Column(
        String(255),
        nullable=False
    )

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

    # Informations sur l'activation
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
    