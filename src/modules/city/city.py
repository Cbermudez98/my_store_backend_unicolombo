from fastapi.routing import APIRouter
from fastapi import status

city_router = APIRouter(prefix="/city")

@city_router.get("/{town_id}", tags=["city"], response_model=dict, status_code=status.HTTP_200_OK)
def get_cities(town_id: int):
    return {};