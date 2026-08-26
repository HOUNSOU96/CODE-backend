import csv
import sys
from pathlib import Path

# Permet d'importer les modules situés dans backend/
BACKEND_DIR = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(BACKEND_DIR))

from sqlalchemy import insert

from database import SessionLocal
from models.document_activation import DocumentActivation

CSV_PATH = Path(__file__).resolve().parents[2] / "data" / "codes_activation.csv"
BATCH_SIZE = 1000


def import_activation_codes():
    print("==========================================")
    print("   IMPORT DES CODES D'ACTIVATION")
    print("==========================================")
    print(f"CSV : {CSV_PATH}")

    if not CSV_PATH.exists():
        print(f"❌ Fichier introuvable : {CSV_PATH}")
        return

    db = SessionLocal()

    try:
        existing_count = db.query(DocumentActivation).count()

        print(f"\nCodes déjà présents en base : {existing_count}")

        if existing_count > 0:
            print("⚠️ La table contient déjà des données.")
            print("❌ Import annulé pour éviter les doublons.")
            return

        rows = []

        with open(
            CSV_PATH,
            "r",
            encoding="utf-8-sig",
            newline=""
        ) as f:

            reader = csv.DictReader(f)

            required_columns = {
                "activation_code",
                "document_name",
                "buyer_email",
                "user_id",
                "is_activated",
                "activated_at",
                "activation_type",
            }

            if not required_columns.issubset(reader.fieldnames or []):
                print("❌ Colonnes CSV incorrectes.")
                print("Colonnes trouvées :", reader.fieldnames)
                return

            for row in reader:
                rows.append(
                    {
                        "activation_code": row["activation_code"].strip(),
                        "document_name": row["document_name"].strip(),
                        "buyer_email": (
                            row["buyer_email"].strip()
                            or None
                        ),
                        "user_id": (
                            int(row["user_id"])
                            if row["user_id"].strip()
                            else None
                        ),
                        "is_activated": (
                            row["is_activated"].strip().lower()
                            == "true"
                        ),
                        "activated_at": None,
                        "activation_type": (
                            row["activation_type"].strip()
                            or None
                        ),
                    }
                )

        print(f"Codes à importer : {len(rows)}")

        total_inserted = 0

        for start in range(0, len(rows), BATCH_SIZE):
            batch = rows[start:start + BATCH_SIZE]

            db.execute(
                insert(DocumentActivation),
                batch
            )

            db.commit()

            total_inserted += len(batch)

            print(
                f"✅ {total_inserted}/{len(rows)} codes importés"
            )

        final_count = db.query(DocumentActivation).count()

        print("\n==========================================")
        print("              RÉSULTAT")
        print("==========================================")
        print(f"Codes dans le CSV : {len(rows)}")
        print(f"Codes en base    : {final_count}")

        if final_count == len(rows):
            print("✅ IMPORT RÉUSSI")
        else:
            print("❌ ATTENTION : nombre différent !")

    except Exception as e:
        db.rollback()
        print("\n❌ ERREUR DURANT L'IMPORT")
        print(type(e).__name__, ":", e)

    finally:
        db.close()


if __name__ == "__main__":
    import_activation_codes()