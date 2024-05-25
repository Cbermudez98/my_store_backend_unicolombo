from typing import List
from src.modules.store.service.store_service import StoreService
from src.modules.store.service.product_service import ProductService

from src.utils.upload_file import UploadFile

class StoreController():
    def __init__(self) -> None:
        self.__store_service = StoreService()
        self.__product_service = ProductService()
        self.__upload_file = UploadFile()
    
    def save_store(self, store: dict, user_id: int) -> dict:
        try:
            res = self.__store_service.create_store({ **store, "user_id": user_id });
            if res is None:
                raise Exception("Could not save the store")
            return { "message": "Store save with success", "status": True }
        except Exception as error:
            return { "message": error.__str__(), "status": False }
        
    def save_product(self, product: dict) -> dict:
        try:
            images: List[str] = []
            for i in range(0, len(product["images"])):
                url = self.__upload_file.upload_and_get_public_url(bucket_name="products", file=product["images"][i]["file"], name="lala")
                images.append({ "url": url })
            dict_to_storage = { **product, "images": images }
            print(dict_to_storage)
            stored = self.__product_service.store_product(dict_to_storage)
            print(stored)
            if stored is None:
                raise Exception("Could not save data")
            return { "status": True, "message": "Product store with success" }
        except Exception as error:
            return { "message": error.__str__(), "status": False }