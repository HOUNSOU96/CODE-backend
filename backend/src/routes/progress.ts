// backend/src/routes/progress.ts

import express from "express";
import { progressData } from "../data/progressionStore";

const router = express.Router();

router.get("/:studentId", (req, res) => {
  const { studentId } = req.params;
  res.json(progressData[studentId] || null);
});

router.post("/update", (req, res) => {
  const { studentId, notion, videoLevel, testPassed, failedQuestions } = req.body;

  if (!progressData[studentId]) return res.status(404).json({ error: "Élève inconnu" });

  const notionProgress = progressData[studentId].studiedNotions.find(n => n.notion === notion);
  if (!notionProgress) return res.status(404).json({ error: "Notion inconnue" });

  if (!notionProgress.videosSeen.includes(videoLevel)) {
    notionProgress.videosSeen.push(videoLevel);
  }

  if (testPassed && !notionProgress.passedVideoTests.includes(videoLevel)) {
    notionProgress.passedVideoTests.push(videoLevel);
  }

  if (!testPassed && failedQuestions) {
    notionProgress.lastFailedQuestions = failedQuestions;
  }

  res.json({ success: true });
});

export default router;
