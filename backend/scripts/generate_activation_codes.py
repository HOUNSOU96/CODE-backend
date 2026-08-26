# backend/scripts/generate_activation_codes.py

import csv
import os
import secrets
import string


# ==========================================================
# CONFIGURATION
# ==========================================================

CODES_PAR_DOCUMENT = 1000

DOCUMENTS = [
    "CODE Maths 1er cycle Tome I",
    "CODE Maths 1er cycle Tome II",
    "CODE Maths 2nd cycle Tome I",
    "CODE Maths 2nd cycle Tome II",
    "CODE Maths Épreuves BEPC",
    "CODE Maths Épreuves BAC",

    # Autres domaines
    "CODE PCT",
    "CODE SVT",
    "CODE Français",
    "CODE Anglais",
    "CODE Histoire",
    "CODE Géographie",
    "CODE Philosophie",
    "CODE Informatique",
    "CODE Intelligence Artificielle",
    "CODE Musique",
    "CODE EPS",
    "CODE Divertissement",
]


# ==========================================================
# FICHIER DE SORTIE
# ==========================================================

BASE_DIR = os.path.dirname(
    os.path.dirname(
        os.path.dirname(
            os.path.abspath(__file__)
        )
    )
)

OUTPUT_DIR = os.path.join(
    BASE_DIR,
    "data"
)

OUTPUT_FILE = os.path.join(
    OUTPUT_DIR,
    "codes_activation.csv"
)


# ==========================================================
# GÉNÉRATION D'UN CODE
# ==========================================================

def generate_code(length=16):
    """
    Génère un code d'activation sécurisé.

    Exemple :
    CODE-X7K9-P4M2-Q8TZ
    """

    alphabet = string.ascii_uppercase + string.digits

    raw = "".join(
        secrets.choice(alphabet)
        for _ in range(length)
    )

    return (
        f"CODE-{raw[:4]}-"
        f"{raw[4:8]}-"
        f"{raw[8:12]}-"
        f"{raw[12:16]}"
    )


# ==========================================================
# GÉNÉRATION DE TOUS LES CODES
# ==========================================================

def generate_activation_codes():

    # Créer le dossier data s'il n'existe pas
    os.makedirs(
        OUTPUT_DIR,
        exist_ok=True
    )

    # Ensemble permettant de garantir
    # l'unicité de tous les codes
    generated_codes = set()

    total_created = 0

    print()
    print("=" * 70)
    print("GÉNÉRATEUR DE CODES D'ACTIVATION — CODE")
    print("=" * 70)

    print()
    print(f"Nombre de documents : {len(DOCUMENTS)}")
    print(f"Codes par document  : {CODES_PAR_DOCUMENT}")
    print(
        f"Nombre total prévu  : "
        f"{len(DOCUMENTS) * CODES_PAR_DOCUMENT}"
    )

    print()
    print(f"Fichier de sortie : {OUTPUT_FILE}")

    # ======================================================
    # OUVERTURE DU CSV
    # ======================================================

    with open(
        OUTPUT_FILE,
        "w",
        newline="",
        encoding="utf-8"
    ) as csvfile:

        writer = csv.writer(csvfile)

        # --------------------------------------------------
        # En-tête
        # --------------------------------------------------

        writer.writerow([
            "activation_code",
            "document_name",
            "buyer_email",
            "user_id",
            "is_activated",
            "activated_at",
            "activation_type",
        ])

        # ==================================================
        # GÉNÉRATION PAR DOCUMENT
        # ==================================================

        for document_name in DOCUMENTS:

            print()
            print("-" * 70)
            print(f"Document : {document_name}")
            print("-" * 70)

            created_for_document = 0

            while created_for_document < CODES_PAR_DOCUMENT:

                activation_code = generate_code()

                # Vérification de l'unicité
                if activation_code in generated_codes:
                    continue

                generated_codes.add(
                    activation_code
                )

                # --------------------------------------------------
                # Données qui seront compatibles plus tard
                # avec document_activations
                # --------------------------------------------------

                writer.writerow([
                    activation_code,
                    document_name,
                    "",
                    "",
                    False,
                    "",
                    "",
                ])

                created_for_document += 1
                total_created += 1

                # Affichage de progression
                if (
                    created_for_document % 100 == 0
                    or created_for_document == CODES_PAR_DOCUMENT
                ):
                    print(
                        f"  → {created_for_document}/"
                        f"{CODES_PAR_DOCUMENT} codes générés"
                    )

    # ======================================================
    # FIN
    # ======================================================

    print()
    print("=" * 70)
    print("GÉNÉRATION TERMINÉE")
    print("=" * 70)

    print(
        f"Total de codes générés : {total_created}"
    )

    print(
        f"Nombre de codes uniques : {len(generated_codes)}"
    )

    print()
    print(
        f"✓ Fichier créé : {OUTPUT_FILE}"
    )

    print()
    print(
        "⚠ Aucun code n'a été inséré dans PostgreSQL."
    )

    print(
        "⚠ La table document_activations n'a pas été utilisée."
    )

    print()


# ==========================================================
# POINT D'ENTRÉE
# ==========================================================

if __name__ == "__main__":
    generate_activation_codes()