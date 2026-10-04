from sqlalchemy import (
    Column,
    Integer,
    Boolean,
    DateTime,
    ForeignKey,
)
from sqlalchemy.orm import relationship
from datetime import datetime

from database import Base


class DocumentDeviceAccess(Base):
    __tablename__ = "document_device_accesses"

    # ============================================================
    # IDENTIFIANT
    # ============================================================

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    # ============================================================
    # ACTIVATION DU DOCUMENT
    # ============================================================

    activation_id = Column(
        Integer,
        ForeignKey("document_activations.id"),
        nullable=False,
        index=True,
    )

    # ============================================================
    # UTILISATEUR
    # ============================================================

    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False,
        index=True,
    )

    # ============================================================
    # APPAREIL
    # ============================================================

    device_id = Column(
        Integer,
        ForeignKey("user_devices.id"),
        nullable=False,
        index=True,
    )

    # ============================================================
    # ACCÈS ACTIF
    # ============================================================

    is_active = Column(
        Boolean,
        nullable=False,
        default=True,
    )

    # ============================================================
    # DATES
    # ============================================================

    activated_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    last_access = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    # ============================================================
    # VERSION DU DOCUMENT
    # ============================================================

    last_version = Column(
        Integer,
        nullable=False,
        default=1,
    )

    # ============================================================
    # RELATION AVEC L'ACTIVATION
    # ============================================================

    activation = relationship(
        "DocumentActivation",
        back_populates="device_accesses",
    )

    # ============================================================
    # RELATION AVEC L'UTILISATEUR
    # ============================================================

    user = relationship(
        "User",
        foreign_keys=[user_id],
        back_populates="document_device_accesses",
    )

    # ============================================================
    # RELATION AVEC L'APPAREIL
    # ============================================================

    device = relationship(
        "UserDevice",
        foreign_keys=[device_id],
        back_populates="document_accesses",
    )

    # ============================================================
    # REPRÉSENTATION
    # ============================================================

    def __repr__(self):
        return (
            f"<DocumentDeviceAccess("
            f"id={self.id}, "
            f"activation_id={self.activation_id}, "
            f"user_id={self.user_id}, "
            f"device_id={self.device_id}, "
            f"is_active={self.is_active}"
            f")>"
        )
