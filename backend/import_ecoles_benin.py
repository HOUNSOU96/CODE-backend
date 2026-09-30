import csv
import os
import sys

from sqlalchemy.exc import IntegrityError

from database import SessionLocal
from models.school import School


CSV_PATH = os.path.join(
    os.path.dirname(os.path.abspath(__file__)),
    "data",
    "ecoles_benin_secondaire.csv",
)


REQUIRED_COLUMNS = [
    "nom",
    "adresse",
    "ville",
    "departement",
    "pays",
    "type_enseignement",
    "statut",
    "is_active",
]


def parse_bool(value: str) -> bool:
    """
    Convertit une valeur CSV en booléen.
    """
    value = (value or "").strip().lower()

    if value in {"true", "1", "yes", "oui"}:
        return True

    if value in {"false", "0", "no", "non"}:
        return False

    raise ValueError(
        f"Valeur booléenne invalide pour is_active : {value!r}"
    )


def clean(value):
    """
    Nettoie une valeur texte.
    Une chaîne vide devient None.
    """
    if value is None:
        return None

    value = value.strip()

    return value if value else None


def main():
    print()
    print("=" * 80)
    print("IMPORT DES ÉTABLISSEMENTS SCOLAIRES DU BÉNIN")
    print("=" * 80)

    # ------------------------------------------------------------
    # Vérification du fichier CSV
    # ------------------------------------------------------------

    if not os.path.isfile(CSV_PATH):
        print(f"❌ Fichier CSV introuvable : {CSV_PATH}")
        sys.exit(1)

    print(f"📄 CSV : {CSV_PATH}")

    # ------------------------------------------------------------
    # Lecture du CSV
    # ------------------------------------------------------------

    try:
        with open(
            CSV_PATH,
            "r",
            encoding="utf-8-sig",
            newline="",
        ) as file:

            reader = csv.DictReader(file)

            if reader.fieldnames is None:
                print("❌ Le CSV ne contient aucune colonne.")
                sys.exit(1)

            missing_columns = [
                column
                for column in REQUIRED_COLUMNS
                if column not in reader.fieldnames
            ]

            if missing_columns:
                print(
                    "❌ Colonnes manquantes dans le CSV :",
                    ", ".join(missing_columns),
                )
                sys.exit(1)

            rows = list(reader)

    except Exception as error:
        print(f"❌ Erreur lors de la lecture du CSV : {error}")
        sys.exit(1)

    print(f"📊 Nombre de lignes dans le CSV : {len(rows)}")

    if not rows:
        print("❌ Le CSV est vide.")
        sys.exit(1)

    # ------------------------------------------------------------
    # Validation du CSV avant insertion
    # ------------------------------------------------------------

    print()
    print("🔎 Validation des données...")

    errors = []

    # Détection des doublons internes au CSV
    csv_keys = {}

    for line_number, row in enumerate(rows, start=2):

        nom = clean(row.get("nom"))
        ville = clean(row.get("ville"))
        departement = clean(row.get("departement"))

        if not nom:
            errors.append(
                f"Ligne {line_number}: nom manquant"
            )

        if not ville:
            errors.append(
                f"Ligne {line_number}: ville manquante"
            )

        if not departement:
            errors.append(
                f"Ligne {line_number}: département manquant"
            )

        if not clean(row.get("pays")):
            errors.append(
                f"Ligne {line_number}: pays manquant"
            )

        if not clean(row.get("type_enseignement")):
            errors.append(
                f"Ligne {line_number}: type_enseignement manquant"
            )

        if not clean(row.get("statut")):
            errors.append(
                f"Ligne {line_number}: statut manquant"
            )

        try:
            parse_bool(row.get("is_active"))
        except ValueError as error:
            errors.append(
                f"Ligne {line_number}: {error}"
            )

        key = (
            (nom or "").casefold(),
            (ville or "").casefold(),
            (departement or "").casefold(),
        )

        if key in csv_keys:
            errors.append(
                "Doublon dans le CSV : "
                f"lignes {csv_keys[key]} et {line_number} "
                f"({nom} / {ville} / {departement})"
            )
        else:
            csv_keys[key] = line_number

    if errors:
        print()
        print("❌ ERREURS DANS LE CSV")
        print("-" * 80)

        for error in errors:
            print(f"• {error}")

        print()
        print(f"Nombre d'erreurs : {len(errors)}")
        print("Aucune donnée n'a été insérée dans Neon.")
        sys.exit(1)

    print("✅ Validation du CSV réussie.")

    # ------------------------------------------------------------
    # Connexion à Neon
    # ------------------------------------------------------------

    db = SessionLocal()

    inserted = 0
    skipped = 0
    failed = 0

    inserted_names = []
    skipped_names = []
    failed_names = []

    try:
        print()
        print("🔗 Connexion à Neon...")
        print("✅ Connexion SQLAlchemy ouverte.")

        # --------------------------------------------------------
        # Parcours des écoles
        # --------------------------------------------------------

        for line_number, row in enumerate(rows, start=2):

            nom = clean(row.get("nom"))
            adresse = clean(row.get("adresse"))
            ville = clean(row.get("ville"))
            departement = clean(row.get("departement"))
            pays = clean(row.get("pays")) or "Bénin"
            type_enseignement = clean(
                row.get("type_enseignement")
            )
            statut = clean(row.get("statut"))
            is_active = parse_bool(
                row.get("is_active")
            )

            # Recherche du doublon dans Neon
            existing = (
                db.query(School)
                .filter(
                    School.nom == nom,
                    School.ville == ville,
                    School.departement == departement,
                )
                .first()
            )

            if existing:
                skipped += 1

                skipped_names.append(
                    f"{nom} — {ville} — {departement}"
                )

                continue

            school = School(
                nom=nom,
                adresse=adresse,
                ville=ville,
                departement=departement,
                pays=pays,
                type_enseignement=type_enseignement,
                statut=statut,
                is_active=is_active,
            )

            db.add(school)

            inserted += 1

            inserted_names.append(
                f"{nom} — {ville} — {departement}"
            )

        # --------------------------------------------------------
        # Commit global
        # --------------------------------------------------------

        print()
        print("💾 Enregistrement dans Neon...")

        db.commit()

        print("✅ Commit réussi.")

    except IntegrityError as error:

        db.rollback()

        print()
        print("❌ ERREUR D'INTÉGRITÉ SQL")
        print("-" * 80)
        print(error)
        print()
        print("🔄 Transaction annulée.")
        print("Aucune insertion de cette exécution n'a été conservée.")

        sys.exit(1)

    except Exception as error:

        db.rollback()

        print()
        print("❌ ERREUR DURANT L'IMPORT")
        print("-" * 80)
        print(repr(error))
        print()
        print("🔄 Transaction annulée.")

        sys.exit(1)

    finally:
        db.close()

    # ------------------------------------------------------------
    # Rapport final
    # ------------------------------------------------------------

    print()
    print("=" * 80)
    print("RÉSULTAT DE L'IMPORT")
    print("=" * 80)

    print(f"📄 Écoles dans le CSV      : {len(rows)}")
    print(f"🟢 Nouvelles écoles        : {inserted}")
    print(f"🟡 Déjà présentes          : {skipped}")
    print(f"🔴 Échecs                  : {failed}")
    print("=" * 80)

    if inserted_names:
        print()
        print("ÉCOLES INSÉRÉES")
        print("-" * 80)

        for name in inserted_names:
            print(f"✓ {name}")

    if skipped_names:
        print()
        print("ÉCOLES DÉJÀ PRÉSENTES")
        print("-" * 80)

        for name in skipped_names:
            print(f"→ {name}")

    if failed_names:
        print()
        print("ÉCOLES EN ÉCHEC")
        print("-" * 80)

        for name in failed_names:
            print(f"✗ {name}")

    print()
    print("✅ IMPORT TERMINÉ")
    print()


if __name__ == "__main__":
    main()
