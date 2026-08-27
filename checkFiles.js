const fs = require("fs");
const path = require("path");

const BASE_DIR = path.resolve(__dirname);
const SIZE_THRESHOLD_MB = 5; // Seuil de taille en Mo
const gitignorePath = path.join(BASE_DIR, ".gitignore");

let gitignoreEntries = [
  "# Node",
  "node_modules/",
  "dist/",
  "build/",
  "",
  "# Logs",
  "*.log",
  "",
  "# Env",
  ".env",
  "",
  "# Système",
  ".DS_Store",
  "Thumbs.db",
  "",
  "# Fichiers lourds détectés automatiquement"
];

// Fonction pour parcourir les fichiers
function scanDir(dir) {
  const files = fs.readdirSync(dir);
  for (const file of files) {
    const fullPath = path.join(dir, file);
    const stats = fs.statSync(fullPath);

    if (stats.isDirectory()) {
      scanDir(fullPath);
    } else {
      const sizeMB = stats.size / (1024 * 1024);
      if (sizeMB > SIZE_THRESHOLD_MB) {
        console.log(`⚠️ Fichier lourd (>${SIZE_THRESHOLD_MB}Mo) : ${fullPath} (${sizeMB.toFixed(2)} Mo)`);

        // Ajouter le chemin relatif au .gitignore
        let relativePath = path.relative(BASE_DIR, fullPath).replace(/\\/g, "/");
        gitignoreEntries.push(relativePath);
      }
    }
  }
}

// Exécution
scanDir(BASE_DIR);

// Écriture dans .gitignore
fs.writeFileSync(gitignorePath, gitignoreEntries.join("\n"), "utf-8");
console.log(`\n✅ .gitignore généré avec les fichiers lourds détectés.`);
