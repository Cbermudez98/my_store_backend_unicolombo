from src.db.db import connection
from sqlalchemy import text

class TownService():
    def __init__(self) -> None:
        self.__connection = connection;

    def get_all_towns(self):
        try:
            query = text("CALL GetAllTowns();")
            towns = self.__connection.execute(query)
            result = towns.fetchall()
            column_names = towns.keys()
            towns_list = [dict(zip(column_names, row)) for row in result]
            return towns_list
        except Exception as error:
            print(error)
            raise Exception();