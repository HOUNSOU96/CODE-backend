import os
import asyncio
import httpx
from dotenv import load_dotenv

load_dotenv()

BREVO_API_KEY = os.getenv("BREVO_API_KEY")
MAIL_FROM = os.getenv("MAIL_FROM")
MAIL_FROM_NAME = os.getenv("MAIL_FROM_NAME", "CODE")


async def send_email(to: str, subject: str, body: str):
    if not BREVO_API_KEY:
        raise RuntimeError("BREVO_API_KEY n'est pas configurée.")

    if not MAIL_FROM:
        raise RuntimeError("MAIL_FROM n'est pas configurée.")

    url = "https://api.brevo.com/v3/smtp/email"

    payload = {
        "sender": {
            "name": MAIL_FROM_NAME,
            "email": MAIL_FROM,
        },
        "to": [
            {
                "email": to,
            }
        ],
        "subject": subject,
        "textContent": body,
    }

    headers = {
        "accept": "application/json",
        "api-key": BREVO_API_KEY,
        "content-type": "application/json",
    }

    async with httpx.AsyncClient() as client:
        response = await client.post(
            url,
            json=payload,
            headers=headers,
            timeout=30,
        )

        response.raise_for_status()

        return response.json()


def send_email_sync(
    to: str,
    subject: str,
    body: str,
):
    try:
        asyncio.run(
            send_email(
                to=to,
                subject=subject,
                body=body,
            )
        )

    except RuntimeError:
        try:
            loop = asyncio.get_event_loop()

            if loop.is_running():
                loop.create_task(
                    send_email(
                        to=to,
                        subject=subject,
                        body=body,
                    )
                )
            else:
                loop.run_until_complete(
                    send_email(
                        to=to,
                        subject=subject,
                        body=body,
                    )
                )

        except Exception as e:
            print(f"❌ Erreur d'envoi d'email : {e}")

    except Exception as e:
        print(f"❌ Erreur d'envoi d'email : {e}")