import os
import asyncio
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig

# 🔹 Chargement des variables d'environnement
MAIL_USERNAME = os.getenv("MAIL_USERNAME")
MAIL_PASSWORD = os.getenv("MAIL_PASSWORD")
MAIL_FROM = os.getenv("MAIL_FROM")
MAIL_FROM_NAME = os.getenv("MAIL_FROM_NAME", "CODE")
MAIL_SERVER = os.getenv("MAIL_SERVER", "smtp-relay.brevo.com")
MAIL_PORT = int(os.getenv("MAIL_PORT", 587))
MAIL_STARTTLS = os.getenv("MAIL_STARTTLS", "True").lower() == "true"
MAIL_SSL_TLS = os.getenv("MAIL_SSL_TLS", "False").lower() == "true"

# 🔹 Configuration du serveur SMTP (Brevo)
conf = ConnectionConfig(
    MAIL_USERNAME=MAIL_USERNAME,
    MAIL_PASSWORD=MAIL_PASSWORD,
    MAIL_FROM=MAIL_FROM,
    MAIL_FROM_NAME=MAIL_FROM_NAME,
    MAIL_SERVER=MAIL_SERVER,
    MAIL_PORT=MAIL_PORT,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=True,
)

fm = FastMail(conf)

# 🔹 Fonction asynchrone d’envoi d’email
async def send_email(to: str, subject: str, body: str, subtype: str = "plain", attachments: list[str] = None):
    message = MessageSchema(
        subject=subject,
        recipients=[to],
        body=body,
        subtype=subtype,
        attachments=attachments or [],
    )
    await fm.send_message(message)


# 🔹 Version synchrone (pour les appels non async)
def send_email_sync(to: str, subject: str, body: str, subtype: str = "plain", attachments: list[str] = None):
    try:
        asyncio.run(send_email(to, subject, body, subtype=subtype, attachments=attachments))
    except RuntimeError:
        asyncio.get_event_loop().create_task(send_email(to, subject, body, subtype=subtype, attachments=attachments))
    except Exception as e:
        print(f"❌ Erreur d'envoi d'email : {e}")
