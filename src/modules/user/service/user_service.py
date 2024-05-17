from  sqlalchemy import text
import json
from src.db.db import connection

class UserService():
    def __init__(self) -> None:
        self.__connection = connection
    
    def save_user(self, user: dict) -> dict:
        try:
            query = text("CALL StoreUser(:user)");
            self.__connection.execute(query, parameters={ "user": json.dumps(obj=user)}).fetchone()
            return { "message": True }
        except Exception as error:
            print(error)
            return { "message": False }