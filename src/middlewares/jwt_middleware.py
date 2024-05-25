from fastapi import HTTPException, Header, status, Request
from src.utils.jwt import Jwt

jwt = Jwt()

def verify_token(request: Request, auth: str = Header("Authorization", description="Jwt token", example="Bearer token")):
    try:
        token = auth.split(" ")[1]
        if not token:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)
        print("token", token)
        valid = jwt.decode(token)
        print(valid)
        if not valid:
            raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)
        request.state.user_id = valid.get("id")
        request.state.role = valid.get("role")
    except:
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)

