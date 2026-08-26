"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __rest = (this && this.__rest) || function (s, e) {
    var t = {};
    for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p) && e.indexOf(p) < 0)
        t[p] = s[p];
    if (s != null && typeof Object.getOwnPropertySymbols === "function")
        for (var i = 0, p = Object.getOwnPropertySymbols(s); i < p.length; i++) {
            if (e.indexOf(p[i]) < 0 && Object.prototype.propertyIsEnumerable.call(s, p[i]))
                t[p[i]] = s[p[i]];
        }
    return t;
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
// backend/src/server.ts
const express_1 = __importDefault(require("express"));
const cors_1 = __importDefault(require("cors"));
const path_1 = __importDefault(require("path"));
const fs_1 = require("fs");
const utils_1 = require("./utils");
const app = (0, express_1.default)();
const PORT = 8000;
// Autoriser Vite
app.use((0, cors_1.default)({ origin: "http://localhost:5173" }));
app.use(express_1.default.json());
// 👉 Servir les vidéos
app.use("/RemediationVideos", express_1.default.static(path_1.default.join(__dirname, "../RemediationVideos")));
// Chemin JSON
const questionsFilePath = path_1.default.resolve(__dirname, "../data/questions.json");
// Lecture questions
function chargerQuestions() {
    return __awaiter(this, void 0, void 0, function* () {
        try {
            const data = yield fs_1.promises.readFile(questionsFilePath, "utf-8");
            return JSON.parse(data);
        }
        catch (err) {
            console.error("❌ Erreur lecture JSON :", err);
            return [];
        }
    });
}
// --- ROUTE : /api/questions
app.get("/api/questions", (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const niveau = req.query.niveau;
    const notionsParam = req.query.notions;
    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    if (!niveau || !notionsParam) {
        return res
            .status(400)
            .json({ error: "Paramètres requis : niveau et notions" });
    }
    const notions = notionsParam.split(",");
    try {
        let questions = yield chargerQuestions();
        const filtrées = questions.filter((q) => q.niveau === niveau && notions.includes(q.notion));
        const start = (page - 1) * pageSize;
        const paged = filtrées.slice(start, start + pageSize);
        const questionsSansReponse = paged.map((_a) => {
            var { bonne_reponse } = _a, reste = __rest(_a, ["bonne_reponse"]);
            return reste;
        });
        res.json({
            total: filtrées.length,
            page,
            pageSize,
            questions: questionsSansReponse,
        });
    }
    catch (err) {
        console.error("❌ Erreur API /questions:", err);
        res.status(500).json({ error: "Erreur serveur" });
    }
}));
// --- ROUTE : /api/fake-resultats
app.get("/api/fake-resultats", (req, res) => {
    const niveau = req.query.niveau;
    const serie = req.query.serie || "";
    if (!niveau) {
        return res.status(400).json({ error: "Niveau requis" });
    }
    const notions = utils_1.notionsOrdreParNiveau[niveau];
    if (!notions) {
        return res.status(404).json({ error: "Niveau invalide" });
    }
    const note = Math.floor(Math.random() * 21);
    const mention = (0, utils_1.appreciation)(note);
    const notionsNonAcquises = (0, utils_1.choisirAleatoire)(notions, 2);
    res.json({ note, mention, notionsNonAcquises });
});
// --- Lancer serveur
app.listen(PORT, () => {
    console.log(`✅ API CODE lancée sur http://localhost:${PORT}`);
});
