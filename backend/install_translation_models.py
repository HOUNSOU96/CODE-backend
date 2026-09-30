import os
import tempfile
import urllib.request

import argostranslate.package
import argostranslate.translate


MODEL_URL = "https://argos-net.com/v1/translate-fr_en-1_9.argosmodel"


def model_deja_installe():
    langues = argostranslate.translate.get_installed_languages()

    langue_source = next(
        (langue for langue in langues if langue.code == "fr"),
        None
    )

    langue_cible = next(
        (langue for langue in langues if langue.code == "en"),
        None
    )

    if langue_source is None or langue_cible is None:
        return False

    traduction = langue_source.get_translation(langue_cible)

    return traduction is not None


def installer_modele():
    if model_deja_installe():
        print("✅ Modèle French → English déjà installé.")
        return

    print("📦 Modèle French → English absent.")
    print("⬇️ Téléchargement du modèle Argos...")

    chemin_modele = None

    try:
        with tempfile.NamedTemporaryFile(
            suffix=".argosmodel",
            delete=False
        ) as fichier_temp:
            chemin_modele = fichier_temp.name

        urllib.request.urlretrieve(
            MODEL_URL,
            chemin_modele
        )

        print("✅ Modèle téléchargé.")
        print("📥 Installation du modèle...")

        argostranslate.package.install_from_path(
            chemin_modele
        )

        print("✅ Modèle French → English installé.")

    finally:
        if chemin_modele and os.path.exists(chemin_modele):
            os.remove(chemin_modele)


if __name__ == "__main__":
    try:
        installer_modele()
        print("🎉 Installation Translation terminée.")

    except Exception as e:
        print(
            f"❌ Échec de l'installation du modèle Translation : {e}"
        )
        raise
