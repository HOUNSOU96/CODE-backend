"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const fs_1 = __importDefault(require("fs"));
const path_1 = __importDefault(require("path"));
const router = (0, express_1.Router)();
router.get("/videos", (req, res) => {
    const filePath = path_1.default.join(__dirname, "../data/remediationVideo.json");
    fs_1.default.readFile(filePath, "utf-8", (err, data) => {
        if (err)
            return res.status(500).json({ message: "Erreur serveur" });
        res.json(JSON.parse(data));
    });
});
exports.default = router;
