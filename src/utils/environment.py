from os import getenv

parameter_store = {
    "DB_HOST": getenv("DB_HOST") if not None else "test",
    "DB_NAME": getenv("DB_NAME") if  not None else "test",
    "DB_USER": getenv("DB_USER") if not None else "test",
    "DB_PASSWORD": getenv("DB_PASSWORD") if not None else "test",
    "DB_PORT": getenv("DB_PORT") if not None else "test"
}