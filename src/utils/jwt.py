import jwt
import datetime

from src.utils.environment import JWT_KEY, JWT_ALGORITHM

class Jwt():
    def __init__(self) -> None:
        self.__key = JWT_KEY
        self.__algorithm = JWT_ALGORITHM

    def encode(self,  payload: dict) -> str:
        return jwt.encode(
            { **payload, "exp": datetime.datetime.now(datetime.UTC) + datetime.timedelta(hours=24) },
            self.__key,
            algorithm=self.__algorithm
        )
    
    def decode(self, token: str) -> dict:
        return jwt.decode(token, self.__key, algorithms=[self.__algorithm])