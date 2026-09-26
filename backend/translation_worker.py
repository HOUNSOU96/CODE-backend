import json
import sys

import argostranslate.package
import argostranslate.translate


def trouver_traduction(source_code: str, target_code: str):
    """
    Recherche explicitement le modèle de traduction source -> cible.
    """
    langues = argostranslate.translate.get_installed_languages()

    langue_source = next(
        (langue for langue in langues if langue.code == source_code),
        None
    )

    langue_cible = next(
        (langue for langue in langues if langue.code == target_code),
        None
    )

    if langue_source is None:
        raise RuntimeError(
            f"Langue source '{source_code}' non installée."
        )

    if langue_cible is None:
        raise RuntimeError(
            f"Langue cible '{target_code}' non installée."
        )

    traduction = langue_source.get_translation(langue_cible)

    if traduction is None:
        raise RuntimeError(
            f"Aucun modèle de traduction disponible pour "
            f"{source_code} -> {target_code}."
        )

    return traduction


def main():
    try:
        payload = json.load(sys.stdin)

        source_language = payload.get("source_language", "fr")
        target_language = payload.get("target_language", "en")
        texts = payload.get("texts", [])

        if not isinstance(texts, list):
            raise ValueError(
                "Le champ 'texts' doit être une liste."
            )

        traduction = trouver_traduction(
            source_language,
            target_language
        )

        translations = []

        for text in texts:

            if not isinstance(text, str):
                translations.append("")
                continue

            if not text.strip():
                translations.append(text)
                continue

            try:
                translated = traduction.translate(text)
                translations.append(translated)

            except Exception as e:
                # Si un texte particulier pose problème,
                # on conserve le texte original plutôt que
                # de faire échouer toute la page.
                print(
                    f"⚠️ Erreur sur le texte : {repr(text[:200])} -> {e}",
                    file=sys.stderr
                )
                translations.append(text)

        result = {
            "success": True,
            "source_language": source_language,
            "target_language": target_language,
            "translations": translations
        }

        print(
            json.dumps(
                result,
                ensure_ascii=False
            )
        )

    except Exception as e:

        result = {
            "success": False,
            "error": str(e)
        }

        print(
            json.dumps(
                result,
                ensure_ascii=False
            )
        )

        sys.exit(1)


if __name__ == "__main__":
    main()