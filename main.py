# import firebase_admin
import json
# import pyrebase
import src.db.firebase

from fastapi import FastAPI, status
from fastapi.responses import JSONResponse

from src.modules.user.user import user_router
from src.modules.city.city import city_router
from src.modules.town.town import town_router
from src.modules.store.store import store_router



app = FastAPI()

app.include_router(router=user_router)
app.include_router(router=city_router)
app.include_router(router=town_router)
app.include_router(router=store_router)

@app.get("/ping", summary="Get a status if system is up", response_model=dict, tags=["ping"], status_code=status.HTTP_200_OK)
def pong():
    return JSONResponse(content={"message": "pong"})