import asyncio
import base64
import os
from pathlib import Path

import httpx
from dotenv import load_dotenv


# Charge le .env du backend
load_dotenv(override=True)


BREVO_API_URL = "https://api.brevo.com/v3/smtp/email"


def _brevo_config():
    """
    Récupère et vérifie la configuration Brevo.
    """
    api_key = os.getenv("BREVO_API_KEY")
    mail_from = os.getenv("MAIL_FROM")
    mail_from_name = os.getenv("MAIL_FROM_NAME", "CODE")

    if not api_key:
        raise RuntimeError("BREVO_API_KEY n'est pas configurée.")

    if not mail_from:
        raise RuntimeError("MAIL_FROM n'est pas configurée.")

    return {
        "api_key": api_key,
        "mail_from": mail_from,
        "mail_from_name": mail_from_name,
    }


async def send_email(
    to: str,
    subject: str,
    body: str,
    html_body: str | None = None,
    attachments: list[dict] | None = None,
):
    """
    Envoie un email transactionnel via l'API HTTPS de Brevo.
    """

    config = _brevo_config()

    payload = {
        "sender": {
            "name": config["mail_from_name"],
            "email": config["mail_from"],
        },
        "to": [
            {
                "email": to,
            }
        ],
        "subject": subject,
        "textContent": body,
    }

    # Ajout du contenu HTML si fourni
    if html_body:
        payload["htmlContent"] = html_body

    # Ajout des pièces jointes si fournies
    if attachments:
        brevo_attachments = []

        for attachment in attachments:
            file_path = Path(attachment["path"])

            if not file_path.exists():
                raise FileNotFoundError(
                    f"Pièce jointe introuvable : {file_path}"
                )

            if not file_path.is_file():
                raise ValueError(
                    f"La pièce jointe n'est pas un fichier : {file_path}"
                )

            with file_path.open("rb") as file:
                encoded_content = base64.b64encode(
                    file.read()
                ).decode("utf-8")

            brevo_attachments.append(
                {
                    "name": attachment.get(
                        "name",
                        file_path.name,
                    ),
                    "content": encoded_content,
                }
            )

        payload["attachment"] = brevo_attachments

    headers = {
        "accept": "application/json",
        "api-key": config["api_key"],
        "content-type": "application/json",
    }

    # Timeout adapté à l'envoi de PDF volumineux
    timeout = httpx.Timeout(
        connect=20.0,
        read=60.0,
        write=300.0,
        pool=20.0,
    )

    async with httpx.AsyncClient(timeout=timeout) as client:
        response = await client.post(
            BREVO_API_URL,
            json=payload,
            headers=headers,
        )

        response.raise_for_status()

        return response.json()


def send_email_sync(
    to: str,
    subject: str,
    body: str,
    html_body: str | None = None,
    attachments: list[dict] | None = None,
):
    """
    Version synchrone du service d'envoi.
    """

    return asyncio.run(
        send_email(
            to=to,
            subject=subject,
            body=body,
            html_body=html_body,
            attachments=attachments,
        )
    )