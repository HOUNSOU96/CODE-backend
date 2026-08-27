from pydantic import BaseModel, EmailStr
from typing import Optional
from datetime import datetime

class RegisterRequest(BaseModel):
    nom: str
    prenom: str
    sexe: str
    date_naissance: datetime
    lieu_naissance: str
    nationalite: str
    pays_residence: str
    telephone: str
    email: EmailStr
    password: str
    parrain_email: Optional[EmailStr] = None