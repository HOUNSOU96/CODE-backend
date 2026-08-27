"use strict";
// backend/src/routes/progress.ts
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const progressionStore_1 = require("../data/progressionStore");
const router = express_1.default.Router();
router.get("/:studentId", (req, res) => {
    const { studentId } = req.params;
    res.json(progressionStore_1.progressData[studentId] || null);
});
router.post("/update", (req, res) => {
    const { studentId, notion, videoLevel, testPassed, failedQuestions } = req.body;
    if (!progressionStore_1.progressData[studentId])
        return res.status(404).json({ error: "Élève inconnu" });
    const notionProgress = progressionStore_1.progressData[studentId].studiedNotions.find(n => n.notion === notion);
    if (!notionProgress)
        return res.status(404).json({ error: "Notion inconnue" });
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
exports.default = router;
