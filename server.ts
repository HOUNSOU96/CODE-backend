// 📁 server.ts
import express from "express";
import cors from "cors";
import { connectDB } from "./database";

const app = express();
app.use(cors());
app.use(express.json());

app.get("/", (req, res) => {
  res.send("🚀 Backend CODE fonctionne !");
});

// Exemple de route qui teste MySQL
app.get("/api/test-db", async (req, res) => {
  try {
    const db = await connectDB();
    const [rows] = await db.query("SELECT NOW() AS date");
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: "Erreur de connexion MySQL" });
  }
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`🚀 Serveur lancé sur http://localhost:${PORT}`);
});
