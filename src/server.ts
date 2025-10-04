// backend/src/server.ts
import express from "express";
import cors from "cors";
import path from "path";
import { promises as fs } from "fs";
import {
  notionsOrdreParNiveau,
  choisirAleatoire,
  appreciation,
} from "./utils";

const app = express();
const PORT = 8000;

// Autoriser Vite
app.use(cors({ origin: "http://localhost:5173" }));
app.use(express.json());

// 👉 Servir les vidéos
app.use(
  "/RemediationVideos",
  express.static(path.join(__dirname, "../RemediationVideos"))
);

// Type Question
type Question = {
  id: string;
  question: string;
  niveau: string;
  serie?: string;
  notion: string;
  options: string[];
  bonne_reponse: string;
  duration?: number;
  situation?: { texte: string; image: string };
};

// Chemin JSON
const questionsFilePath = path.resolve(__dirname, "../data/questions.json");

// Lecture questions
async function chargerQuestions(): Promise<Question[]> {
  try {
    const data = await fs.readFile(questionsFilePath, "utf-8");
    return JSON.parse(data) as Question[];
  } catch (err) {
    console.error("❌ Erreur lecture JSON :", err);
    return [];
  }
}

// --- ROUTE : /api/questions
app.get("/api/questions", async (req, res) => {
  const niveau = req.query.niveau as string;
  const notionsParam = req.query.notions as string;
  const page = parseInt(req.query.page as string) || 1;
  const pageSize = parseInt(req.query.pageSize as string) || 10;

  if (!niveau || !notionsParam) {
    return res
      .status(400)
      .json({ error: "Paramètres requis : niveau et notions" });
  }

  const notions = notionsParam.split(",");

  try {
    let questions = await chargerQuestions();

    const filtrées = questions.filter(
      (q) => q.niveau === niveau && notions.includes(q.notion)
    );

    const start = (page - 1) * pageSize;
    const paged = filtrées.slice(start, start + pageSize);

    const questionsSansReponse = paged.map(({ bonne_reponse, ...reste }) => reste);

    res.json({
      total: filtrées.length,
      page,
      pageSize,
      questions: questionsSansReponse,
    });
  } catch (err) {
    console.error("❌ Erreur API /questions:", err);
    res.status(500).json({ error: "Erreur serveur" });
  }
});

// --- ROUTE : /api/fake-resultats
app.get("/api/fake-resultats", (req, res) => {
  const niveau = req.query.niveau as string;
  const serie = (req.query.serie as string) || "";

  if (!niveau) {
    return res.status(400).json({ error: "Niveau requis" });
  }

  const notions = notionsOrdreParNiveau[niveau];
  if (!notions) {
    return res.status(404).json({ error: "Niveau invalide" });
  }

  const note = Math.floor(Math.random() * 21);
  const mention = appreciation(note);
  const notionsNonAcquises = choisirAleatoire(notions, 2);

  res.json({ note, mention, notionsNonAcquises });
});

// --- Lancer serveur
app.listen(PORT, () => {
  console.log(`✅ API CODE lancée sur http://localhost:${PORT}`);
});
