from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    Text,
    UniqueConstraint,
)

from datetime import datetime

from database import Base


class DocumentVersion(Base):
    __tablename__ = "document_versions"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    # ======================================================
    # DOCUMENT
    # ======================================================

    document_name = Column(
        String(255),
        nullable=False,
        index=True,
    )

    # ======================================================
    # VERSION
    # ======================================================

    version_code = Column(
        Integer,
        nullable=False,
    )

    version_label = Column(
        String(50),
        nullable=False,
    )

    # Exemple :
    # version_code = 1
    # version_label = "2027.1"

    # ======================================================
    # INFORMATIONS
    # ======================================================

    title = Column(
        String(255),
        nullable=True,
    )

    description = Column(
        Text,
        nullable=True,
    )

    # ======================================================
    # CONTENU
    # ======================================================

    content_path = Column(
        String(500),
        nullable=True,
    )

    content_hash = Column(
        String(128),
        nullable=True,
    )

    # ======================================================
    # PUBLICATION
    # ======================================================

    published_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    is_current = Column(
        Boolean,
        nullable=False,
        default=False,
    )

    # ======================================================
    # CONTRAINTE
    # ======================================================

    __table_args__ = (
        UniqueConstraint(
            "document_name",
            "version_code",
            name="uq_document_version",
        ),
    )