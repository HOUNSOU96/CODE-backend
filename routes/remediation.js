import express from "express";
import fs from "fs";
import path from "path";

const router = express.Router();

// Fonction pour normaliser une chaîne (minuscules, accents, espaces)
const _normalize = (str = "") =>
  str
    .toLowerCase()
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "") // retire accents
    .replace(/\s+/g, " ") // retire espaces multiples
    .trim();

router.get("/videos", (req, res) => {
  const { notions } = req.query;

  const _normalize = (str = "") =>
    str
      .toLowerCase()
      .normalize("NFD")
      .replace(/[\u0300-\u036f]/g, "")
      .replace(/\s+/g, " ")
      .trim();

  const filePath = path.join(process.cwd(), "data", "remediationVideos.json");
  const videos = JSON.parse(fs.readFileSync(filePath, "utf8"));

  if (!notions) {
    return res.json(videos);
  }

  const notionsArray = notions
    .split(",")
    .map(_normalize)
    .filter(Boolean);

  const filteredVideos = videos.filter((video) =>
    video.prerequis?.some((pr) => notionsArray.includes(_normalize(pr)))
  );

  res.json(filteredVideos);
});
