from datetime import datetime
from typing import List, Optional

from pydantic import BaseModel, Field


# ============================================================
# CRÉATION D'UNE QUESTION
# ============================================================

class QuestionCreate(BaseModel):
    """
    Données envoyées par un utilisateur lorsqu'il pose une question.
    """

    # "admin" ou "subject"
    recipient_type: str = Field(
        ...,
        description="Destinataire : admin ou subject"
    )

    # Obligatoire uniquement lorsque recipient_type = subject
    subject: Optional[str] = Field(
        default=None,
        max_length=100
    )

    # L'utilisateur indique s'il est apprenant
    is_learner: bool = False

    # Obligatoire uniquement si is_learner = True
    learner_class: Optional[str] = Field(
        default=None,
        max_length=100
    )

    title: str = Field(
        ...,
        min_length=1,
        max_length=255
    )

    content: str = Field(
        ...,
        min_length=1
    )


# ============================================================
# ENVOI D'UN MESSAGE
# ============================================================

class MessageCreate(BaseModel):
    content: str = Field(
        ...,
        min_length=1
    )


# ============================================================
# EXPÉDITEUR D'UN MESSAGE
# ============================================================

class MessageResponse(BaseModel):
    id: int
    sender_role: str
    content: str
    created_at: datetime

    class Config:
        from_attributes = True


# ============================================================
# QUESTION — VERSION UTILISATEUR
# ============================================================

class QuestionResponse(BaseModel):
    id: int
    recipient_type: str
    subject: Optional[str]
    is_learner: bool
    learner_class: Optional[str]
    title: str
    content: str
    status: str
    created_at: datetime
    expires_at: datetime
    updated_at: datetime
    messages: List[MessageResponse] = []

    class Config:
        from_attributes = True


# ============================================================
# QUESTION — VERSION ADMINISTRATEUR
# ============================================================

class AdminQuestionResponse(BaseModel):
    id: int

    user_id: int
    user_nom: str
    user_prenom: str
    user_email: str

    recipient_type: str
    subject: Optional[str]

    is_learner: bool
    learner_class: Optional[str]

    title: str
    content: str
    status: str

    created_at: datetime
    expires_at: datetime
    updated_at: datetime

    messages: List[MessageResponse] = []


# ============================================================
# QUESTION — VERSION ENSEIGNANT
# ============================================================

class TeacherQuestionResponse(BaseModel):
    """
    Version volontairement anonyme pour les enseignants.

    IMPORTANT :
    aucune information permettant d'identifier l'utilisateur
    n'est renvoyée ici.
    """

    id: int

    recipient_type: str
    subject: Optional[str]

    is_learner: bool
    learner_class: Optional[str]

    title: str
    content: str
    status: str

    created_at: datetime
    expires_at: datetime
    updated_at: datetime

    messages: List[MessageResponse] = []


# ============================================================
# ENSEIGNANT
# ============================================================

class TeacherResponse(BaseModel):
    id: int
    nom: str
    prenom: str
    email: str
    enseignant: bool
    enseignant_actif: bool
    subjects: List[str] = []


# ============================================================
# MODIFICATION DES MATIÈRES D'UN ENSEIGNANT
# ============================================================

class TeacherSubjectsUpdate(BaseModel):
    subjects: List[str]






class AdminTeacherConversationResponse(BaseModel):
    id: int

    user_id: int
    user_nom: str
    user_prenom: str
    user_email: str

    recipient_type: str
    subject: Optional[str]

    is_learner: bool
    learner_class: Optional[str]

    title: str
    content: str

    status: str

    created_at: datetime
    expires_at: datetime
    updated_at: datetime

    teacher_names: List[str] = []

    messages: List[MessageResponse] = []

    class Config:
        from_attributes = True


class AdminTeacherConversationListResponse(BaseModel):
    id: int

    user_id: int
    user_nom: str
    user_prenom: str
    user_email: str

    subject: Optional[str]
    learner_class: Optional[str]

    title: str
    status: str

    created_at: datetime
    updated_at: datetime

    teacher_names: List[str] = []

    message_count: int