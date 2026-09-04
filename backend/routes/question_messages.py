from datetime import datetime, timedelta
from typing import List

from fastapi import APIRouter, BackgroundTasks, Depends, HTTPException
from sqlalchemy.orm import Session

from database import get_db
from dependencies import get_current_user
from models.user import User
from models.teacher_subject import TeacherSubject
from models.user_question import UserQuestion
from models.question_message import QuestionMessage
from schemas.question import (
    QuestionCreate,
    MessageCreate,
    QuestionResponse,
    AdminQuestionResponse,
    TeacherQuestionResponse,
    TeacherResponse,
    TeacherSubjectsUpdate,
    MessageResponse,
    AdminTeacherConversationResponse,
    AdminTeacherConversationListResponse,
)
from utils.email import send_email_sync


router = APIRouter(
    prefix="/api",
    tags=["Questions et enseignants"],
)


# ============================================================
# CONSTANTES
# ============================================================

QUESTION_EXPIRATION_DAYS = 7

QUESTION_STATUSES = {
    "waiting",
    "in_progress",
    "answered",
    "expired",
}


# ============================================================
# UTILITAIRES
# ============================================================

def require_admin(current_user: User):
    """Vérifie que l'utilisateur est administrateur."""
    if not current_user.is_admin:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux administrateurs.",
        )


def require_teacher(current_user: User):
    """Vérifie que l'utilisateur est un enseignant actif."""
    if not current_user.enseignant or not current_user.enseignant_actif:
        raise HTTPException(
            status_code=403,
            detail="Accès réservé aux enseignants actifs.",
        )


def cleanup_expired_questions(db: Session):
    """
    Supprime les conversations dont la durée de vie est dépassée.

    La suppression entraîne également la suppression des messages
    grâce au cascade configuré sur UserQuestion.messages.
    """
    now = datetime.utcnow()

    expired_questions = (
        db.query(UserQuestion)
        .filter(UserQuestion.expires_at <= now)
        .all()
    )

    if not expired_questions:
        return

    for question in expired_questions:
        db.delete(question)

    db.commit()


def question_to_response(question: UserQuestion) -> QuestionResponse:
    """Transforme une question en réponse destinée à son propriétaire."""

    return QuestionResponse(
        id=question.id,
        recipient_type=question.recipient_type,
        subject=question.subject,
        is_learner=question.is_learner,
        learner_class=question.learner_class,
        title=question.title,
        content=question.content,
        status=question.status,
        created_at=question.created_at,
        expires_at=question.expires_at,
        updated_at=question.updated_at,
        messages=[
            MessageResponse(
                id=message.id,
                sender_role=message.sender_role,
                content=message.content,
                created_at=message.created_at,
            )
            for message in question.messages
        ],
    )


def teacher_question_to_response(
    question: UserQuestion,
) -> TeacherQuestionResponse:
    """
    Réponse destinée à un enseignant.

    IMPORTANT :
    aucune donnée permettant d'identifier l'apprenant
    n'est renvoyée.
    """

    return TeacherQuestionResponse(
        id=question.id,
        recipient_type=question.recipient_type,
        subject=question.subject,
        is_learner=question.is_learner,
        learner_class=question.learner_class,
        title=question.title,
        content=question.content,
        status=question.status,
        created_at=question.created_at,
        expires_at=question.expires_at,
        updated_at=question.updated_at,
        messages=[
            MessageResponse(
                id=message.id,
                sender_role=message.sender_role,
                content=message.content,
                created_at=message.created_at,
            )
            for message in question.messages
        ],
    )


def admin_question_to_response(
    question: UserQuestion,
) -> AdminQuestionResponse:
    """Réponse complète destinée à un administrateur."""

    return AdminQuestionResponse(
        id=question.id,
        user_id=question.user_id,
        user_nom=question.user.nom,
        user_prenom=question.user.prenom,
        user_email=question.user.email,
        recipient_type=question.recipient_type,
        subject=question.subject,
        is_learner=question.is_learner,
        learner_class=question.learner_class,
        title=question.title,
        content=question.content,
        status=question.status,
        created_at=question.created_at,
        expires_at=question.expires_at,
        updated_at=question.updated_at,
        messages=[
            MessageResponse(
                id=message.id,
                sender_role=message.sender_role,
                content=message.content,
                created_at=message.created_at,
            )
            for message in question.messages
        ],
    )


