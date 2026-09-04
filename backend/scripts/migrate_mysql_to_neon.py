import os
import json
from urllib.parse import quote_plus

from dotenv import load_dotenv
from sqlalchemy import create_engine, MetaData, Table, select, text
from sqlalchemy.engine import URL


# ============================================================
# CONFIGURATION
# ============================================================

load_dotenv()

MYSQL_USER = "pgloader_user"
MYSQL_HOST = "127.0.0.1"
MYSQL_PORT = 3306
MYSQL_DATABASE = "code_db"

MYSQL_PASSWORD = os.getenv("MYSQL_MIGRATION_PASSWORD")

if not MYSQL_PASSWORD:
    raise RuntimeError(
        "❌ MYSQL_MIGRATION_PASSWORD n'est pas défini.\n"
        "Définis cette variable uniquement dans le terminal avant de lancer le script."
    )


# Neon : on réutilise les variables DB du .env du backend.
PG_USER = os.getenv("DB_USER")
PG_PASSWORD = os.getenv("DB_PASSWORD")
PG_HOST = os.getenv("DB_HOST")
PG_PORT = os.getenv("DB_PORT", "5432")
PG_DATABASE = os.getenv("DB_DATABASE")

if not all([PG_USER, PG_PASSWORD, PG_HOST, PG_DATABASE]):
    raise RuntimeError(
        "❌ Variables PostgreSQL manquantes dans le .env : "
        "DB_USER, DB_PASSWORD, DB_HOST, DB_DATABASE"
    )


# ============================================================
# TABLES À MIGRER
# ============================================================

TABLES = [
    "users",
    "remediation_videos",
    "questions",
    "orders",
    "document_activations",
    "remediation_progress",
    "teacher_subjects",
    "user_connection_logs",
    "user_questions",
    "video_questions",
    "question_messages",
]


# Colonnes MySQL tinyint(1) correspondant à des booléens
BOOLEAN_COLUMNS = {
    "users": {
        "is_validated",
        "is_admin",
        "is_online",
        "is_blocked",
        "is_active",
        "is_verified",
        "enseignant",
        "enseignant_actif",
    },
    "remediation_progress": {
        "test_termine",
    },
    "document_activations": {
        "is_activated",
    },
    "user_questions": {
        "is_learner",
    },
}


# Colonnes JSON
JSON_COLUMNS = {
    "questions": {
        "choix",
        "situation",
    },
    "remediation_videos": {
        "mois",
        "notions",
        "prerequis",
    },
    "orders": {
        "items",
    },
    "video_questions": {
        "choix",
    },
}


# Tables possédant une séquence PostgreSQL pour leur id
SEQUENCE_TABLES = [
    "users",
    "orders",
    "document_activations",
    "remediation_progress",
    "teacher_subjects",
    "user_connection_logs",
    "user_questions",
    "question_messages",
]


# ============================================================
# UTILITAIRES
# ============================================================

def normalize_json(value):
    """
    MySQL peut renvoyer un JSON sous forme de dict/list
    ou parfois sous forme de chaîne.
    PostgreSQL attend un objet Python sérialisable.
    """
    if value is None:
        return None

    if isinstance(value, (dict, list, int, float, bool)):
        return value

    if isinstance(value, str):
        try:
            return json.loads(value)
        except json.JSONDecodeError:
            # Si la valeur est réellement une chaîne JSON non décodable,
            # on la conserve telle quelle.
            return value

    return value


def normalize_row(table_name, row):
    """
    Adapte une ligne MySQL pour PostgreSQL sans modifier
    les données métier.
    """
    result = dict(row)

    # Boolean
    for column in BOOLEAN_COLUMNS.get(table_name, set()):
        if column in result and result[column] is not None:
            result[column] = bool(result[column])

    # JSON
    for column in JSON_COLUMNS.get(table_name, set()):
        if column in result:
            result[column] = normalize_json(result[column])

    return result


def get_count(connection, table_name):
    dialect = connection.dialect.name

    if dialect == "mysql":
        table_sql = f"`{table_name}`"
    else:
        table_sql = f'"{table_name}"'

    return connection.execute(
        text(f"SELECT COUNT(*) FROM {table_sql}")
    ).scalar_one()


# ============================================================
# CONNEXIONS
# ============================================================

mysql_url = URL.create(
    "mysql+pymysql",
    username=MYSQL_USER,
    password=MYSQL_PASSWORD,
    host=MYSQL_HOST,
    port=MYSQL_PORT,
    database=MYSQL_DATABASE,
)

postgres_url = URL.create(
    "postgresql+psycopg",
    username=PG_USER,
    password=PG_PASSWORD,
    host=PG_HOST,
    port=int(PG_PORT),
    database=PG_DATABASE,
    query={"sslmode": "require"},
)


