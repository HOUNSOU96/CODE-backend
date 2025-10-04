# 📁 migrate_pending_users.py
from sqlalchemy.orm import Session
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from datetime import datetime

# 🔹 Importer vos modèles
from models.pending_user import PendingUser, Base as PendingBase
from models.user import User, Base as UserBase

# 🔹 Configuration DB (à adapter à ton environnement)
DATABASE_URL = "mysql+pymysql://code_user:holy96H%40@localhost:3306/code_db"


engine = create_engine(DATABASE_URL, echo=True)
SessionLocal = sessionmaker(bind=engine)

def migrate_pending_users():
    session: Session = SessionLocal()
    try:
        # 1️⃣ Récupérer tous les utilisateurs en attente
        pending_users = session.query(PendingUser).all()
        if not pending_users:
            print("Aucun utilisateur en attente à migrer.")
            return

        for pu in pending_users:
            # 2️⃣ Créer un User
            new_user = User(
                nom=pu.nom,
                prenom=pu.prenom,
                email=pu.email,
                hashed_password=pu.hashed_password,
                telephone=pu.telephone,
                date_naissance=pu.date_naissance,
                lieu_naissance=pu.lieu_naissance,
                nationalite=pu.nationalite,
                pays_residence=pu.pays_residence,
                is_validated=True,
                date_inscription=pu.date_inscription,
                created_at=datetime.utcnow()
            )
            session.add(new_user)

            # 3️⃣ Supprimer le PendingUser
            session.delete(pu)

        # 4️⃣ Commit
        session.commit()
        print(f"{len(pending_users)} utilisateur(s) migré(s) avec succès.")

    except Exception as e:
        session.rollback()
        print("Erreur lors de la migration :", e)
    finally:
        session.close()

if __name__ == "__main__":
    migrate_pending_users()
