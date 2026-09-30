"""ajouter gestion des établissements scolaires

Revision ID: 64cac30a95d0
Revises: 653ebd206ef4
Create Date: 2026-09-30 11:18:00
"""

from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = "64cac30a95d0"
down_revision: Union[str, Sequence[str], None] = "653ebd206ef4"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ============================================================
    # TABLE : schools
    # ============================================================

    op.create_table(
        "schools",

        sa.Column(
            "id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "nom",
            sa.String(length=255),
            nullable=False,
        ),

        sa.Column(
            "adresse",
            sa.String(length=500),
            nullable=True,
        ),

        sa.Column(
            "ville",
            sa.String(length=100),
            nullable=True,
        ),

        sa.Column(
            "departement",
            sa.String(length=100),
            nullable=True,
        ),

        sa.Column(
            "pays",
            sa.String(length=100),
            nullable=False,
            server_default="Bénin",
        ),

        sa.Column(
            "type_enseignement",
            sa.String(length=500),
            nullable=True,
        ),

        sa.Column(
            "statut",
            sa.String(length=50),
            nullable=True,
        ),

        sa.Column(
            "email",
            sa.String(length=255),
            nullable=True,
        ),

        sa.Column(
            "telephone",
            sa.String(length=50),
            nullable=True,
        ),

        sa.Column(
            "is_active",
            sa.Boolean(),
            nullable=False,
            server_default=sa.true(),
        ),

        sa.Column(
            "created_at",
            sa.DateTime(),
            nullable=False,
            server_default=sa.func.now(),
        ),

        sa.PrimaryKeyConstraint("id"),

        sa.UniqueConstraint(
            "nom",
            "ville",
            "departement",
            name="uq_school_nom_ville_departement",
        ),
    )

    # Index schools
    op.create_index(
        "ix_schools_id",
        "schools",
        ["id"],
        unique=False,
    )

    op.create_index(
        "ix_schools_nom",
        "schools",
        ["nom"],
        unique=False,
    )

    op.create_index(
        "ix_schools_ville",
        "schools",
        ["ville"],
        unique=False,
    )

    op.create_index(
        "ix_schools_departement",
        "schools",
        ["departement"],
        unique=False,
    )

    op.create_index(
        "ix_schools_type_enseignement",
        "schools",
        ["type_enseignement"],
        unique=False,
    )

    op.create_index(
        "ix_schools_statut",
        "schools",
        ["statut"],
        unique=False,
    )

    # ============================================================
    # TABLE : school_memberships
    # ============================================================

    op.create_table(
        "school_memberships",

        sa.Column(
            "id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "user_id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "school_id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "role",
            sa.String(length=30),
            nullable=False,
        ),

        sa.Column(
            "status",
            sa.String(length=30),
            nullable=False,
            server_default="pending",
        ),

        sa.Column(
            "academic_year",
            sa.String(length=9),
            nullable=False,
        ),

        sa.Column(
            "requested_at",
            sa.DateTime(),
            nullable=False,
            server_default=sa.func.now(),
        ),

        sa.Column(
            "approved_at",
            sa.DateTime(),
            nullable=True,
        ),

        sa.Column(
            "approved_by",
            sa.Integer(),
            nullable=True,
        ),

        sa.Column(
            "rejected_at",
            sa.DateTime(),
            nullable=True,
        ),

        sa.Column(
            "rejected_by",
            sa.Integer(),
            nullable=True,
        ),

        sa.ForeignKeyConstraint(
            ["user_id"],
            ["users.id"],
            ondelete="CASCADE",
        ),

        sa.ForeignKeyConstraint(
            ["school_id"],
            ["schools.id"],
            ondelete="CASCADE",
        ),

        sa.ForeignKeyConstraint(
            ["approved_by"],
            ["users.id"],
            ondelete="SET NULL",
        ),

        sa.ForeignKeyConstraint(
            ["rejected_by"],
            ["users.id"],
            ondelete="SET NULL",
        ),

        sa.PrimaryKeyConstraint("id"),

        sa.UniqueConstraint(
            "user_id",
            "school_id",
            "academic_year",
            name="uq_user_school_academic_year",
        ),
    )

    # Index school_memberships
    op.create_index(
        "ix_school_memberships_id",
        "school_memberships",
        ["id"],
        unique=False,
    )

    op.create_index(
        "ix_school_memberships_user_id",
        "school_memberships",
        ["user_id"],
        unique=False,
    )

    op.create_index(
        "ix_school_memberships_school_id",
        "school_memberships",
        ["school_id"],
        unique=False,
    )

    op.create_index(
        "ix_school_memberships_role",
        "school_memberships",
        ["role"],
        unique=False,
    )

    op.create_index(
        "ix_school_memberships_status",
        "school_memberships",
        ["status"],
        unique=False,
    )

    op.create_index(
        "ix_school_memberships_academic_year",
        "school_memberships",
        ["academic_year"],
        unique=False,
    )

    op.create_index(
        "ix_school_membership_school_status",
        "school_memberships",
        ["school_id", "status"],
        unique=False,
    )

    op.create_index(
        "ix_school_membership_user_year",
        "school_memberships",
        ["user_id", "academic_year"],
        unique=False,
    )

    # ============================================================
    # TABLE : school_directors
    # ============================================================

    op.create_table(
        "school_directors",

        sa.Column(
            "id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "user_id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "school_id",
            sa.Integer(),
            nullable=False,
        ),

        sa.Column(
            "is_active",
            sa.Boolean(),
            nullable=False,
            server_default=sa.true(),
        ),

        sa.Column(
            "assigned_at",
            sa.DateTime(),
            nullable=False,
            server_default=sa.func.now(),
        ),

        sa.Column(
            "assigned_by",
            sa.Integer(),
            nullable=True,
        ),

        sa.ForeignKeyConstraint(
            ["user_id"],
            ["users.id"],
            ondelete="CASCADE",
        ),

        sa.ForeignKeyConstraint(
            ["school_id"],
            ["schools.id"],
            ondelete="CASCADE",
        ),

        sa.ForeignKeyConstraint(
            ["assigned_by"],
            ["users.id"],
            ondelete="SET NULL",
        ),

        sa.PrimaryKeyConstraint("id"),

        sa.UniqueConstraint(
            "user_id",
            "school_id",
            name="uq_school_director",
        ),
    )

    # Index school_directors
    op.create_index(
        "ix_school_directors_id",
        "school_directors",
        ["id"],
        unique=False,
    )

    op.create_index(
        "ix_school_directors_user_id",
        "school_directors",
        ["user_id"],
        unique=False,
    )

    op.create_index(
        "ix_school_directors_school_id",
        "school_directors",
        ["school_id"],
        unique=False,
    )

    op.create_index(
        "ix_school_director_school_active",
        "school_directors",
        ["school_id", "is_active"],
        unique=False,
    )


