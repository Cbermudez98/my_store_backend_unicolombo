from fastapi.routing import APIRouter
from fastapi import status

from src.modules.user.schema.user_schema import User as user_schema

user_router = APIRouter(prefix="/user")

@user_router.post("/", response_model=dict, tags=["user"], status_code=status.HTTP_201_CREATED)
def create_user(user: user_schema):
    return { "hello": "world" }