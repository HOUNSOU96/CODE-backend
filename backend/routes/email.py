from fastapi import APIRouter, UploadFile, Form
from fastapi.responses import JSONResponse
from typing import Annotated
import shutil
import tempfile
import os
import json

from utils.email import send_email


router = APIRouter()


@router.post("/api/send-result-pdf")
async def send_result_pdf(
    file: UploadFile,
    niveau: Annotated[str, Form()],
    apprenant: Annotated[str, Form()],
):
    try:
        apprenant_dict = json.loads(apprenant)
        recipient = apprenant_dict.get("email")

        if not recipient:
            return JSONResponse(
                status_code=400,
                content={"error": "Adresse email non fournie"},
            )

        temp_path = None

        try:
            # Création du fichier temporaire pour le PDF
            with tempfile.NamedTemporaryFile(
                delete=False,
                suffix=".pdf",
            ) as tmp:
                shutil.copyfileobj(file.file, tmp)
                temp_path = tmp.name

            nom_apprenant = apprenant_dict.get(
                "nom",
                "apprenant",
            )

            subject = (
                f"Résultat du test de positionnement - "
                f"Niveau {niveau}"
            )

            body = f"""
Bonjour {nom_apprenant},

Voici ton résultat pour l'évaluation diagnostique
de la classe de {niveau}.

Tu trouveras le rapport complet en pièce jointe.

L'équipe CODE 🚀
"""

            html_body = f"""
<html>
  <body style="font-family: Arial, sans-serif;">
    <h2>Résultat du test de positionnement</h2>

    <p>Bonjour <strong>{nom_apprenant}</strong>,</p>

    <p>
      Voici ton résultat pour l'évaluation diagnostique
      de la classe de <strong>{niveau}</strong>.
    </p>

    <p>
      Tu trouveras le rapport complet en pièce jointe.
    </p>

    <p>
      Bonne continuation dans tes apprentissages !
    </p>

    <p>
      L'équipe <strong>CODE</strong> 🚀
    </p>
  </body>
</html>
"""

            # Envoi via l'API Brevo centralisée
            await send_email(
                to=recipient,
                subject=subject,
                body=body,
                html_body=html_body,
                attachments=[
                    {
                        "path": temp_path,
                        "name": file.filename or "resultat-code.pdf",
                    }
                ],
            )

            print(
                f"✅ Mail Brevo envoyé à {recipient} "
                f"pour le niveau {niveau}"
            )

            return JSONResponse(
                content={
                    "message": "PDF envoyé par email avec succès."
                }
            )

        except Exception as e:
            print(f"❌ Erreur Brevo : {e}")

            return JSONResponse(
                status_code=500,
                content={"error": str(e)},
            )

        finally:
            if temp_path and os.path.exists(temp_path):
                os.remove(temp_path)

    except Exception as e:
        print(f"❌ Erreur envoi mail : {e}")

        return JSONResponse(
            status_code=500,
            content={"error": str(e)},
        )
