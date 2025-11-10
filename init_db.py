# 📁 init_db.py
from datetime import datetime
from database import Base, engine, get_db
from models.user import User
from models.connection_log import UserConnectionLog

# ---------------- 1️⃣ Créer les tables ----------------
Base.metadata.create_all(bind=engine)
print("✅ Tables mises à jour dans la base")

# ---------------- 2️⃣ Ouvrir une session DB ----------------
db = next(get_db())

# ---------------- 3️⃣ Vérifier qu'un utilisateur existe ----------------
user = db.query(User).first()
if not user:
    raise Exception("❌ Aucun utilisateur trouvé. Crée d'abord un utilisateur test.")

# ---------------- 4️⃣ Ajouter un log de connexion fictif ----------------
log = UserConnectionLog(
    user_id=user.id,
    date=datetime.today().date(),
    heure_connexion=datetime.now().strftime("%H:%M"),
    heure_deconnexion=None  # None = encore connecté
)

db.add(log)
db.commit()
print(f"✅ Log ajouté pour l'utilisateur {user.email}")

# ---------------- 5️⃣ Vérifier les logs ----------------
logs = db.query(UserConnectionLog).all()
print("📋 Logs :", logs)
print("👤 Utilisateurs associés :", [log.user for log in logs])

# ---------------- 6️⃣ Fermer la session ----------------
db.close()
