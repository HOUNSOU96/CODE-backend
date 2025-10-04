# 📄 backend/email_utils.py
import os
import smtplib
from email.message import EmailMessage
from dotenv import load_dotenv
import base64

load_dotenv()

def envoyer_email_resultat(nom, prenom, email_destinataire, niveau, pdf_base64):
    email_expediteur = os.getenv("EMAIL_SENDER")
    mdp = os.getenv("EMAIL_PASSWORD")

    msg = EmailMessage()
    msg["Subject"] = f"Résultat du test niveau {niveau}"
    msg["From"] = email_expediteur
    msg["To"] = email_destinataire

    msg.set_content(f"Bonjour {prenom},\n\nVeuillez trouver ci-joint votre résultat au test de positionnement.\n\nCordialement.")

    # Décode PDF base64 en bytes
    pdf_bytes = base64.b64decode(pdf_base64)
    msg.add_attachment(pdf_bytes, maintype="application", subtype="pdf", filename=f"Resultat_{niveau}_{nom}.pdf")

    try:
        with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
            smtp.login(email_expediteur, mdp)
            smtp.send_message(msg)
        return True
    except Exception as e:
        print("Erreur SMTP:", e)
        return False
