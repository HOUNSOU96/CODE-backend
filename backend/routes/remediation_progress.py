from fastapi import APIRouter, Depends, HTTPException, Query, Request
from sqlalchemy.orm import Session
from routes.auth import get_current_user
from database import get_db
from schemas.remediation_progress import RemediationProgressCreate, RemediationProgressResponse
from crud import remediation_progress as crud

router = APIRouter(
    prefix="",
    tags=["Remediation"]
)

# --- Endpoints de progression ---

@router.post("/progress/update", response_model=RemediationProgressResponse)
def update_remediation_progress(
    progress: RemediationProgressCreate,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    return crud.create_or_update_progress(db, user.id, progress)


@router.get("/progress", response_model=RemediationProgressResponse)
def get_remediation_progress(
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    progresses = crud.get_progress_by_user_id(db, user.id)
    if not progresses:
        raise HTTPException(status_code=404, detail="Aucune progression trouvée.")
    return progresses[0]


# --- Vérification de progression ---
@router.get("/progress/check")
def check_progress(
    matiere: str,
    db: Session = Depends(get_db),
    user=Depends(get_current_user)
):
    progresses = crud.get_progress_by_user_id(db, user.id)
    progress = next((p for p in progresses if p.notion == matiere), None)
    if not progress:
        return {"test_termine": False, "last_video_id": None}

    return {
        "test_termine": progress.test_termine,
        "last_video_id": progress.video_actuelle_id if progress.test_termine else None
    }
