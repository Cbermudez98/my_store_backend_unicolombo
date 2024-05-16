from sqlalchemy import create_engine, text
from src.utils.environment import parameter_store

DATABASE_URL = f"mysql+pymysql://{parameter_store["DB_USER"]}:{parameter_store["DB_PASSWORD"]}@{parameter_store["DB_HOST"]}:{parameter_store["DB_PORT"]}/{parameter_store["DB_NAME"]}"

engine = create_engine(url=DATABASE_URL)

connection = engine.connect();