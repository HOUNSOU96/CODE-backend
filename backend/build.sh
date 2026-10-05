#!/usr/bin/env bash

set -e

echo "=============================================="
echo "CODE BACKEND — BUILD RENDER"
echo "=============================================="

echo "📦 Installation des dépendances Python..."
pip install -r requirements.txt

# ============================================================
# TYPST
# ============================================================

TYPST_VERSION="0.15.1"
TYPST_DIR="$HOME/.local/bin"
TYPST_ARCHIVE="/tmp/typst.tar.xz"
TYPST_URL="https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz"

echo "📄 Installation de Typst ${TYPST_VERSION}..."

mkdir -p "$TYPST_DIR"

if [ ! -x "$TYPST_DIR/typst" ]; then

    echo "⬇️ Téléchargement de Typst ${TYPST_VERSION}..."

    curl -L \
        "$TYPST_URL" \
        -o "$TYPST_ARCHIVE"

    echo "📦 Extraction de Typst..."

    rm -rf "/tmp/typst-x86_64-unknown-linux-musl"

    tar -xJf \
        "$TYPST_ARCHIVE" \
        -C /tmp

    cp \
        "/tmp/typst-x86_64-unknown-linux-musl/typst" \
        "$TYPST_DIR/typst"

    chmod +x "$TYPST_DIR/typst"

fi

# Ajouter Typst au PATH pour le reste du build
export PATH="$TYPST_DIR:$PATH"

echo "🔎 Vérification de Typst..."

which typst
typst --version

# ============================================================
# ARGOS TRANSLATE
# ============================================================

echo "🌍 Mise à jour de l'index Argos Translate..."
argospm update

echo "🇫🇷 → 🇬🇧 Installation du modèle French → English..."
argospm install translate-fr_en

echo "=============================================="
echo "✅ Build terminé"
echo "=============================================="
