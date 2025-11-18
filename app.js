const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

// Mot de passe admin caché côté serveur
const ADMIN_CODE = "MOraVi";

app.post("/api/check-admin", (req, res) => {
  const { password } = req.body;

  if (password === ADMIN_CODE) {
    // Accès autorisé
    res.json({ access: true });
  } else {
    // Accès refusé
    res.status(401).json({ access: false, message: "Mot de passe incorrect" });
  }
});

// Test
app.get("/", (req, res) => res.send("Backend admin OK"));

const PORT = process.env.PORT || 8000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
