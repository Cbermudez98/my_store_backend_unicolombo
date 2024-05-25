from sqlalchemy import text
import json

from src.db.db import connection
from src.helper.parse_response_list import parse_response_dict


class StoreService():
    def __init__(self) -> None:
        self.__connection = connection
    
    def create_store(self, store: dict) -> dict:
        try:
            query = text("CALL CreateStore(:store)")
            result = self.__connection.execute(query, parameters={ "store":  json.dumps(obj=store) })
            column_names = result.keys();
            fetch = result.fetchone()
            if fetch is None:
                return None
            return parse_response_dict(column_names, fetch)
        except:
            raise Exception()