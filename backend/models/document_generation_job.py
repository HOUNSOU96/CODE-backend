from datetime import datetime

from sqlalchemy import (
    Column,
    String,
    Integer,
    DateTime,
    ForeignKey,
    Text,
    JSON,
    Index,
)

from database import Base


class DocumentGenerationJob(Base):
    __tablename__ = "document_generation_jobs"

    id = Column(String(36), primary_key=True)

    activation_id = Column(
        Integer,
        ForeignKey("document_activations.id"),
        nullable=False,
        index=True,
    )

    status = Column(
        String(20),
        nullable=False,
        default="queued",
        index=True,
    )

    # Données nécessaires à la génération et à la finalisation.
    # Aucun mot de passe en clair ne doit y être enregistré.
    payload = Column(JSON, nullable=False)

    # Chemin du PDF lorsque le stockage a réussi.
    pdf_path = Column(Text, nullable=True)

    # Code d'erreur interne, sans données personnelles.
    error_code = Column(String(100), nullable=True)

    created_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    updated_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
        onupdate=datetime.utcnow,
    )

    completed_at = Column(DateTime, nullable=True)


Index(
    "ix_document_generation_jobs_activation_status",
    DocumentGenerationJob.activation_id,
    DocumentGenerationJob.status,
)
