"""Ajouter l'autorisation de téléchargement aux versions de documents."""

from alembic import op
import sqlalchemy as sa


revision = "a7c92d41e650"
down_revision = "456ac933a162"
branch_labels = None
depends_on = None


def upgrade():
    op.add_column(
        "document_versions",
        sa.Column(
            "allow_download",
            sa.Boolean(),
            nullable=False,
            server_default=sa.false(),
        ),
    )


def downgrade():
    op.drop_column(
        "document_versions",
        "allow_download",
    )
