// backend/src/data/progressionStore.ts
export type NotionProgress = {
  notion: string;
  videosSeen: string[]; // ex: ["6e", "5e", "4e"]
  passedVideoTests: string[]; // niveaux validés
  passedNotionExam: boolean;
  passedControl: boolean;
  lastFailedQuestions: number[]; // IDs des questions échouées
};

export type StudentProgress = {
  studentId: string;
  classFinale: string; // ex: "3e"
  studiedNotions: NotionProgress[];
  generalExamPassed: boolean;
};

export const progressData: Record<string, StudentProgress> = {
  // Exemple initial vide, à remplir dynamiquement
};
