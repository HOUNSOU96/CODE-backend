from fastapi import APIRouter, UploadFile, Form
from fastapi.responses import JSONResponse
from typing import Annotated
import shutil
import os
import json
from backend.utils.email import fm, MessageSchema  # ✅ importer depuis utils/email.py

router = APIRouter()

@router.post("/api/send-result-pdf")
async def send_result_pdf(
    file: UploadFile,
    niveau: Annotated[str, Form()],
    apprenant: Annotated[str, Form()],
):
    try:
        apprenant_dict = json.loads(apprenant)

        # 📄 Sauvegarde temporaire du PDF
        temp_path = f"/tmp/{file.filename}"
        with open(temp_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        # 📧 Création du message avec pièce jointe
        subject = f"Résultat du test de positionnement - Niveau {niveau}"
        body = f"""
Bonjour {apprenant_dict.get('nom', 'apprenant')},

Voici ton résultat pour le test de niveau {niveau}.
Tu trouveras le rapport complet en pièce jointe.

L'équipe CODE 🚀
        """

        message = MessageSchema(
            subject=subject,
            recipients=[apprenant_dict.get("email")],
            body=body,
            subtype="plain",
            attachments=[temp_path],  # ✅ ajoute le PDF ici
        )

        await fm.send_message(message)
        os.remove(temp_path)  # ✅ Nettoyage du fichier temporaire

        print(f"✅ Mail envoyé à {apprenant_dict.get('email')} pour le niveau {niveau}")
        return JSONResponse(content={"message": "PDF envoyé par email avec succès."})

    except Exception as e:
        print(f"❌ Erreur envoi mail : {e}")
        return JSONResponse(status_code=500, content={"error": str(e)})
