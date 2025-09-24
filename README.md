# CODE — Backend (FastAPI)

Ce backend reçoit les réponses au test de positionnement niveau 3e et retourne :

- la note sur 20
- la mention correspondante
- la liste triée des notions non acquises

## ▶️ Lancer le backend

```bash
cd backend
python -m venv venv
source venv/bin/activate   # (Windows : venv\Scripts\activate)
pip install -r requirements.txt
uvicorn main:app --reload
