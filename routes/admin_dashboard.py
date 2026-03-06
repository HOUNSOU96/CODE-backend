# backend/routes/admin_dashboard.py
from fastapi import APIRouter, Depends, HTTPException, Query
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from typing import List, Dict
from models.user import User
from models.connection_log import UserConnectionLog
from dependencies import get_current_user
from database import get_db

router = APIRouter(prefix="/api/admin_dashboard", tags=["admin_dashboard"])

# 🔹 Connexions par jour (7 derniers jours par défaut)
@router.get("/connexions-par-jour")
def connexions_par_jour(
    days: int = 7,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403, detail="Accès refusé")

    start_date = datetime.utcnow().date() - timedelta(days=days)
    query = (
        db.query(UserConnectionLog.date)
        .filter(UserConnectionLog.date >= start_date)
        .all()
    )

    counts: Dict[str, int] = {}
    for d, in query:
        day_str = d.strftime("%Y-%m-%d")
        counts[day_str] = counts.get(day_str, 0) + 1

    return counts


# 🔹 Connexions par heure (aujourd'hui par défaut)
@router.get("/connexions-par-heure")
def connexions_par_heure(
    date: str = None,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    if not date:
        date = datetime.utcnow().strftime("%Y-%m-%d")
    try:
        date_obj = datetime.strptime(date, "%Y-%m-%d").date()
    except:
        raise HTTPException(status_code=400, detail="Date invalide")

    query = db.query(UserConnectionLog.heure_connexion).filter(UserConnectionLog.date == date_obj).all()

    counts: Dict[str, int] = {}
    for h, in query:
        hour_str = h.strftime("%H")
        counts[hour_str] = counts.get(hour_str, 0) + 1

    return counts


# 🔹 Élèves connectés maintenant
@router.get("/eleves-en-ligne")
def eleves_en_ligne(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    threshold = datetime.utcnow() - timedelta(minutes=1)
    users = db.query(User).filter(User.last_seen >= threshold).all()
    return [{"id": u.id, "nom": u.nom, "prenom": u.prenom, "email": u.email} for u in users]


# 🔹 Temps moyen par élève (minutes)
@router.get("/temps-moyen-eleve")
def temps_moyen_eleve(
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    logs = db.query(UserConnectionLog).filter(UserConnectionLog.heure_deconnexion.isnot(None)).all()
    total_seconds = 0
    total_sessions = 0

    for log in logs:
        start = datetime.combine(log.date, log.heure_connexion)
        end = datetime.combine(log.date, log.heure_deconnexion)
        total_seconds += (end - start).total_seconds()
        total_sessions += 1

    avg_minutes = (total_seconds / total_sessions) / 60 if total_sessions else 0
    return {"avg_minutes": round(avg_minutes, 2)}


# 🔹 Élèves les plus actifs (triés par total minutes de connexion)
@router.get("/eleves-plus-actifs")
def eleves_plus_actifs(
    limit: int = 5,
    db: Session = Depends(get_db),
    current_user: User = Depends(get_current_user)
):
    if not current_user.is_admin:
        raise HTTPException(status_code=403)

    # Récupérer tous les logs terminés
    logs = db.query(
        UserConnectionLog.user_id,
        UserConnectionLog.date,
        UserConnectionLog.heure_connexion,
        UserConnectionLog.heure_deconnexion
    ).filter(UserConnectionLog.heure_deconnexion.isnot(None)).all()

    # Calcul du temps total par élève
    temps_par_eleve: Dict[int, int] = {}  # id -> minutes
    for log in logs:
        start = datetime.combine(log.date, log.heure_connexion)
        end = datetime.combine(log.date, log.heure_deconnexion)
        mins = (end - start).total_seconds() / 60
        temps_par_eleve[log.user_id] = temps_par_eleve.get(log.user_id, 0) + mins

    # Récupérer les infos élèves
    eleves = db.query(User).filter(User.id.in_(temps_par_eleve.keys())).all()

    # Préparer liste triée
    result = [
        {"id": u.id, "nom": u.nom, "prenom": u.prenom, "email": u.email, "total_minutes": round(temps_par_eleve[u.id])}
        for u in eleves
    ]
    result.sort(key=lambda x: x["total_minutes"], reverse=True)

    return result[:limit]