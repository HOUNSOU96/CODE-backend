// backend/src/logic/exams.ts

import { getQuestionsForNotionAndLevel } from "../data/questions"; // À adapter
import { shuffle } from "../utils/helpers";
import { StudentProgress } from "../data/progressionStore";

export function getNotionExamQuestions(notion: string, levels: string[]) {
  let questions: any[] = [];
  for (let level of levels) {
    questions.push(...getQuestionsForNotionAndLevel(notion, level));
  }
  return shuffle(questions);
}

export function getControlQuestions(notion1: string, notion2: string, levels: string[]) {
  let q1: any[] = [], q2: any[] = [];
  for (let level of levels) {
    q1.push(...getQuestionsForNotionAndLevel(notion1, level));
    q2.push(...getQuestionsForNotionAndLevel(notion2, level));
  }

  const halfQ1 = q1.length > 1 ? q1.slice(0, Math.floor(q1.length / 2)) : q1;
  const halfQ2 = q2.length > 1 ? q2.slice(0, Math.floor(q2.length / 2)) : q2;

  return shuffle([...halfQ1, ...halfQ2]);
}

export function getGeneralExamQuestions(progress: StudentProgress) {
  let allQuestions: any[] = [];

  for (let notionData of progress.studiedNotions) {
    for (let level of notionData.videosSeen) {
      const q = getQuestionsForNotionAndLevel(notionData.notion, level);
      allQuestions.push(...q);
    }
  }

  return shuffle(allQuestions).slice(0, 50);
}
