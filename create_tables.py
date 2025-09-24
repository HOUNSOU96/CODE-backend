# 📁 create_tables.py
from database import Base, engine
from models.user import User
from models.question import Question
from models.remediation_progress import RemediationProgress

def init_db():
    Base.metadata.create_all(bind=engine)
    print("Tables créées avec succès !")

if __name__ == "__main__":
    init_db()
