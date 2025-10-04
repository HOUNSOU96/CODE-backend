import { Router } from "express";
import fs from "fs";
import path from "path";

const router = Router();

router.get("/videos", (req, res) => {
  const filePath = path.join(__dirname, "../data/remediationVideo.json");
  fs.readFile(filePath, "utf-8", (err, data) => {
    if (err) return res.status(500).json({ message: "Erreur serveur" });
    res.json(JSON.parse(data));
  });
});

export default router;
