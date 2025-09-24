from sqlalchemy.orm import Session
from models.user import User
from database import SessionLocal

def check_user(email: str):
    db: Session = SessionLocal()
    user = db.query(User).filter(User.email == email).first()
    if user:
        print(f"Utilisateur trouvé : {user.email}")
    else:
        print("Utilisateur introuvable.")

check_user("deogratiashounsou@gmail.com")
