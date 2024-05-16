from pydantic import BaseModel, Field

class User(BaseModel):
    name: str = Field(min_length=3, max_length=20)
    last_name: str = Field(min_length=3, max_length=20)
    phone: str = Field(min_length=10, max_length=15, pattern=r'^\d+$')
    email: str = Field(min_length=8, max_length=50, pattern=r'^\S+@\S+$')
    password: str = Field(min_length=8, max_length=20)
    city_id: int = Field(max_length=2)
    street: str = Field(min_length=5, max_length=20)
    neighbor: str = Field(min_length=5, max_length=20)
    description: str = Field(min_length=0, max_length=80)

    
