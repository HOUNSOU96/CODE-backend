from sqlalchemy.orm import Session
from models.user import User
from database import SessionLocal
from passlib.context import CryptContext

# Configuration du hash bcrypt
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def create_user():
    email = "deogratiashounsou@gmail.com"
    mot_de_passe = "holy96H@" 
      # Change-le par le vrai mot de passe voulu

    with SessionLocal() as db:
        existing_user = db.query(User).filter(User.email == email).first()
        if existing_user:
            print("⚠️ L'utilisateur existe déjà.")
            return

        hashed_pw = pwd_context.hash(mot_de_passe)

        user = User(
            nom="HOUNSOU",
            prenom="Déo-Gratias",
            email=email,
            otp="",
            is_verified=False,
            hashed_password=hashed_pw
        )
        db.add(user)
        db.commit()
        db.refresh(user)
        print(f"✅ Utilisateur ajouté : {user.email}")

if __name__ == "__main__":
    create_user()
