// backend/src/data/questions.ts

type Question = {
  id: string;
  notion: string;
  niveau: string;
  question: string;
  options: string[];
  correctAnswerIndex: number;
};

// Exemple de questions factices, à enrichir plus tard
const questionsDatabase: Question[] = [
  {
    id: "q1",
    notion: "fractions",
    niveau: "6e",
    question: "Quelle est la fraction équivalente à 1/2 ?",
    options: ["2/4", "3/4", "1/3", "2/3"],
    correctAnswerIndex: 0,
  },
  {
    id: "q2",
    notion: "fractions",
    niveau: "5e",
    question: "Simplifie la fraction 4/8.",
    options: ["1/2", "2/4", "3/4", "4/2"],
    correctAnswerIndex: 0,
  },
  {
    id: "q3",
    notion: "algebre",
    niveau: "4e",
    question: "Quelle est la valeur de x si 2x + 3 = 7 ?",
    options: ["1", "2", "3", "4"],
    correctAnswerIndex: 1,
  },
  {
    id: "q4",
    notion: "algebre",
    niveau: "3e",
    question: "Résous l’équation: 3x - 5 = 1.",
    options: ["2", "3", "4", "5"],
    correctAnswerIndex: 0,
  },
  {
    id: "q5",
    notion: "geometrie",
    niveau: "6e",
    question: "Combien de côtés a un hexagone ?",
    options: ["5", "6", "7", "8"],
    correctAnswerIndex: 1,
  }
];

// Fonction d’accès aux questions selon notion + niveau
export function getQuestionsForNotionAndLevel(notion: string, niveau: string): Question[] {
  return questionsDatabase.filter(
    (q) => q.notion === notion && q.niveau.toLowerCase() === niveau.toLowerCase()
  );
}
