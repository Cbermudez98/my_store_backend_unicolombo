from sqlalchemy import text
import json

from src.db.db import connection
from src.helper.parse_response_list import parse_response_dict


class ProductService():
    def __init__(self) -> None:
        self.__connection = connection

    def store_product(self, product: dict) -> dict:
        try:
            query = text("CALL CreateProduct(:product)")
            result = self.__connection.execute(query, parameters={"product": json.dumps(obj=product)})
            colum_names = result.keys()
            fetch = result.fetchone()
            if fetch is None:
                return None
            return parse_response_dict(column_names=colum_names, result=fetch)
        except Exception as error:
            print(error)
            raise Exception("Could not save the product")