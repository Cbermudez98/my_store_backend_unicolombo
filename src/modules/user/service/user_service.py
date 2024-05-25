import json
from  sqlalchemy import text
from sqlalchemy.exc import NoResultFound
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
    
    def get_user_login(self, email: str, is_admin: int) -> dict:
        try:
            query = text("CALL GetUserLogin(:email, :is_admin)");
            print({ "email": email, "is_admin": is_admin })
            response = self.__connection.execute(query, parameters={ "email": email, "is_admin": is_admin })
            column_names = response.keys()
            fetch = response.fetchone()
            if fetch is None:
                return None
            res = parse_response_dict(column_names, fetch)
            return res 
        except Exception as error:
            raise Exception()