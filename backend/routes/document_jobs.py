import hmac
import os
from datetime import datetime
from pathlib import Path

from fastapi import APIRouter, Depends, File, Header, HTTPException, UploadFile
from sqlalchemy.orm import Session

from database import get_db
from models.document_generation_job import DocumentGenerationJob
from models.document_activation import DocumentActivation
from models.user import User, UserStatus
from models.user_device import UserDevice
from models.document_device_access import DocumentDeviceAccess

router = APIRouter(tags=["document-generation-jobs"])

BACKEND_DIR = Path(__file__).resolve().parent.parent
SECURE_DOCUMENTS_DIR = BACKEND_DIR / "secure_documents"
MAX_PDF_SIZE = 30 * 1024 * 1024


def require_worker_key(key: str | None):
    expected = os.getenv("CODE_WORKER_KEY", "")
    if not expected or not key or not hmac.compare_digest(key, expected):
        raise HTTPException(status_code=401, detail="WORKER_UNAUTHORIZED")


def get_job_or_404(db: Session, job_id: str):
    job = db.query(DocumentGenerationJob).filter(
        DocumentGenerationJob.id == job_id
    ).first()
    if not job:
        raise HTTPException(status_code=404, detail="JOB_NOT_FOUND")
    return job


@router.get("/api/internal/document-jobs/{job_id}/payload")
def get_job_payload(
    job_id: str,
    x_code_worker_key: str | None = Header(None, alias="X-CODE-WORKER-KEY"),
    db: Session = Depends(get_db),
):
    require_worker_key(x_code_worker_key)
    job = get_job_or_404(db, job_id)

    if job.status in ("completed", "failed"):
        raise HTTPException(status_code=409, detail="JOB_ALREADY_FINISHED")

    payload = job.payload or {}
    generator = payload.get("generator")
    if not isinstance(generator, dict):
        raise HTTPException(status_code=500, detail="JOB_PAYLOAD_INVALID")

    job.status = "running"
    job.updated_at = datetime.utcnow()
    db.commit()

    # Ne jamais transmettre les métadonnées de finalisation au générateur.
    return generator


