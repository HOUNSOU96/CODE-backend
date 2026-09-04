from sqlalchemy import (
    Column,
    Integer,
    String,
    Text,
    Boolean,
    DateTime,
    ForeignKey,
    func
)
from sqlalchemy.orm import relationship

from database import Base


class UserQuestion(Base):
    __tablename__ = "user_questions"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    # Utilisateur qui a posé la question
    user_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    # Type de destinataire :
    # "admin" ou "subject"
    recipient_type = Column(
        String(20),
        nullable=False,
        index=True
    )

    # Matière concernée.
    # NULL lorsque recipient_type = "admin"
    subject = Column(
        String(100),
        nullable=True,
        index=True
    )

    # L'utilisateur indique s'il est apprenant
    is_learner = Column(
        Boolean,
        nullable=False,
        default=False
    )

    # Classe de l'apprenant.
    # NULL si l'utilisateur n'est pas apprenant.
    learner_class = Column(
        String(100),
        nullable=True
    )

    # Titre/résumé court de la question
    title = Column(
        String(255),
        nullable=False
    )

    # Première question posée
    content = Column(
        Text,
        nullable=False
    )

    # waiting / in_progress / answered / expired
    status = Column(
        String(30),
        nullable=False,
        default="waiting",
        index=True
    )

    # Date de création
    created_at = Column(
        DateTime,
        server_default=func.now(),
        nullable=False,
        index=True
    )

    # Date à laquelle l'échange doit disparaître
    expires_at = Column(
        DateTime,
        nullable=False,
        index=True
    )

    # Date de dernière activité
    updated_at = Column(
        DateTime,
        server_default=func.now(),
        onupdate=func.now(),
        nullable=False
    )

    # Relation avec User
    user = relationship(
        "User",
        back_populates="questions"
    )

    # Messages de la conversation
    messages = relationship(
        "QuestionMessage",
        back_populates="question",
        cascade="all, delete-orphan",
        order_by="QuestionMessage.created_at"
    )

    def __repr__(self):
        return (
            f"<UserQuestion("
            f"id={self.id}, "
            f"user_id={self.user_id}, "
            f"recipient_type={self.recipient_type}, "
            f"subject={self.subject}, "
            f"status={self.status})>"
        )