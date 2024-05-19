from src.db.db import connection
from sqlalchemy import text
from src.helper.parse_response_list import parse_response_list_dict

class TownService():
    def __init__(self) -> None:
        self.__connection = connection;

    def get_all_towns(self):
        try:
            query = text("CALL GetAllTowns();")
            towns = self.__connection.execute(query)
            result = towns.fetchall()
            column_names = towns.keys()
            return parse_response_list_dict(column_names=column_names, result=result)
        except Exception as error:
            raise Exception();