@router.post("/api/internal/document-jobs/{job_id}/complete")
async def complete_job(
    job_id: str,
    pdf: UploadFile = File(...),
    x_code_worker_key: str | None = Header(None, alias="X-CODE-WORKER-KEY"),
    db: Session = Depends(get_db),
):
    require_worker_key(x_code_worker_key)
    job = get_job_or_404(db, job_id)

    if job.status == "completed":
        return {
            "success": True,
            "status": "completed",
            "activation_id": job.activation_id,
        }

    if job.status == "failed":
        raise HTTPException(status_code=409, detail="JOB_ALREADY_FAILED")

    pdf_bytes = await pdf.read(MAX_PDF_SIZE + 1)
    if len(pdf_bytes) > MAX_PDF_SIZE:
        raise HTTPException(status_code=413, detail="PDF_TOO_LARGE")

    if len(pdf_bytes) < 5 or not pdf_bytes.startswith(b"%PDF-"):
        raise HTTPException(status_code=400, detail="PDF_INVALID")

    payload = job.payload or {}
    metadata = payload.get("finalization")
    if not isinstance(metadata, dict):
        raise HTTPException(status_code=500, detail="JOB_METADATA_INVALID")

    activation = (
        db.query(DocumentActivation)
        .filter(DocumentActivation.id == job.activation_id)
        .with_for_update()
        .first()
    )
    if not activation:
        raise HTTPException(status_code=404, detail="ACTIVATION_NOT_FOUND")

    if activation.is_activated:
        raise HTTPException(status_code=409, detail="DOCUMENT_ALREADY_ACTIVATED")

    email = metadata.get("beneficiary_email", "").strip().lower()
    device_id = metadata.get("device_id", "")
    device_type = metadata.get("device_type", "unknown")
    activation_type = metadata.get("activation_type", "self")
    filename = Path(metadata.get("document_filename", "document-personnalise.pdf")).name

    if not email or not device_id or len(device_id) > 255:
        raise HTTPException(status_code=400, detail="JOB_METADATA_INVALID")

    user = db.query(User).filter(User.email.ilike(email)).first()

    if user is None:
        hashed_password = metadata.get("hashed_password")
        nom = metadata.get("nom", "")
        prenom = metadata.get("prenom", "")
        pays = metadata.get("pays_residence", "")

        if not all((hashed_password, nom, prenom, pays)):
            raise HTTPException(status_code=400, detail="ACCOUNT_DATA_MISSING")

        user = User(
            nom=nom,
            prenom=prenom,
            email=email,
            telephone=metadata.get("telephone") or None,
            pays_residence=pays,
            hashed_password=hashed_password,
            is_validated=True,
            is_active=True,
            is_blocked=False,
            is_admin=False,
            is_verified=False,
            status=UserStatus.VALIDATED.value,
            date_inscription=datetime.utcnow(),
            created_at=datetime.utcnow(),
        )
        db.add(user)
        db.flush()

    now = datetime.utcnow()
    device = db.query(UserDevice).filter(
        UserDevice.device_id == device_id
    ).first()

    if device and device.user_id != user.id:
        raise HTTPException(status_code=409, detail="DEVICE_ALREADY_ASSOCIATED")

    if not device:
        device = UserDevice(
            user_id=user.id,
            device_id=device_id,
            device_type=device_type,
            is_mobile=device_type in ("mobile", "tablet"),
            is_active=True,
            created_at=now,
            last_seen=now,
        )
        db.add(device)
        db.flush()
    else:
        device.is_active = True
        device.last_seen = now
        device.device_type = device_type
        device.is_mobile = device_type in ("mobile", "tablet")

    directory = SECURE_DOCUMENTS_DIR / str(activation.id)
    directory.mkdir(parents=True, exist_ok=True)
    destination = directory / filename

    try:
        with destination.open("wb") as output:
            output.write(pdf_bytes)

        if not destination.is_file() or destination.stat().st_size == 0:
            raise HTTPException(status_code=500, detail="SECURE_PDF_STORAGE_FAILED")

        activation.user_id = user.id
        activation.pdf_path = str(destination.relative_to(BACKEND_DIR))
        activation.pdf_data = None
        activation.pdf_filename = filename
        activation.activation_type = activation_type
        activation.beneficiary_email = email
        activation.is_activated = True
        activation.activated_at = now

        access = db.query(DocumentDeviceAccess).filter(
            DocumentDeviceAccess.activation_id == activation.id,
            DocumentDeviceAccess.device_id == device.id,
        ).first()

        if access is None:
            access = DocumentDeviceAccess(
                activation_id=activation.id,
                user_id=user.id,
                device_id=device.id,
                is_active=True,
                activated_at=now,
                last_access=now,
                last_version=1,
            )
            db.add(access)
        else:
            access.user_id = user.id
            access.is_active = True
            access.last_access = now
            access.last_version = 1

        job.status = "completed"
        job.pdf_path = activation.pdf_path
        job.error_code = None
        job.completed_at = now
        job.updated_at = now

        db.commit()

    except Exception:
        db.rollback()
        try:
            if destination.exists():
                destination.unlink()
        except OSError:
            pass
        raise

    return {
        "success": True,
        "status": "completed",
        "activation_id": activation.id,
    }


@router.post("/api/internal/document-jobs/{job_id}/fail")
def fail_job(
    job_id: str,
    body: dict,
    x_code_worker_key: str | None = Header(None, alias="X-CODE-WORKER-KEY"),
    db: Session = Depends(get_db),
):
    require_worker_key(x_code_worker_key)
    job = get_job_or_404(db, job_id)

    if job.status == "completed":
        return {"success": True, "status": "completed"}

    # Ne pas stocker de messages arbitraires ou de données personnelles dans les logs.
    allowed_errors = {
        "PDF_GENERATION_FAILED",
        "PDF_GENERATION_TIMEOUT",
        "PDF_GENERATION_INVALID",
    }
    error_code = body.get("error_code", "PDF_GENERATION_FAILED")
    if error_code not in allowed_errors:
        error_code = "PDF_GENERATION_FAILED"

    job.status = "failed"
    job.error_code = error_code
    job.updated_at = datetime.utcnow()
    job.completed_at = datetime.utcnow()
    db.commit()

    return {"success": True, "status": "failed"}
