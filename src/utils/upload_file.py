# from firebase_admin import storage
import base64
from datetime import datetime
from typing import Union
import src.db.firebase as firebase
class UploadFile():
    def __init__(self) -> None:
        self.__storage = firebase.firebase.storage()
        pass

    def upload_and_get_public_url(self, bucket_name: str, file: str, name: str) -> str:
        try:
            extension, content_type, data = self.__extract_file_info(file)
            current_time = datetime.now()
            file_name = f"{bucket_name}/{name}-{current_time}.{extension}"
            decoded = base64.b64decode(data)
            self.__storage.child(file_name).put(file=decoded, content_type=content_type)
            return self.__storage.child(file_name).get_url(token=None)
            # blob = self.__storage.blob(blob_name=file_name)
            # blob.upload_from_string(data=base64.b64decode(data), content_type=content_type)
            # blob.make_public()
            # return blob.public_url;
        except Exception as error:
            print(error)
            raise Exception("Could not upload to bucker")
    
    def __extract_file_info(self, base_64: str) -> tuple[str, str, str]:
        metadata, data = base_64.split(',', 1)
        content_type = metadata.split(':')[1].split(';')[0]
        extension = content_type.split('/')[1]
        return extension, content_type, data