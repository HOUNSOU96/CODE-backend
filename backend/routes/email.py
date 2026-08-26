from fastapi import APIRouter, UploadFile, Form
from fastapi.responses import JSONResponse
from typing import Annotated
import shutil
import tempfile
import os
import json
from backend.utils.email import fm, MessageSchema

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
            return JSONResponse(status_code=400, content={"error": "Adresse email non fournie"})

        temp_path = None
        try:
            # 🔹 Création du fichier temporaire pour le PDF
            with tempfile.NamedTemporaryFile(delete=False, suffix=".pdf") as tmp:
                shutil.copyfileobj(file.file, tmp)
                temp_path = tmp.name

            # 📧 Création du message avec pièce jointe
            subject = f"Résultat du test de positionnement - Niveau {niveau}"
            body = f"""
Bonjour {apprenant_dict.get('nom', 'apprenant')},

Voici ton résultat pour l'évaluation diagnostique de la classe de {niveau}.
Tu trouveras le rapport complet en pièce jointe.

L'équipe CODE 🚀
            """

            message = MessageSchema(
                subject=subject,
                recipients=[recipient],
                body=body,
                subtype="mixed",
                attachments=[temp_path],  # ou [{"file": temp_path, "filename": file.filename, "type": "application/pdf"}]
            )

            await fm.send_message(message)
            print(f"✅ Mail envoyé à {recipient} pour le niveau {niveau}")
            return JSONResponse(content={"message": "PDF envoyé par email avec succès."})

        except Exception as e:
            print(f"❌ Erreur SMTP : {e}")
            return JSONResponse(status_code=500, content={"error": str(e)})

        finally:
            if temp_path and os.path.exists(temp_path):
                os.remove(temp_path)

    except Exception as e:
        print(f"❌ Erreur envoi mail : {e}")
        return JSONResponse(status_code=500, content={"error": str(e)})
