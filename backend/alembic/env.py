import os
import sys
from logging.config import fileConfig

from sqlalchemy import create_engine, pool
from alembic import context
from dotenv import load_dotenv

sys.path.append(os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

load_dotenv()

# Charger la Base centrale
from database import Base

# Charger TOUS les modèles afin qu'ils soient connus par Base.metadata
from models.user import User
from models.pending_user import PendingUser
from models.question import Question
from models.remediation_progress import RemediationProgress
from models.remediation_videos import RemediationVideo
from models.video_questions import VideoQuestion
from models.connection_log import UserConnectionLog
from models.order import Order

# ---------------------------------------------------------
# Configuration
# ---------------------------------------------------------

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT", "5432")
DB_NAME = os.getenv("DB_DATABASE")

if not all([DB_USER, DB_PASSWORD, DB_HOST, DB_NAME]):
    raise ValueError(
        "❌ Variables DB manquantes dans backend/.env"
    )

DATABASE_URL = (
    f"postgresql+psycopg://"
    f"{DB_USER}:{DB_PASSWORD}@"
    f"{DB_HOST}:{DB_PORT}/"
    f"{DB_NAME}?sslmode=require"
)

print(
    f"🔗 ALEMBIC DATABASE_URL = "
    f"postgresql+psycopg://{DB_USER}:****@"
    f"{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# ---------------------------------------------------------
# Alembic
# ---------------------------------------------------------

config = context.config

if config.config_file_name is not None:
    fileConfig(config.config_file_name)

target_metadata = Base.metadata


def run_migrations_offline():
    context.configure(
        url=DATABASE_URL,
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
        compare_type=True,
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online():
    connectable = create_engine(
        DATABASE_URL,
        poolclass=pool.NullPool,
    )

    with connectable.connect() as connection:
        context.configure(
            connection=connection,
            target_metadata=target_metadata,
            compare_type=True,
        )

        with context.begin_transaction():
            context.run_migrations()


if context.is_offline_mode():
    run_migrations_offline()
else:
    run_migrations_online()