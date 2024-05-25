from pydantic import BaseModel, Field

from src.modules.user.schema.user_schema import Address

class Store(BaseModel):
    name: str = Field(min_length=3, max_length=20)
    description: str = Field(min_length=0, max_length=255)
    address: Address

    model_config = {
        "json_schema_extra": {
            "examples": [
                {
                    "name": "Tienda pepe",
                    "description": "Tienda para gatos",
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
