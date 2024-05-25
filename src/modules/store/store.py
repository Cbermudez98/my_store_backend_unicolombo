from fastapi.routing import APIRouter
from fastapi import status, Depends, Request
from fastapi.responses import JSONResponse

from src.middlewares.jwt_middleware import verify_token
from src.middlewares.role_middleware import verify_role

from src.utils.environment import ROLE_USER, ROLE_ADMIN

from src.modules.store.schema.store_schema import Store as store_schema
from src.modules.store.schema.product_schema import Product as product_schema
from src.modules.store.controller.store_controller import StoreController

store_router = APIRouter(prefix="/store")
store_controller = StoreController()

@store_router.post("/", tags=["store"], summary="Create a new store", status_code=status.HTTP_201_CREATED, dependencies=[Depends(verify_token), Depends(verify_role([ROLE_USER]))])
def save_store(request: Request, store: store_schema):
    try:
        print(request.state.user_id, store)
        response = store_controller.save_store(store=store.model_dump(), user_id=request.state.user_id)
        if response["status"] is False:
            return JSONResponse(content=response, status_code=status.HTTP_422_UNPROCESSABLE_ENTITY)
        return JSONResponse(content=response, status_code=status.HTTP_201_CREATED)
    except:
        raise JSONResponse(content={"message": "Failed creating a store"}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)

@store_router.post("/product/{store_id}", tags=["store"], summary="Create a new product", status_code=status.HTTP_201_CREATED, dependencies=[Depends(verify_token), Depends(verify_role([ROLE_ADMIN]))])
def create_product(store_id: int, product: product_schema):
    try:
        product = {**product.model_dump(), "store_id": store_id }
        pr = store_controller.save_product(product)
        if pr["status"] is False:
            raise Exception(pr["message"])
        return JSONResponse(content=pr, status_code=status.HTTP_201_CREATED)
    except Exception as error:
        print(error)
        return JSONResponse(content={"message": "Error creating a product"}, status_code=status.HTTP_500_INTERNAL_SERVER_ERROR)