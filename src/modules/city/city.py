from fastapi.routing import APIRouter
from fastapi import status
from fastapi.responses import JSONResponse

from src.modules.city.controller.city_controller import CityController

city_controller = CityController()

city_router = APIRouter(prefix="/city")

@city_router.get("/{town_id}", tags=["city"], response_model=dict, status_code=status.HTTP_200_OK)
def get_cities(town_id: int):
    try:
        city = city_controller.get_city_by_town_id(town_id);
        return JSONResponse(content=city, status_code=status.HTTP_200_OK)
    except:
        return JSONResponse(content={"message": "Internal server error"}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)