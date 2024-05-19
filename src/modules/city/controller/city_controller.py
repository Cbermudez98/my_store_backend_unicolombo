from src.modules.city.service.city_service import CityService

class CityController():
    def __init__(self) -> None:
        self.__city_service = CityService()
        pass

    def get_city_by_town_id(self, id: int) -> dict:
        try:
            return self.__city_service.get_city_by_town_id(id)
        except:
            raise Exception()