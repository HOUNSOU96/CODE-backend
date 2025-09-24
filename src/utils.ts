// backend/src/utils.ts

export const notionsOrdreParNiveau: Record<string, string[]> = {
  "6e": ["Nombres entiers", "Additions", "Soustractions", "Multiplications", "Divisions", "Fractions", "Géométrie de base", "Mesures"],
  "5e": ["Arithmétique", "Fractions", "Proportionnalité", "Symétrie axiale", "Géométrie", "Périmètres et aires", "Volumes", "Angles"],
  "4e": ["Arithmétique", "Calcul littéral", "Équations", "Fonctions", "Géométrie", "Aires", "Volumes", "Proportionnalité", "Statistiques"],
  "3e": ["Arithmétique", "Divisibilité", "Calcul littéral", "Équations", "Fonctions", "Géométrie", "Aires", "Volumes", "Proportionnalité", "Statistiques", "Probabilités", "Théorèmes (Thalès, Pythagore)"],
  "2nde": ["Nombres et calculs", "Fonctions", "Statistiques", "Géométrie", "Équations et inéquations", "Vecteurs", "Produits scalaires"],
  "1ere": ["Fonctions (affine, carré, inverse, racine)", "Suites numériques", "Probabilités", "Statistiques", "Trigonométrie", "Dérivation", "Géométrie analytique"],
  "Terminale": ["Fonctions (logarithmes, exponentielles)", "Limites et continuité", "Dérivées et variations", "Suites", "Probabilités conditionnelles", "Loi binomiale et loi normale", "Géométrie dans l'espace", "Calcul intégral"],
};

export function choisirAleatoire<T>(arr: T[], n: number): T[] {
  const copie = [...arr];
  const result: T[] = [];
  for (let i = 0; i < n && copie.length > 0; i++) {
    const index = Math.floor(Math.random() * copie.length);
    result.push(copie.splice(index, 1)[0]);
  }
  return result;
}

export function appreciation(note: number): string {
  if (note >= 18) return "Excellent travail, continue comme ça !";
  if (note >= 16) return "Très Bien, bravo !";
  if (note >= 14) return "Bon travail, tu progresses bien.";
  if (note >= 12) return "Assez bien, mais tu peux faire mieux.";
  if (note >= 10) return "Passable, il faut un peu plus d’efforts.";
  if (note >= 7) return "Insuffisant, il faut revoir les notions importantes.";
  return "Très insuffisant, il faut beaucoup travailler.";
}
