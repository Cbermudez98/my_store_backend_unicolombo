from pydantic import BaseModel, Field

class Address(BaseModel):
    city_id: int = Field(gt=0, lt=100)
    street: str = Field(min_length=5, max_length=20)
    neighbor: str = Field(min_length=5, max_length=20)
    description: str = Field(min_length=0, max_length=80)

class User(BaseModel):
    name: str = Field(min_length=3, max_length=20)
    last_name: str = Field(min_length=3, max_length=20)
    phone: str = Field(min_length=9, max_length=15, pattern=r'^\d+$')
    email: str = Field(min_length=8, max_length=50, pattern=r'^\S+@\S+$')
    password: str = Field(min_length=8, max_length=20)
    address: Address

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "name": "Jane",
                    "last_name": "Doe",
                    "phone": "3121234567",
                    "email": "jane@doe.com",
                    "password": "password123",
                    "address": {
                        "city_id": 1,
                        "street": "San Fernando",
                        "neighbor": "Olaya",
                        "description": "Cerca a la tienda de doña juana"
                    }
                }
            ]
        }
    }

class Login(BaseModel):
    email: str = Field(min_length=8, max_length=50, pattern=r'^\S+@\S+$')
    password: str = Field(min_length=8, max_length=20)

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "email": "user@user.com",
                    "password": "password123",
                },
                {
                    "email": "admin@admin.com",
                    "password": "password123",
                }
            ]
        }
    }
    
