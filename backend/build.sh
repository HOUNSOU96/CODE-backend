#!/usr/bin/env bash

set -e

echo "=============================================="
echo "CODE BACKEND — BUILD RENDER"
echo "=============================================="

# ============================================================
# RÉPERTOIRE DU BACKEND
# ============================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "📁 Backend : $SCRIPT_DIR"

# ============================================================
# DÉPENDANCES PYTHON
# ============================================================

echo "📦 Installation des dépendances Python..."

pip install -r "$SCRIPT_DIR/requirements.txt"

# ============================================================
# TYPST
# ============================================================

TYPST_VERSION="0.15.1"

TYPST_DIR="$SCRIPT_DIR/.tools"
TYPST_BINARY="$TYPST_DIR/typst"
TYPST_ARCHIVE="/tmp/typst.tar.xz"

TYPST_URL="https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz"

echo "=============================================="
echo "📄 INSTALLATION DE TYPST"
echo "=============================================="

echo "📌 Version : $TYPST_VERSION"
echo "📁 Répertoire : $TYPST_DIR"
echo "📄 Binaire : $TYPST_BINARY"

mkdir -p "$TYPST_DIR"

if [ ! -x "$TYPST_BINARY" ]; then

    echo "⬇️ Téléchargement de Typst ${TYPST_VERSION}..."

    curl -L \
        "$TYPST_URL" \
        -o "$TYPST_ARCHIVE"

    echo "📦 Extraction de Typst..."

    rm -rf "/tmp/typst-x86_64-unknown-linux-musl"

    tar -xJf \
        "$TYPST_ARCHIVE" \
        -C /tmp

    echo "📋 Copie du binaire Typst..."

    cp \
        "/tmp/typst-x86_64-unknown-linux-musl/typst" \
        "$TYPST_BINARY"

    chmod +x "$TYPST_BINARY"

else

    echo "✅ Typst est déjà installé."

fi

# ============================================================
# AJOUT DE TYPST AU PATH
# ============================================================

export PATH="$TYPST_DIR:$PATH"

# ============================================================
# VÉRIFICATION TYPST
# ============================================================

echo "=============================================="
echo "🔎 VÉRIFICATION DE TYPST"
echo "=============================================="

echo "📁 Fichier :"

ls -lh "$TYPST_BINARY"

echo "🔹 Version directe :"

"$TYPST_BINARY" --version

echo "🔹 Localisation via PATH :"

which typst

echo "🔹 Version via PATH :"

typst --version

# ============================================================
# ARGOS TRANSLATE
# ============================================================

echo "=============================================="
echo "🌍 ARGOS TRANSLATE"
echo "=============================================="

echo "🌍 Mise à jour de l’index Argos Translate..."

argospm update

echo "🇫🇷 → 🇬🇧 Installation du modèle French → English..."

argospm install translate-fr_en

# ============================================================
# FIN
# ============================================================

echo "=============================================="
echo "✅ BUILD TERMINÉ"
echo "=============================================="

echo "📁 Typst installé ici :"
echo "$TYPST_BINARY"

echo "=============================================="