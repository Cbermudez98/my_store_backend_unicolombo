from src.modules.user.service.user_service import UserService

class UserController():
    def __init__(self) -> None:
        self.__user_service = UserService()

    def store_user(self, user: dict) -> dict:
        try:
            return self.__user_service.save_user(user);
        except:
            raise Exception();