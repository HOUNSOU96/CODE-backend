from sqlalchemy import Column, Integer, String, Boolean, Date, DateTime
from sqlalchemy.orm import relationship
from datetime import datetime
from enum import Enum
from database import Base

class UserStatus(str, Enum):
    PENDING = "pending"
    VALIDATED = "validated"
    REFUSED = "refused"

class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True)
    nom = Column(String(100), nullable=False, index=True)
    prenom = Column(String(100), nullable=False, index=True)
    email = Column(String(255), nullable=False, unique=True, index=True)
    telephone = Column(String(20), nullable=True, index=True)

    sexe = Column(String(1), nullable=True)
    date_naissance = Column(Date, nullable=True)
    lieu_naissance = Column(String(255), nullable=True)
    nationalite = Column(String(100), nullable=True)
    pays_residence = Column(String(100), nullable=True)

    hashed_password = Column(String(255), nullable=False)
    # plain_password à ne conserver qu'en dev / temporaire
    plain_password = Column(String(255), nullable=True)  

    status = Column(String(50), default=UserStatus.PENDING.value)
    validation_token = Column(String(255), nullable=True)
    is_validated = Column(Boolean, default=False)
    is_admin = Column(Boolean, default=False)
    is_blocked = Column(Boolean, default=False)
    is_active = Column(Boolean, default=True)
    is_verified = Column(Boolean, default=False)
    last_warning = Column(DateTime, nullable=True)
    last_seen = Column(DateTime, default=datetime.utcnow)

    date_inscription = Column(DateTime, default=datetime.utcnow)
    created_at = Column(DateTime, default=datetime.utcnow)

    reset_token = Column(String(255), nullable=True)
    reset_token_expiry = Column(DateTime, nullable=True)

    # Relation avec la table remediation_progress si nécessaire
    remediations = relationship("RemediationProgress", back_populates="user")

    def __repr__(self):
        return f"<User(id={self.id}, email={self.email}, status={self.status}, validated={self.is_validated})>"
