from sqlalchemy import Column, Integer, String, ForeignKey, UniqueConstraint, DateTime, func
from sqlalchemy.orm import relationship

from database import Base


class TeacherSubject(Base):
    __tablename__ = "teacher_subjects"

    id = Column(Integer, primary_key=True, index=True)

    teacher_id = Column(
        Integer,
        ForeignKey("users.id", ondelete="CASCADE"),
        nullable=False,
        index=True
    )

    subject = Column(
        String(100),
        nullable=False,
        index=True
    )

    created_at = Column(
        DateTime,
        server_default=func.now(),
        nullable=False
    )

    teacher = relationship(
        "User",
        back_populates="teacher_subjects"
    )

    __table_args__ = (
        UniqueConstraint(
            "teacher_id",
            "subject",
            name="uq_teacher_subject"
        ),
    )

    def __repr__(self):
        return (
            f"<TeacherSubject("
            f"teacher_id={self.teacher_id}, "
            f"subject={self.subject})>"
        )