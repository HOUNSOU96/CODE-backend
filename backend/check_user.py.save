import os
import bcrypt
import psycopg

# Charger tes variables d'environnement
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_DATABASE")

conn_str = f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}?sslmode=require"

email = "deogratiashounsou@gmail.com"
plain_password = b"code96"

with psycopg.connect(conn_str, autocommit=True) as conn:
    with conn.cursor() as cur:
        cur.execute("SELECT id, email, hashed_password, is_admin FROM users WHERE email = %s", (email,))
        row = cur.fetchone()
        if not row:
            print("Utilisateur introuvable")
        else:
            user_id, email, hashed_password, is_admin = row
            hashed_password = hashed_password.encode()  # s'il s'agit d'une chaîne
            if bcrypt.checkpw(plain_password, hashed_password):
                print(f"Mot de passe correct ✅ | Admin ? {is_admin}")
            else:
                print("Mot de passe incorrect ❌")
