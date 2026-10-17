"""Normalisation commune des types d'appareils CODE."""

MOBILE_ALIASES = {
    "mobile", "android", "ios", "iphone", "ipod",
    "blackberry", "opera mini", "iemobile",
}

TABLET_ALIASES = {
    "tablet", "ipad", "playbook", "silk",
}

DESKTOP_ALIASES = {
    "desktop", "pc", "computer", "ordinateur",
}


def normalize_device_type(value):
    """Convertit les variantes connues en catégories canoniques."""
    if not value:
        return "unknown"

    value = str(value).strip().lower()

    if value in MOBILE_ALIASES:
        return "mobile"
    if value in TABLET_ALIASES:
        return "tablet"
    if value in DESKTOP_ALIASES:
        return "desktop"

    return "unknown"


def is_mobile_device(value):
    """Indique si l'appareil est un téléphone ou une tablette."""
    return normalize_device_type(value) in {"mobile", "tablet"}


def is_supported_device(value):
    """Autorise uniquement les téléphones et les tablettes pour la lecture."""
    return normalize_device_type(value) in {"mobile", "tablet"}