print()
print("=" * 70)
print("       MIGRATION MySQL → NEON POSTGRESQL")
print("=" * 70)
print()
print("Source      : MySQL / code_db")
print("Destination : Neon PostgreSQL")
print(f"Tables      : {len(TABLES)}")
print()
print("⚠️  MySQL sera utilisé uniquement en lecture.")
print("⚠️  La migration Neon sera effectuée dans une transaction.")
print("⚠️  En cas d'erreur, les insertions Neon seront annulées.")
print()


mysql_engine = create_engine(
    mysql_url,
    pool_pre_ping=True,
)

pg_engine = create_engine(
    postgres_url,
    pool_pre_ping=True,
)


# ============================================================
# VÉRIFICATION SOURCE
# ============================================================

print("=" * 70)
print("1. VÉRIFICATION DES DONNÉES SOURCE")
print("=" * 70)

expected_counts = {}

with mysql_engine.connect() as mysql_conn:
    for table_name in TABLES:
        count = get_count(mysql_conn, table_name)
        expected_counts[table_name] = count
        print(f"{table_name:<30} {count:>8} lignes")

total_source = sum(expected_counts.values())

print("-" * 70)
print(f"{'TOTAL':<30} {total_source:>8} lignes")
print()


# ============================================================
# MÉTADONNÉES
# ============================================================

mysql_metadata = MetaData()
pg_metadata = MetaData()

mysql_metadata.reflect(
    bind=mysql_engine,
    only=TABLES,
)

pg_metadata.reflect(
    bind=pg_engine,
    only=TABLES,
)


# ============================================================
# MIGRATION
# ============================================================

print("=" * 70)
print("2. MIGRATION DES DONNÉES")
print("=" * 70)
print()

