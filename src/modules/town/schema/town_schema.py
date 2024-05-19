from pydantic import BaseModel

class Town(BaseModel):
    id: int
    name: str
