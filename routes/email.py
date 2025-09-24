from fastapi import APIRouter, UploadFile, Form
from fastapi.responses import JSONResponse
from typing import Annotated
import shutil
import os
from backend.utils.email import send_email_with_pdf

router = APIRouter()

@router.post("/api/send-result-pdf")
async def send_result_pdf(
    file: UploadFile,
    niveau: Annotated[str, Form()],
    apprenant: Annotated[str, Form()],
):
    try:
        import json
        apprenant_dict = json.loads(apprenant)

        temp_path = f"/tmp/{file.filename}"
        with open(temp_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        await send_email_with_pdf(apprenant=apprenant_dict, niveau=niveau, pdf_path=temp_path)

        return JSONResponse(content={"message": "PDF envoyé par email avec succès."})
    except Exception as e:
        print(f"Erreur envoi mail : {e}")
        return JSONResponse(status_code=500, content={"error": str(e)})
