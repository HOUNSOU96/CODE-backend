from pydantic import BaseModel, EmailStr

class RegisterRequest(BaseModel):
    nom: str
    prenom: str
    sexe: str
    date_naissance: str
    lieu_naissance: str
    nationalite: str
    pays_residence: str
    telephone: str
    email: EmailStr
    password: str
