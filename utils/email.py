# backend/utils/email.py
import os
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig
import asyncio
from dotenv import load_dotenv

load_dotenv()

# Sécurisation des variables
MAIL_USERNAME = os.getenv("MAIL_USERNAME", "")
MAIL_PASSWORD = os.getenv("MAIL_PASSWORD", "")
MAIL_FROM = os.getenv("MAIL_FROM", MAIL_USERNAME)
MAIL_FROM_NAME = os.getenv("MAIL_FROM_NAME", "CODE")
MAIL_SERVER = os.getenv("MAIL_SERVER", "smtp.example.com")
MAIL_PORT = int(os.getenv("MAIL_PORT", 587))
MAIL_STARTTLS = os.getenv("MAIL_STARTTLS", "True") == "True"
MAIL_SSL_TLS = os.getenv("MAIL_SSL", "False") == "True"

# Vérification rapide
for var, value in [("MAIL_USERNAME", MAIL_USERNAME), ("MAIL_PASSWORD", MAIL_PASSWORD), ("MAIL_FROM", MAIL_FROM), ("MAIL_SERVER", MAIL_SERVER)]:
    if not value:
        print(f"⚠️  Variable {var} non définie")

# Configuration FastMail
conf = ConnectionConfig(
    MAIL_USERNAME=MAIL_USERNAME,
    MAIL_PASSWORD=MAIL_PASSWORD,
    MAIL_FROM=MAIL_FROM,
    MAIL_FROM_NAME=MAIL_FROM_NAME,
    MAIL_SERVER=MAIL_SERVER,
    MAIL_PORT=MAIL_PORT,
    MAIL_STARTTLS=MAIL_STARTTLS,
    MAIL_SSL_TLS=MAIL_SSL_TLS,
    USE_CREDENTIALS=True,
    VALIDATE_CERTS=True,
)

fm = FastMail(conf)

async def send_email(to: str, subject: str, body: str):
    message = MessageSchema(
        subject=subject,
        recipients=[to],
        body=body,
        subtype="plain",
    )
    await fm.send_message(message)

def send_email_sync(to: str, subject: str, body: str):
    loop = asyncio.get_event_loop()
    if loop.is_running():
        loop.create_task(send_email(to, subject, body))
    else:
        asyncio.run(send_email(to, subject, body))
