from fastapi import Request, HTTPException, status

def verify_role(roles: list[str]):
    def hello(request: Request):
        try:
            role = request.state.role
            print(role, roles)
            if roles.count(role) == 0:
                raise HTTPException(status_code=status.HTTP_403_FORBIDDEN)
            return True
        except:
            raise HTTPException(status_code=status.HTTP_403_FORBIDDEN)
    return hello