def notify_admins(
    db: Session,
    background_tasks: BackgroundTasks,
    question: UserQuestion,
):
    """Notifie tous les administrateurs."""

    admins = (
        db.query(User)
        .filter(
            User.is_admin == True,
            User.is_active == True,
            User.is_blocked == False,
        )
        .all()
    )

    for admin in admins:
        body = (
            "Bonjour,\n\n"
            "Une nouvelle question vient d'être reçue sur CODE.\n\n"
            f"Objet : {question.title}\n"
            f"Type de destinataire : {question.recipient_type}\n"
            f"Matière : {question.subject or 'Non précisée'}\n\n"
            "Connectez-vous à l'espace administrateur de CODE "
            "pour consulter et traiter cette question.\n"
        )

        background_tasks.add_task(
            send_email_sync,
            admin.email,
            f"[CODE] Nouvelle question : {question.title}",
            body,
        )


def notify_teachers(
    db: Session,
    background_tasks: BackgroundTasks,
    question: UserQuestion,
):
    """Notifie les enseignants actifs de la matière concernée."""

    if not question.subject:
        return

    teachers = (
        db.query(User)
        .join(
            TeacherSubject,
            TeacherSubject.teacher_id == User.id,
        )
        .filter(
            User.enseignant == True,
            User.enseignant_actif == True,
            User.is_active == True,
            User.is_blocked == False,
            TeacherSubject.subject == question.subject,
        )
        .all()
    )

    # Évite les doublons si une anomalie existe dans les données.
    teacher_emails = set()

    for teacher in teachers:
        if teacher.email in teacher_emails:
            continue

        teacher_emails.add(teacher.email)

        body = (
            "Bonjour,\n\n"
            "Une nouvelle question concernant votre matière "
            "vient d'être publiée sur CODE.\n\n"
            f"Matière : {question.subject}\n"
            f"Classe : {question.learner_class or 'Non précisée'}\n"
            f"Objet : {question.title}\n\n"
            "Connectez-vous à votre espace enseignant CODE "
            "pour consulter la question et y répondre.\n\n"
            "Pour des raisons de confidentialité, l'identité "
            "de l'apprenant n'est pas communiquée aux enseignants.\n"
        )

        background_tasks.add_task(
            send_email_sync,
            teacher.email,
            f"[CODE] Nouvelle question - {question.subject}",
            body,
        )


# ============================================================
# ESPACE UTILISATEUR
# ============================================================

