from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    DateTime,
    ForeignKey,
)
from sqlalchemy.orm import relationship
from datetime import datetime

from database import Base


class UserDevice(Base):
    __tablename__ = "user_devices"

    id = Column(
        Integer,
        primary_key=True,
        index=True,
    )

    # ======================================================
    # UTILISATEUR
    # ======================================================

    user_id = Column(
        Integer,
        ForeignKey("users.id"),
        nullable=False,
        index=True,
    )

    # ======================================================
    # IDENTIFIANT DE L'APPAREIL
    # ======================================================

    device_id = Column(
        String(255),
        unique=True,
        nullable=False,
        index=True,
    )

    # ======================================================
    # TYPE D'APPAREIL
    # ======================================================

    device_type = Column(
        String(30),
        nullable=False,
        default="unknown",
    )

    # Exemples :
    # android
    # ios
    # tablet
    # pc
    # unknown

    # ======================================================
    # APPAREIL MOBILE ?
    # ======================================================

    is_mobile = Column(
        Boolean,
        nullable=False,
        default=False,
    )

    # ======================================================
    # APPAREIL ACTIF
    # ======================================================

    is_active = Column(
        Boolean,
        nullable=False,
        default=True,
    )

    # ======================================================
    # DATES
    # ======================================================

    created_at = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    last_seen = Column(
        DateTime,
        nullable=False,
        default=datetime.utcnow,
    )

    # ======================================================
    # RELATION UTILISATEUR
    # ======================================================

    user = relationship(
        "User",
        foreign_keys=[user_id],
        back_populates="devices",
    )

    # ======================================================
    # RELATION AVEC LES DOCUMENTS
    # ======================================================

    document_accesses = relationship(
        "DocumentDeviceAccess",
        back_populates="device",
        cascade="all, delete-orphan",
    )