def downgrade() -> None:
    # Supprimer les tables dans l'ordre inverse
    op.drop_index(
        "ix_school_director_school_active",
        table_name="school_directors",
    )

    op.drop_index(
        "ix_school_directors_school_id",
        table_name="school_directors",
    )

    op.drop_index(
        "ix_school_directors_user_id",
        table_name="school_directors",
    )

    op.drop_index(
        "ix_school_directors_id",
        table_name="school_directors",
    )

    op.drop_table("school_directors")

    op.drop_index(
        "ix_school_membership_user_year",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_membership_school_status",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_academic_year",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_status",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_role",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_school_id",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_user_id",
        table_name="school_memberships",
    )

    op.drop_index(
        "ix_school_memberships_id",
        table_name="school_memberships",
    )

    op.drop_table("school_memberships")

    op.drop_index(
        "ix_schools_statut",
        table_name="schools",
    )

    op.drop_index(
        "ix_schools_type_enseignement",
        table_name="schools",
    )

    op.drop_index(
        "ix_schools_departement",
        table_name="schools",
    )

    op.drop_index(
        "ix_schools_ville",
        table_name="schools",
    )

    op.drop_index(
        "ix_schools_nom",
        table_name="schools",
    )

    op.drop_index(
        "ix_schools_id",
        table_name="schools",
    )

    op.drop_table("schools")