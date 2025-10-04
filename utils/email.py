import os
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig
import asyncio

MAIL_USERNAME = os.environ.get("MAIL_USERNAME")
MAIL_PASSWORD = os.environ.get("MAIL_PASSWORD")
MAIL_FROM = os.environ.get("MAIL_FROM")
MAIL_FROM_NAME = os.environ.get("MAIL_FROM_NAME")
MAIL_SERVER = os.environ.get("MAIL_SERVER")
MAIL_PORT = int(os.environ.get("MAIL_PORT", 465))
MAIL_STARTTLS = os.environ.get("MAIL_STARTTLS") == "True"
MAIL_SSL = os.environ.get("MAIL_SSL") == "True"

conf = ConnectionConfig(
    MAIL_USERNAME=MAIL_USERNAME,
    MAIL_PASSWORD=MAIL_PASSWORD,
    MAIL_FROM=MAIL_FROM,
    MAIL_FROM_NAME=MAIL_FROM_NAME,
    MAIL_SERVER=MAIL_SERVER,
    MAIL_PORT=MAIL_PORT,
    MAIL_STARTTLS=MAIL_STARTTLS,
    MAIL_SSL_TLS=MAIL_SSL,
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
