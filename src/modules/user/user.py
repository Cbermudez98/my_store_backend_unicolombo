from fastapi.routing import APIRouter
from fastapi.responses import JSONResponse
from fastapi import status

from src.modules.user.schema.user_schema import User as user_schema
from src.modules.user.controller.user_controller import UserController

user_router = APIRouter(prefix="/user")
user_controller = UserController()

@user_router.post("/", response_model=dict, tags=["user"], status_code=status.HTTP_201_CREATED)
def create_user(user: user_schema):
    try:
        response = user_controller.store_user(user.model_dump())
        if response["message"] is False:
            return JSONResponse(content={ "message": "Unprocessable entity" }, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY)
        return JSONResponse(content=response, status_code=status.HTTP_201_CREATED)
    except:
        return JSONResponse(content={ "message": "Internal server error" }, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)