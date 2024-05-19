from src.modules.town.service.town_service import TownService

class TownController():
    def __init__(self) -> None:
        self.__town_service = TownService()
    
    def get_all_towns(self):
        return self.__town_service.get_all_towns()