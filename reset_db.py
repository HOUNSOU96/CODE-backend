# reset_db.py
from database import Base, engine
from models.user import User  # et tous les autres modèles

# Supprime toutes les tables existantes
Base.metadata.drop_all(bind=engine)

# Recrée toutes les tables à partir des modèles
Base.metadata.create_all(bind=engine)

print("✔️ Base de données réinitialisée.")
