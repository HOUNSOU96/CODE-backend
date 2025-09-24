from pydantic import BaseModel, ConfigDict
from typing import Optional

class RemediationProgressCreate(BaseModel):
    notion: str
    niveau: str
    statut: Optional[str] = "incomplet"
    test_termine: Optional[bool] = False
    test_score: Optional[int] = 0
    video_actuelle_id: Optional[str] = None

    model_config = ConfigDict(from_attributes=True)

class RemediationProgressBase(BaseModel):
    notion: str
    niveau: str
    statut: Optional[str] = "incomplet"
    video_actuelle_id: Optional[str] = None
    test_score: int
    test_termine: bool

    model_config = ConfigDict(from_attributes=True)

class RemediationProgressResponse(RemediationProgressBase):
    id: int
    user_id: int

    model_config = ConfigDict(from_attributes=True)

class ProgressCheckRequest(BaseModel):
    matiere: str