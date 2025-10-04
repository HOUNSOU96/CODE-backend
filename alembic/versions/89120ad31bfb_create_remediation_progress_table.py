"""create remediation_progress table

Revision ID: 89120ad31bfb
Revises: fbce9ca543de
Create Date: 2025-09-22 18:49:32.968067

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = '89120ad31bfb'
down_revision = 'fbce9ca543de'
branch_labels = None
depends_on = None


def upgrade():
    conn = op.get_bind()
    inspector = sa.inspect(conn)

    if "remediation_progress" not in inspector.get_table_names():
        op.create_table(
            'remediation_progress',
            sa.Column('id', sa.Integer, primary_key=True, autoincrement=True),
            sa.Column('user_id', sa.Integer, sa.ForeignKey('users.id', ondelete="CASCADE"), nullable=False),
            sa.Column('matiere', sa.String(255)),
            sa.Column('notion', sa.String(255)),
            sa.Column('niveau', sa.String(50)),
            sa.Column('statut', sa.String(50)),
            sa.Column('video_actuelle_id', sa.String(255)),
            sa.Column('test_termine', sa.Boolean, default=False),
            sa.Column('test_score', sa.Integer),
        )


def downgrade():
    op.drop_table('remediation_progress')


