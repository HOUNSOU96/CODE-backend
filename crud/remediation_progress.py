from sqlalchemy.orm import Session
from models.remediation_progress import RemediationProgress
from schemas.remediation_progress import RemediationProgressCreate

def get_progress_by_user_id(db: Session, user_id: int):
    """
    Retourne toutes les progressions d'un utilisateur.
    """
    return db.query(RemediationProgress).filter(RemediationProgress.user_id == user_id).all()

def get_remediation_progress(db: Session, user_id: int, notion: str, niveau: str):
    """
    Retourne une progression spécifique par notion et niveau pour un utilisateur.
    """
    return (
        db.query(RemediationProgress)
        .filter_by(user_id=user_id, notion=notion, niveau=niveau)
        .first()
    )

def create_remediation_progress(db: Session, user_id: int, progress: RemediationProgressCreate):
    """
    Crée une nouvelle progression pour un utilisateur.
    """
    db_progress = RemediationProgress(user_id=user_id, **progress.dict())
    db.add(db_progress)
    db.commit()
    db.refresh(db_progress)
    return db_progress

def update_remediation_progress(db: Session, user_id: int, progress: RemediationProgressCreate):
    """
    Met à jour une progression existante.
    """
    existing = get_remediation_progress(db, user_id, progress.notion, progress.niveau)
    if existing:
        existing.statut = progress.statut
        existing.video_actuelle_id = progress.video_actuelle_id
        existing.test_score = progress.test_score
        existing.test_termine = progress.test_termine
        db.commit()
        db.refresh(existing)
        return existing
    else:
        return create_remediation_progress(db, user_id, progress)

def create_or_update_progress(db: Session, user_id: int, progress: RemediationProgressCreate):
    """
    Crée ou met à jour la progression selon l'existence.
    """
    existing = get_remediation_progress(db, user_id, progress.notion, progress.niveau)
    if existing:
        return update_remediation_progress(db, user_id, progress)
    return create_remediation_progress(db, user_id, progress)
