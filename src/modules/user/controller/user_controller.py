from src.modules.user.service.user_service import UserService
from src.utils.hash import Hash
from src.utils.jwt import Jwt

class UserController():
    def __init__(self) -> None:
        self.__user_service = UserService()
        self.__hash = Hash()
        self.__jwt = Jwt()

    def store_user(self, user: dict) -> dict:
        try:
            hash = self.__hash.encrypt(user["password"])

            return self.__user_service.save_user({ **user, "password": hash })
        except:
            raise Exception();

    def login_user(self, credentials: dict) -> str:
        try:
            user = self.__user_service.get_user_login(credentials["email"])
            if user is None:
                raise Exception("User not found")
            compared = self.__hash.compare(encrypted=user["password"], plain=credentials["password"])
            if compared is False:
                raise Exception("User and Password not matching")
            token = self.__jwt.encode({ "id": user["id"], "role": user["role_name"] })
            return { "status": True, "Token": token }
        except Exception as error:
            return { "message": error.__str__(), "status": False }        