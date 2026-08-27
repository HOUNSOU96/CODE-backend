from sqlalchemy import Column, Integer, String, Float, DateTime, JSON
from database import Base
from datetime import datetime

class Order(Base):
    __tablename__ = "orders"

    id = Column(Integer, primary_key=True, index=True)
    user_name = Column(String, nullable=False)
    whatsapp = Column(String, nullable=False)
    secondary_phone = Column(String, nullable=True)
    email = Column(String, nullable=True)
    address = Column(String, nullable=True)
    city = Column(String, nullable=False)
    zip = Column(String, nullable=True)
    items = Column(JSON, nullable=False)  # stocke le panier
    total = Column(Float, nullable=False)
    status = Column(String, default="pending")  # <-- AJOUTÉ
    created_at = Column(DateTime, default=datetime.utcnow)
