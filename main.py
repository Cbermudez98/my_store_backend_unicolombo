from fastapi import FastAPI, status
from fastapi.responses import JSONResponse
from dotenv import load_dotenv

from src.modules.user.user import user_router
from src.modules.city.city import city_router
from src.modules.town.town import town_router

config = load_dotenv()
app = FastAPI()

app.include_router(router=user_router)
app.include_router(router=city_router)
app.include_router(router=town_router)

@app.get("/ping", response_model=dict, tags=["ping"], status_code=status.HTTP_200_OK)
def pong():
    return JSONResponse(content={"message": "pong"})