@router.post(
    "/questions",
    response_model=QuestionResponse,
)
def create_question(
    payload: QuestionCreate,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Crée une nouvelle question.

    recipient_type :
        - admin
        - subject
    """

    cleanup_expired_questions(db)

    recipient_type = payload.recipient_type.strip().lower()

    if recipient_type not in {"admin", "subject"}:
        raise HTTPException(
            status_code=400,
            detail="Le destinataire doit être 'admin' ou 'subject'.",
        )

    subject = payload.subject.strip() if payload.subject else None
    learner_class = (
        payload.learner_class.strip()
        if payload.learner_class
        else None
    )

    # --------------------------------------------------------
    # Vérification du destinataire
    # --------------------------------------------------------

    if recipient_type == "admin":
        subject = None

    if recipient_type == "subject":
        if not subject:
            raise HTTPException(
                status_code=400,
                detail="Une matière est obligatoire.",
            )

        teacher_exists = (
            db.query(TeacherSubject)
            .join(User, User.id == TeacherSubject.teacher_id)
            .filter(
                TeacherSubject.subject == subject,
                User.enseignant == True,
                User.enseignant_actif == True,
                User.is_active == True,
                User.is_blocked == False,
            )
            .first()
        )

        if not teacher_exists:
            raise HTTPException(
                status_code=404,
                detail=(
                    "Aucun enseignant actif n'est actuellement "
                    "disponible pour cette matière."
                ),
            )

    # --------------------------------------------------------
    # Vérification apprenant / classe
    # --------------------------------------------------------

    if payload.is_learner and not learner_class:
        raise HTTPException(
            status_code=400,
            detail="La classe est obligatoire pour un apprenant.",
        )

    if not payload.is_learner:
        learner_class = None

    now = datetime.utcnow()
    expires_at = now + timedelta(days=QUESTION_EXPIRATION_DAYS)

    question = UserQuestion(
        user_id=current_user.id,
        recipient_type=recipient_type,
        subject=subject,
        is_learner=payload.is_learner,
        learner_class=learner_class,
        title=payload.title.strip(),
        content=payload.content.strip(),
        status="waiting",
        expires_at=expires_at,
    )

    db.add(question)
    db.commit()
    db.refresh(question)

    # --------------------------------------------------------
    # Message initial
    # --------------------------------------------------------

    initial_message = QuestionMessage(
        question_id=question.id,
        sender_id=current_user.id,
        sender_role="user",
        content=payload.content.strip(),
    )

    db.add(initial_message)
    db.commit()
    db.refresh(question)

    # --------------------------------------------------------
    # Notifications
    # --------------------------------------------------------

    if recipient_type == "admin":
        notify_admins(
            db,
            background_tasks,
            question,
        )
    else:
        # Les administrateurs doivent également être informés.
        notify_admins(
            db,
            background_tasks,
            question,
        )

        # Puis les enseignants de la matière.
        notify_teachers(
            db,
            background_tasks,
            question,
        )

    return question_to_response(question)


@router.get(
    "/questions/my",
    response_model=List[QuestionResponse],
)
def get_my_questions(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Retourne les conversations de l'utilisateur connecté."""

    cleanup_expired_questions(db)

    questions = (
        db.query(UserQuestion)
        .filter(UserQuestion.user_id == current_user.id)
        .order_by(UserQuestion.created_at.desc())
        .all()
    )

    return [
        question_to_response(question)
        for question in questions
    ]


@router.get(
    "/questions/{question_id}",
    response_model=QuestionResponse,
)
def get_my_question(
    question_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Retourne une conversation appartenant à l'utilisateur."""

    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.id == question_id,
            UserQuestion.user_id == current_user.id,
        )
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    return question_to_response(question)


@router.post(
    "/questions/{question_id}/messages",
    response_model=MessageResponse,
)
def add_user_message(
    question_id: int,
    payload: MessageCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Permet à l'utilisateur de poursuivre sa conversation."""

    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.id == question_id,
            UserQuestion.user_id == current_user.id,
        )
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    if question.expires_at <= datetime.utcnow():
        raise HTTPException(
            status_code=410,
            detail="Cette conversation a expiré.",
        )

    if question.status == "expired":
        raise HTTPException(
            status_code=410,
            detail="Cette conversation a expiré.",
        )

    message = QuestionMessage(
        question_id=question.id,
        sender_id=current_user.id,
        sender_role="user",
        content=payload.content.strip(),
    )

    question.status = "waiting"

    db.add(message)
    db.commit()
    db.refresh(message)

    return MessageResponse(
        id=message.id,
        sender_role=message.sender_role,
        content=message.content,
        created_at=message.created_at,
    )


# ============================================================
# ESPACE ADMINISTRATEUR
# ============================================================

@router.get(
    "/admin/questions",
    response_model=List[AdminQuestionResponse],
)
def admin_get_questions(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Toutes les questions visibles par les administrateurs."""

    require_admin(current_user)
    cleanup_expired_questions(db)

    questions = (
        db.query(UserQuestion)
        .order_by(UserQuestion.created_at.desc())
        .all()
    )

    return [
        admin_question_to_response(question)
        for question in questions
    ]


@router.get(
    "/admin/questions/{question_id}",
    response_model=AdminQuestionResponse,
)
def admin_get_question(
    question_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    require_admin(current_user)
    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(UserQuestion.id == question_id)
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    return admin_question_to_response(question)


@router.post(
    "/admin/questions/{question_id}/messages",
    response_model=MessageResponse,
)
def admin_add_message(
    question_id: int,
    payload: MessageCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Réponse d'un administrateur."""

    require_admin(current_user)
    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(UserQuestion.id == question_id)
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    message = QuestionMessage(
        question_id=question.id,
        sender_id=current_user.id,
        sender_role="admin",
        content=payload.content.strip(),
    )

    question.status = "answered"

    db.add(message)
    db.commit()
    db.refresh(message)

    return MessageResponse(
        id=message.id,
        sender_role=message.sender_role,
        content=message.content,
        created_at=message.created_at,
    )


# ============================================================
# ESPACE ENSEIGNANT
# ============================================================

def teacher_has_subject(
    db: Session,
    teacher_id: int,
    subject: str,
) -> bool:
    """Vérifie qu'un enseignant possède cette matière."""

    return (
        db.query(TeacherSubject)
        .filter(
            TeacherSubject.teacher_id == teacher_id,
            TeacherSubject.subject == subject,
        )
        .first()
        is not None
    )


@router.get(
    "/teacher/questions",
    response_model=List[TeacherQuestionResponse],
)
def teacher_get_questions(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retourne uniquement les questions des matières
    de l'enseignant connecté.
    """

    require_teacher(current_user)
    cleanup_expired_questions(db)

    subjects = [
        row.subject
        for row in (
            db.query(TeacherSubject)
            .filter(
                TeacherSubject.teacher_id == current_user.id
            )
            .all()
        )
    ]

    if not subjects:
        return []

    questions = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.recipient_type == "subject",
            UserQuestion.subject.in_(subjects),
        )
        .order_by(UserQuestion.created_at.desc())
        .all()
    )

    return [
        teacher_question_to_response(question)
        for question in questions
    ]


@router.get(
    "/teacher/questions/{question_id}",
    response_model=TeacherQuestionResponse,
)
def teacher_get_question(
    question_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Consulte une question appartenant à une matière de l'enseignant."""

    require_teacher(current_user)
    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(UserQuestion.id == question_id)
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    if question.recipient_type != "subject":
        raise HTTPException(
            status_code=403,
            detail="Cette question n'est pas destinée aux enseignants.",
        )

    if not teacher_has_subject(
        db,
        current_user.id,
        question.subject,
    ):
        raise HTTPException(
            status_code=403,
            detail="Vous n'êtes pas autorisé à consulter cette question.",
        )

    return teacher_question_to_response(question)


@router.post(
    "/teacher/questions/{question_id}/messages",
    response_model=MessageResponse,
)
def teacher_add_message(
    question_id: int,
    payload: MessageCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Réponse d'un enseignant."""

    require_teacher(current_user)
    cleanup_expired_questions(db)

    question = (
        db.query(UserQuestion)
        .filter(UserQuestion.id == question_id)
        .first()
    )

    if not question:
        raise HTTPException(
            status_code=404,
            detail="Question introuvable.",
        )

    if question.recipient_type != "subject":
        raise HTTPException(
            status_code=403,
            detail="Cette question n'est pas destinée aux enseignants.",
        )

    if not teacher_has_subject(
        db,
        current_user.id,
        question.subject,
    ):
        raise HTTPException(
            status_code=403,
            detail="Vous n'êtes pas autorisé à répondre à cette question.",
        )

    message = QuestionMessage(
        question_id=question.id,
        sender_id=current_user.id,
        sender_role="teacher",
        content=payload.content.strip(),
    )

    question.status = "answered"

    db.add(message)
    db.commit()
    db.refresh(message)

    return MessageResponse(
        id=message.id,
        sender_role=message.sender_role,
        content=message.content,
        created_at=message.created_at,
    )


# ============================================================
# MATIÈRES DISPONIBLES
# ============================================================

@router.get(
    "/teacher/subjects",
    response_model=List[str],
)
def get_teacher_subjects(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Matières auxquelles l'enseignant connecté est actuellement associé.
    """

    require_teacher(current_user)

    subjects = (
        db.query(TeacherSubject.subject)
        .filter(
            TeacherSubject.teacher_id == current_user.id
        )
        .order_by(TeacherSubject.subject.asc())
        .all()
    )

    return [subject[0] for subject in subjects]


# ============================================================
# ADMIN : GESTION DES ENSEIGNANTS
# ============================================================

@router.get(
    "/admin/teachers",
    response_model=List[TeacherResponse],
)
def admin_get_teachers(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Liste de tous les enseignants."""

    require_admin(current_user)

    teachers = (
        db.query(User)
        .filter(User.enseignant == True)
        .order_by(User.nom.asc(), User.prenom.asc())
        .all()
    )

    result = []

    for teacher in teachers:
        subjects = (
            db.query(TeacherSubject.subject)
            .filter(
                TeacherSubject.teacher_id == teacher.id
            )
            .order_by(TeacherSubject.subject.asc())
            .all()
        )

        result.append(
            TeacherResponse(
                id=teacher.id,
                nom=teacher.nom,
                prenom=teacher.prenom,
                email=teacher.email,
                enseignant=teacher.enseignant,
                enseignant_actif=teacher.enseignant_actif,
                subjects=[subject[0] for subject in subjects],
            )
        )

    return result


@router.post(
    "/admin/teachers/{user_id}",
    response_model=TeacherResponse,
)
def admin_activate_teacher(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Active le statut enseignant d'un utilisateur.
    """

    require_admin(current_user)

    teacher = (
        db.query(User)
        .filter(User.id == user_id)
        .first()
    )

    if not teacher:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable.",
        )

    teacher.enseignant = True
    teacher.enseignant_actif = True

    db.commit()
    db.refresh(teacher)

    subjects = (
        db.query(TeacherSubject.subject)
        .filter(
            TeacherSubject.teacher_id == teacher.id
        )
        .order_by(TeacherSubject.subject.asc())
        .all()
    )

    return TeacherResponse(
        id=teacher.id,
        nom=teacher.nom,
        prenom=teacher.prenom,
        email=teacher.email,
        enseignant=teacher.enseignant,
        enseignant_actif=teacher.enseignant_actif,
        subjects=[subject[0] for subject in subjects],
    )


@router.put(
    "/admin/teachers/{user_id}/subjects",
    response_model=TeacherResponse,
)
def admin_update_teacher_subjects(
    user_id: int,
    payload: TeacherSubjectsUpdate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """Remplace complètement les matières d'un enseignant."""

    require_admin(current_user)

    teacher = (
        db.query(User)
        .filter(User.id == user_id)
        .first()
    )

    if not teacher:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable.",
        )

    if not teacher.enseignant:
        raise HTTPException(
            status_code=400,
            detail="Cet utilisateur n'est pas encore enseignant.",
        )

    cleaned_subjects = sorted(
        {
            subject.strip()
            for subject in payload.subjects
            if subject and subject.strip()
        }
    )

    existing = (
        db.query(TeacherSubject)
        .filter(
            TeacherSubject.teacher_id == teacher.id
        )
        .all()
    )

    for row in existing:
        db.delete(row)

    db.flush()

    for subject in cleaned_subjects:
        db.add(
            TeacherSubject(
                teacher_id=teacher.id,
                subject=subject,
            )
        )

    db.commit()

    return TeacherResponse(
        id=teacher.id,
        nom=teacher.nom,
        prenom=teacher.prenom,
        email=teacher.email,
        enseignant=teacher.enseignant,
        enseignant_actif=teacher.enseignant_actif,
        subjects=cleaned_subjects,
    )


@router.delete(
    "/admin/teachers/{user_id}",
)
def admin_remove_teacher(
    user_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retire le statut enseignant.

    Les conversations historiques ne sont pas supprimées.
    """

    require_admin(current_user)

    teacher = (
        db.query(User)
        .filter(User.id == user_id)
        .first()
    )

    if not teacher:
        raise HTTPException(
            status_code=404,
            detail="Utilisateur introuvable.",
        )

    teacher.enseignant = False
    teacher.enseignant_actif = False

    db.query(TeacherSubject).filter(
        TeacherSubject.teacher_id == teacher.id
    ).delete(
        synchronize_session=False
    )

    db.commit()

    return {
        "message": "Statut enseignant retiré avec succès."
    }

# ============================================================
# ADMIN — TOUTES LES CONVERSATIONS ÉLÈVES ↔ ENSEIGNANTS
# ============================================================

@router.get(
    "/admin/teacher-conversations",
    response_model=List[AdminTeacherConversationListResponse],
)
def get_all_teacher_conversations(
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retourne toutes les conversations entre les apprenants
    et les enseignants.

    Accessible uniquement à l'administration.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Accès réservé à l'administration",
        )

    questions = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.recipient_type == "subject"
        )
        .order_by(UserQuestion.updated_at.desc())
        .all()
    )

    resultat = []

    for question in questions:

        # ----------------------------------------------------
        # Recherche des enseignants ayant participé
        # ----------------------------------------------------

        teacher_messages = (
            db.query(QuestionMessage)
            .filter(
                QuestionMessage.question_id == question.id,
                QuestionMessage.sender_role == "teacher",
            )
            .order_by(QuestionMessage.created_at.asc())
            .all()
        )

        teacher_names = []

        for message in teacher_messages:

            if not message.sender:
                continue

            nom_complet = (
                f"{message.sender.prenom} {message.sender.nom}"
            ).strip()

            if nom_complet and nom_complet not in teacher_names:
                teacher_names.append(nom_complet)

        resultat.append(
            AdminTeacherConversationListResponse(
                id=question.id,

                user_id=question.user_id,
                user_nom=question.user.nom,
                user_prenom=question.user.prenom,
                user_email=question.user.email,

                subject=question.subject,
                learner_class=question.learner_class,

                title=question.title,
                status=question.status,

                created_at=question.created_at,
                updated_at=question.updated_at,

                teacher_names=teacher_names,

                message_count=len(question.messages),
            )
        )

    return resultat


@router.get(
    "/admin/teacher-conversations/{question_id}",
    response_model=AdminTeacherConversationResponse,
)
def get_admin_teacher_conversation(
    question_id: int,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Retourne une conversation complète élève ↔ enseignant
    pour l'administration.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Accès réservé à l'administration",
        )

    question = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.id == question_id,
            UserQuestion.recipient_type == "subject",
        )
        .first()
    )

    if question is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Conversation enseignant introuvable",
        )

    teacher_messages = (
        db.query(QuestionMessage)
        .filter(
            QuestionMessage.question_id == question.id,
            QuestionMessage.sender_role == "teacher",
        )
        .order_by(QuestionMessage.created_at.asc())
        .all()
    )

    teacher_names = []

    for message in teacher_messages:

        if not message.sender:
            continue

        nom_complet = (
            f"{message.sender.prenom} {message.sender.nom}"
        ).strip()

        if nom_complet and nom_complet not in teacher_names:
            teacher_names.append(nom_complet)

    return AdminTeacherConversationResponse(
        id=question.id,

        user_id=question.user_id,
        user_nom=question.user.nom,
        user_prenom=question.user.prenom,
        user_email=question.user.email,

        recipient_type=question.recipient_type,
        subject=question.subject,

        is_learner=question.is_learner,
        learner_class=question.learner_class,

        title=question.title,
        content=question.content,

        status=question.status,

        created_at=question.created_at,
        expires_at=question.expires_at,
        updated_at=question.updated_at,

        teacher_names=teacher_names,

        messages=[
            MessageResponse.model_validate(message)
            for message in question.messages
        ],
    )


@router.post(
    "/admin/teacher-conversations/{question_id}/messages",
    response_model=MessageResponse,
)
def admin_reply_to_teacher_conversation(
    question_id: int,
    data: MessageCreate,
    current_user: User = Depends(get_current_user),
    db: Session = Depends(get_db),
):
    """
    Permet à l'administration d'intervenir dans une conversation
    entre un élève et un enseignant.
    """

    if not current_user.is_admin:
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Accès réservé à l'administration",
        )

    question = (
        db.query(UserQuestion)
        .filter(
            UserQuestion.id == question_id,
            UserQuestion.recipient_type == "subject",
        )
        .first()
    )

    if question is None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Conversation introuvable",
        )

    contenu = data.content.strip()

    if not contenu:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Le message ne peut pas être vide",
        )

    message = QuestionMessage(
        question_id=question.id,
        sender_id=current_user.id,
        sender_role="admin",
        content=contenu,
    )

    db.add(message)

    question.status = "in_progress"
    question.updated_at = datetime.utcnow()

    db.commit()
    db.refresh(message)

    return MessageResponse.model_validate(message)