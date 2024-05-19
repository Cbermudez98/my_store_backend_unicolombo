from sqlalchemy import text
from src.db.db import connection

from src.helper.parse_response_list import parse_response_list_dict

class CityService():
    def __init__(self) -> None:
        self.__connection = connection

    def get_city_by_town_id(self, id: int) -> dict:
        try:
            query = text("CALL GetCityByTownId(:id)")
            response = self.__connection.execute(query, parameters=[{ "id": id }])
            result = response.fetchall()
            columns_name = response.keys()
            return parse_response_list_dict(column_names=columns_name, result=result)
        except Exception as error:
            raise Exception()
