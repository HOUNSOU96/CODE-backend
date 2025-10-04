from database import get_db
from models.user import User

def test_users():
    db = next(get_db())
    users = db.query(User).all()
    print(f"Nombre d'utilisateurs en base : {len(users)}")
    for u in users:
        print(f"ID: {u.id}, Email: {u.email}")

if __name__ == "__main__":
    test_users()
