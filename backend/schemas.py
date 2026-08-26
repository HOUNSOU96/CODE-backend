from pydantic import BaseModel, EmailStr, Field
from typing import Optional
from datetime import datetime, date


# -----------------------------
# Schémas Utilisateur (User)
# -----------------------------

class UserBase(BaseModel):
    nom: str
    prenom: str
    email: EmailStr
    telephone: Optional[str] = None
    date_naissance: Optional[date] = None


class UserCreate(UserBase):
    password: str = Field(..., min_length=6)


class UserRead(UserBase):
    id: int
    is_active: bool
    date_inscription: datetime

    class Config:
        from_attributes = True


# -----------------------------
# Schémas Notion
# -----------------------------

class NotionBase(BaseModel):
    nom: str
    description: Optional[str] = None


class NotionCreate(NotionBase):
    pass


class NotionRead(NotionBase):
    id: int

    class Config:
        from_attributes = True


# -----------------------------
# Schémas RemediationProgress
# -----------------------------

class RemediationProgressBase(BaseModel):
    user_id: int
    notion_id: int
    niveau: str
    statut: str = "en_cours"
    score: Optional[int] = None
    date_debut: Optional[datetime] = None
    date_fin: Optional[datetime] = None


class RemediationProgressCreate(RemediationProgressBase):
    pass


class RemediationProgressRead(RemediationProgressBase):
    id: int
    user: Optional[UserRead] = None
    notion: Optional[NotionRead] = None

    class Config:
        from_attributes = True