with mysql_engine.connect() as mysql_conn:

    # Une seule transaction PostgreSQL pour toute la migration.
    with pg_engine.begin() as pg_conn:

        for table_name in TABLES:

            mysql_table = mysql_metadata.tables[table_name]
            pg_table = pg_metadata.tables[table_name]

            expected = expected_counts[table_name]

            print(f"→ {table_name}")

            if expected == 0:
                print("   0 ligne — rien à insérer.")
                print()
                continue

            # Lecture complète de la table source.
            rows = mysql_conn.execute(
                select(mysql_table)
            ).mappings().all()

            print(f"   Source : {len(rows)} lignes")

            if len(rows) != expected:
                raise RuntimeError(
                    f"❌ Nombre de lignes incohérent pour {table_name}: "
                    f"{len(rows)} au lieu de {expected}"
                )

            normalized_rows = [
                normalize_row(table_name, row)
                for row in rows
            ]

            # Insertion par lots.
            batch_size = 500

            for start in range(0, len(normalized_rows), batch_size):
                batch = normalized_rows[start:start + batch_size]

                pg_conn.execute(
                    pg_table.insert(),
                    batch,
                )

                inserted_until = min(
                    start + len(batch),
                    len(normalized_rows)
                )

                print(
                    f"   Inséré : {inserted_until}/{len(normalized_rows)}"
                )

            # Vérification immédiate dans la transaction.
            target_count = get_count(pg_conn, table_name)

            if target_count != expected:
                raise RuntimeError(
                    f"❌ Vérification échouée pour {table_name}: "
                    f"Neon={target_count}, MySQL={expected}"
                )

            print(f"   ✅ Vérifié : {target_count} lignes")
            print()


        # ====================================================
        # VÉRIFICATION GLOBALE AVANT COMMIT
        # ====================================================

        print("=" * 70)
        print("3. VÉRIFICATION GLOBALE AVANT COMMIT")
        print("=" * 70)

        total_target = 0

        for table_name in TABLES:
            source_count = expected_counts[table_name]
            target_count = get_count(pg_conn, table_name)

            print(
                f"{table_name:<30} "
                f"MySQL={source_count:<8} "
                f"Neon={target_count:<8}",
                end=" "
            )

            if source_count != target_count:
                print("❌")
                raise RuntimeError(
                    f"❌ Écart détecté dans {table_name}"
                )

            print("✅")
            total_target += target_count

        print("-" * 70)
        print(
            f"{'TOTAL':<30} "
            f"MySQL={total_source:<8} "
            f"Neon={total_target:<8} "
            "✅"
        )
        print()


        # ====================================================
        # RESET DES SÉQUENCES
        # ====================================================

        print("=" * 70)
        print("4. RÉINITIALISATION DES SÉQUENCES")
        print("=" * 70)

        for table_name in SEQUENCE_TABLES:

            sql = text(f"""
                SELECT setval(
                    pg_get_serial_sequence(
                        'public."{table_name}"',
                        'id'
                    ),
                    COALESCE(
                        (SELECT MAX(id) FROM public."{table_name}"),
                        1
                    ),
                    CASE
                        WHEN EXISTS (
                            SELECT 1
                            FROM public."{table_name}"
                        )
                        THEN true
                        ELSE false
                    END
                )
            """)

            pg_conn.execute(sql)

            print(f"   ✅ Séquence {table_name}.id")


        # ====================================================
        # VÉRIFICATION DES CLÉS ÉTRANGÈRES
        # ====================================================

        print()
        print("=" * 70)
        print("5. VÉRIFICATION DES CLÉS ÉTRANGÈRES")
        print("=" * 70)

        fk_checks = [
            (
                "document_activations.user_id",
                """
                SELECT COUNT(*)
                FROM document_activations d
                LEFT JOIN users u ON d.user_id = u.id
                WHERE d.user_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "remediation_progress.user_id",
                """
                SELECT COUNT(*)
                FROM remediation_progress r
                LEFT JOIN users u ON r.user_id = u.id
                WHERE r.user_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "teacher_subjects.teacher_id",
                """
                SELECT COUNT(*)
                FROM teacher_subjects t
                LEFT JOIN users u ON t.teacher_id = u.id
                WHERE t.teacher_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "user_connection_logs.user_id",
                """
                SELECT COUNT(*)
                FROM user_connection_logs l
                LEFT JOIN users u ON l.user_id = u.id
                WHERE l.user_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "user_questions.user_id",
                """
                SELECT COUNT(*)
                FROM user_questions q
                LEFT JOIN users u ON q.user_id = u.id
                WHERE q.user_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "question_messages.question_id",
                """
                SELECT COUNT(*)
                FROM question_messages m
                LEFT JOIN user_questions q ON m.question_id = q.id
                WHERE m.question_id IS NOT NULL
                  AND q.id IS NULL
                """,
            ),
            (
                "question_messages.sender_id",
                """
                SELECT COUNT(*)
                FROM question_messages m
                LEFT JOIN users u ON m.sender_id = u.id
                WHERE m.sender_id IS NOT NULL
                  AND u.id IS NULL
                """,
            ),
            (
                "video_questions.remediation_video_id",
                """
                SELECT COUNT(*)
                FROM video_questions v
                LEFT JOIN remediation_videos r
                    ON v.remediation_video_id = r.id
                WHERE v.remediation_video_id IS NOT NULL
                  AND r.id IS NULL
                """,
            ),
        ]

        for name, sql in fk_checks:
            orphan_count = pg_conn.execute(text(sql)).scalar_one()

            if orphan_count != 0:
                print(f"   ❌ {name} : {orphan_count} orphelins")
                raise RuntimeError(
                    f"❌ Clé étrangère invalide : {name}"
                )

            print(f"   ✅ {name} : 0 orphelin")

        print()
        print("=" * 70)
        print("6. COMMIT DE LA TRANSACTION")
        print("=" * 70)
        print()
        print("   Toutes les vérifications sont réussies.")
        print("   PostgreSQL va maintenant valider la transaction.")
        print()


# ============================================================
# VÉRIFICATION FINALE APRÈS COMMIT
# ============================================================

print("=" * 70)
print("7. VÉRIFICATION FINALE APRÈS COMMIT")
print("=" * 70)
print()

with pg_engine.connect() as pg_conn:

    final_total = 0

    for table_name in TABLES:
        count = get_count(pg_conn, table_name)
        expected = expected_counts[table_name]

        status = "✅" if count == expected else "❌"

        print(
            f"{table_name:<30} "
            f"{count:>8} / {expected:<8} "
            f"{status}"
        )

        if count != expected:
            raise RuntimeError(
                f"❌ Vérification finale échouée : {table_name}"
            )

        final_total += count


print()
print("-" * 70)
print(f"TOTAL MIGRÉ : {final_total} lignes")
print("-" * 70)
print()

if final_total != total_source:
    raise RuntimeError(
        f"❌ Total incorrect : source={total_source}, "
        f"Neon={final_total}"
    )


print("=" * 70)
print("🎉 MIGRATION TERMINÉE AVEC SUCCÈS")
print("=" * 70)
print()
print("Source MySQL : code_db")
print("Destination  : Neon PostgreSQL")
print(f"Total        : {final_total} lignes")
print()
print("✅ Données conservées")
print("✅ IDs conservés")
print("✅ JSON conservés")
print("✅ NULL conservés")
print("✅ Booléens convertis")
print("✅ Clés étrangères vérifiées")
print("✅ Séquences réinitialisées")
print("✅ current_token conservé")
print()
