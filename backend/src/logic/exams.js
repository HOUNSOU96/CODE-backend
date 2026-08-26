"use strict";
// backend/src/logic/exams.ts
Object.defineProperty(exports, "__esModule", { value: true });
exports.getNotionExamQuestions = getNotionExamQuestions;
exports.getControlQuestions = getControlQuestions;
exports.getGeneralExamQuestions = getGeneralExamQuestions;
const questions_1 = require("../data/questions"); // À adapter
const helpers_1 = require("../utils/helpers");
function getNotionExamQuestions(notion, levels) {
    let questions = [];
    for (let level of levels) {
        questions.push(...(0, questions_1.getQuestionsForNotionAndLevel)(notion, level));
    }
    return (0, helpers_1.shuffle)(questions);
}
function getControlQuestions(notion1, notion2, levels) {
    let q1 = [], q2 = [];
    for (let level of levels) {
        q1.push(...(0, questions_1.getQuestionsForNotionAndLevel)(notion1, level));
        q2.push(...(0, questions_1.getQuestionsForNotionAndLevel)(notion2, level));
    }
    const halfQ1 = q1.length > 1 ? q1.slice(0, Math.floor(q1.length / 2)) : q1;
    const halfQ2 = q2.length > 1 ? q2.slice(0, Math.floor(q2.length / 2)) : q2;
    return (0, helpers_1.shuffle)([...halfQ1, ...halfQ2]);
}
function getGeneralExamQuestions(progress) {
    let allQuestions = [];
    for (let notionData of progress.studiedNotions) {
        for (let level of notionData.videosSeen) {
            const q = (0, questions_1.getQuestionsForNotionAndLevel)(notionData.notion, level);
            allQuestions.push(...q);
        }
    }
    return (0, helpers_1.shuffle)(allQuestions).slice(0, 50);
}
