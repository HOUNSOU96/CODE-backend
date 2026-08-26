import os
import httpx
import asyncio

# 🔹 Chargement des variables d'environnement
BREVO_API_KEY = os.getenv("BREVO_API_KEY")
MAIL_FROM = os.getenv("MAIL_FROM")
MAIL_FROM_NAME = os.getenv("MAIL_FROM_NAME", "CODE")


# 🔹 Fonction asynchrone d’envoi d’email via API Brevo
async def send_email(to: str, subject: str, body: str):
    url = "https://api.brevo.com/v3/smtp/email"
    payload = {
        "sender": {"name": MAIL_FROM_NAME, "email": MAIL_FROM},
        "to": [{"email": to}],
        "subject": subject,
        "textContent": body
    }
    headers = {
        "accept": "application/json",
        "api-key": BREVO_API_KEY,
        "content-type": "application/json"
    }

    async with httpx.AsyncClient() as client:
        response = await client.post(url, json=payload, headers=headers)
        response.raise_for_status()  # lève une exception si erreur
        return response.json()


# 🔹 Version synchrone (pour appels non async)
def send_email_sync(to: str, subject: str, body: str):
    try:
        asyncio.run(send_email(to, subject, body))
    except RuntimeError:
        # Pour cas où un event loop existe déjà
        asyncio.get_event_loop().create_task(send_email(to, subject, body))
    except Exception as e:
        print(f"❌ Erreur d'envoi d'email : {e}")
