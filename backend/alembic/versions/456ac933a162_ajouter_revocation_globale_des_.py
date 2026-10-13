"""ajouter revocation globale des activations

Revision ID: 456ac933a162
Revises: 64cac30a95d0
Create Date: 2026-10-13 18:01:06.911883
"""

from alembic import op
import sqlalchemy as sa


# Identifiants Alembic
revision = "456ac933a162"
down_revision = "64cac30a95d0"
branch_labels = None
depends_on = None


def upgrade():
    op.add_column(
        "document_activations",
        sa.Column(
            "globally_revoked_at",
            sa.DateTime(),
            nullable=True,
        ),
    )


def downgrade():
    op.drop_column(
        "document_activations",
        "globally_revoked_at",
    )
