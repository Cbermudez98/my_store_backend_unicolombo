from fastapi.routing import APIRouter
from fastapi import status
from fastapi.responses import JSONResponse

from src.modules.town.controller.town_controller import TownController
from src.modules.town.schema.town_schema import Town as town_schema

town_router = APIRouter(prefix="/town")

town_controller = TownController()

@town_router.get("/", tags=["town"], response_model=list[town_schema], status_code=status.HTTP_200_OK)
def get_towns():
    try:
        towns = town_controller.get_all_towns();
        return JSONResponse(content=towns, status_code=status.HTTP_200_OK)
    except Exception as error:
        return JSONResponse(content={"message": "Internal server error"}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)