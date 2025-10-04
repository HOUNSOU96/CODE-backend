// backend/src/utils/helpers.ts

export function shuffle<T>(array: T[]): T[] {
  let currentIndex = array.length, randomIndex;

  // Tant qu'il reste des éléments à mélanger
  while (currentIndex !== 0) {
    // Prendre un élément restant au hasard
    randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // Échanger l'élément courant avec l'élément au hasard
    [array[currentIndex], array[randomIndex]] = [array[randomIndex], array[currentIndex]];
  }

  return array;
}
