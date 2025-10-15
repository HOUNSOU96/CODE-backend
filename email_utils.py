# 📄 backend/email_utils.py
import os
import smtplib
from email.message import EmailMessage
from dotenv import load_dotenv
import base64

load_dotenv()

def envoyer_email_resultat(nom, prenom, email_destinataire, niveau, pdf_base64):
    email_expediteur = os.getenv("MAIL_FROM")
    mdp = os.getenv("MAIL_PASSWORD")
    serveur_smtp = os.getenv("MAIL_SERVER", "smtp-relay.brevo.com")
    port_smtp = int(os.getenv("MAIL_PORT", 587))

    msg = EmailMessage()
    msg["Subject"] = f"Résultat du test niveau {niveau}"
    msg["From"] = email_expediteur
    msg["To"] = email_destinataire

    msg.set_content(f"""
Bonjour {prenom},

Veuillez trouver ci-joint votre résultat au test de positionnement niveau {niveau}.

Cordialement,  
L’équipe CODE 🚀
    """)

    # Décode PDF base64 en bytes
    pdf_bytes = base64.b64decode(pdf_base64)
    msg.add_attachment(pdf_bytes, maintype="application", subtype="pdf", filename=f"Resultat_{niveau}_{nom}.pdf")

    try:
        # ✅ Connexion via STARTTLS (Brevo)
        with smtplib.SMTP(serveur_smtp, port_smtp) as smtp:
            smtp.starttls()
            smtp.login(email_expediteur, mdp)
            smtp.send_message(msg)
        print(f"✅ Email envoyé à {email_destinataire}")
        return True
    except Exception as e:
        print("❌ Erreur SMTP:", e)
        return False
