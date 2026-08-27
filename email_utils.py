# 📄 backend/email_utils.py
import os
import httpx
import base64
import asyncio

BREVO_API_KEY = os.getenv("BREVO_API_KEY")
MAIL_FROM = os.getenv("MAIL_FROM")
MAIL_FROM_NAME = os.getenv("MAIL_FROM_NAME", "CODE")


async def envoyer_email_resultat_async(nom, prenom, email_destinataire, niveau, pdf_base64):
    """
    Envoi du résultat de test avec pièce jointe PDF via l'API HTTP Brevo.
    """
    url = "https://api.brevo.com/v3/smtp/email"

    # Décode PDF base64 en bytes et encode en base64 pour API Brevo
    pdf_bytes = base64.b64decode(pdf_base64)
    pdf_b64_for_api = base64.b64encode(pdf_bytes).decode()

    payload = {
        "sender": {"name": MAIL_FROM_NAME, "email": MAIL_FROM},
        "to": [{"email": email_destinataire}],
        "subject": f"Résultat du test niveau {niveau}",
        "textContent": f"""
Bonjour {prenom},

Veuillez trouver ci-joint votre résultat au test de positionnement niveau {niveau}.

Cordialement,  
L’équipe CODE 🚀
        """,
        "attachment": [
            {
                "content": pdf_b64_for_api,
                "name": f"Resultat_{niveau}_{nom}.pdf",
                "type": "application/pdf"
            }
        ]
    }

    headers = {
        "accept": "application/json",
        "api-key": BREVO_API_KEY,
        "content-type": "application/json"
    }

    try:
        async with httpx.AsyncClient() as client:
            response = await client.post(url, json=payload, headers=headers)
            response.raise_for_status()
        print(f"✅ Email envoyé à {email_destinataire}")
        return True
    except Exception as e:
        print("❌ Erreur API Brevo:", e)
        return False


def envoyer_email_resultat(nom, prenom, email_destinataire, niveau, pdf_base64):
    """
    Version synchrone pour compatibilité avec routes FastAPI sync.
    """
    try:
        asyncio.run(envoyer_email_resultat_async(nom, prenom, email_destinataire, niveau, pdf_base64))
    except RuntimeError:
        # Cas où un event loop existe déjà
        asyncio.get_event_loop().create_task(
            envoyer_email_resultat_async(nom, prenom, email_destinataire, niveau, pdf_base64)
        )
    except Exception as e:
        print("❌ Erreur d'envoi email synchrone:", e)
