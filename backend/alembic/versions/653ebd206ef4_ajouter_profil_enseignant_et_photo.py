"""Ajouter profil enseignant et photo

Revision ID: 653ebd206ef4
Revises: 221cd31e473d
Create Date: 2026-09-08 18:30:11.195472
"""

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = "653ebd206ef4"
down_revision = "221cd31e473d"
branch_labels = None
depends_on = None


def upgrade():
    op.add_column(
        "users",
        sa.Column(
            "teacher_profile_validated",
            sa.Boolean(),
            nullable=False,
            server_default=sa.false(),
        ),
    )

    op.add_column(
        "users",
        sa.Column(
            "teacher_photo",
            sa.String(length=500),
            nullable=True,
        ),
    )


def downgrade():
    op.drop_column("users", "teacher_photo")
    op.drop_column("users", "teacher_profile_validated")
