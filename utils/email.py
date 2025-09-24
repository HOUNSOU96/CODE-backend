# backend/utils/email.py
import os
from fastapi_mail import FastMail, MessageSchema, ConnectionConfig
from fastapi_mail.email_utils import DefaultChecker
from dotenv import load_dotenv
import asyncio
from typing import Dict
import smtplib
from email.mime.text import MIMEText
from pydantic import EmailStr
from pathlib import Path

load_dotenv()

conf = ConnectionConfig(
    MAIL_USERNAME=os.getenv("MAIL_USERNAME"),
    MAIL_PASSWORD=os.getenv("MAIL_PASSWORD"),
    MAIL_FROM=os.getenv("MAIL_FROM"),
    MAIL_FROM_NAME=os.getenv("MAIL_FROM_NAME"),
    MAIL_SERVER=os.getenv("MAIL_SERVER"),
    MAIL_PORT=int(os.getenv("MAIL_PORT")),
    MAIL_STARTTLS=os.getenv("MAIL_STARTTLS") == "True",  # False pour SSL
    MAIL_SSL_TLS=os.getenv("MAIL_SSL") == "True",        # utiliser MAIL_SSL pour indiquer SSL
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


