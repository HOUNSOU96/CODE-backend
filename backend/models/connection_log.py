from sqlalchemy import Column, Integer, Date, Time, ForeignKey
from sqlalchemy.orm import relationship
from datetime import datetime
from database import Base

class UserConnectionLog(Base):
    __tablename__ = "user_connection_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    date = Column(Date, default=datetime.utcnow)
    heure_connexion = Column(Time)
    heure_deconnexion = Column(Time, nullable=True)

    user = relationship("User", back_populates="connection_logs")
