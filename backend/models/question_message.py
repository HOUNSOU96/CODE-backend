from sqlalchemy import (
    Column,
    Integer,
    Text,
    String,
    DateTime,
    ForeignKey,
    func
)
from sqlalchemy.orm import relationship

from database import Base


class QuestionMessage(Base):
    __tablename__ = "question_messages"

    id = Column(
        Integer,
        primary_key=True,
        index=True
    )

    # Conversation à laquelle appartient le message
    question_id = Column(
        Integer,
        ForeignKey("user_questions.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    # Utilisateur ayant envoyé le message
    sender_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    # user / admin / teacher
    sender_role = Column(
        String(20),
        nullable=False
    )

    # Contenu du message
    content = Column(
        Text,
        nullable=False
    )

    created_at = Column(
        DateTime,
        server_default=func.now(),
        nullable=False,
        index=True
    )

    # Relation avec UserQuestion
    question = relationship(
        "UserQuestion",
        back_populates="messages"
    )

    # Relation avec User
    sender = relationship(
        "User",
        foreign_keys=[sender_id]
    )

    def __repr__(self):
        return (
            f"<QuestionMessage("
            f"id={self.id}, "
            f"question_id={self.question_id}, "
            f"sender_id={self.sender_id}, "
            f"sender_role={self.sender_role})>"
        )