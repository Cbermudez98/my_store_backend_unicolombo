import bcrypt

class Hash():
    def __init__(self) -> None:
        self.__salt = bcrypt.gensalt()

    def encrypt(self, password: str) -> str:
        bytes = password.encode("utf-8")
        return bcrypt.hashpw(password=bytes, salt=self.__salt).decode("utf-8")
    
    def compare(self, encrypted: str, plain: str) -> bool:
        bytes = plain.encode("utf-8")
        byted_encrypted = encrypted.encode("utf-8")
        return bcrypt.checkpw(password=bytes, hashed_password=byted_encrypted)