import json
from  sqlalchemy import text
from src.db.db import connection
from src.helper.parse_response_list import parse_response_dict

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
    
    def get_user_login(self, email: str) -> dict:
        try:
            query = text("CALL GetUserLogin(:email)");
            response = self.__connection.execute(query, parameters={ "email": email })
            column_names = response.keys()
            fetch = response.fetchone()
            res = parse_response_dict(column_names, fetch)
            print(res)
            return res 
        except Exception as error:
            raise Exception()