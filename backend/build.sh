#!/usr/bin/env bash

set -e

echo "=============================================="
echo "CODE BACKEND — BUILD RENDER"
echo "=============================================="

echo "📦 Installation des dépendances Python..."
pip install -r requirements.txt

echo "🌍 Mise à jour de l'index Argos Translate..."
argospm update

echo "🇫🇷 → 🇬🇧 Installation du modèle French → English..."
argospm install translate-fr_en

echo "=============================================="
echo "✅ Build terminé"
echo "=============================================="
