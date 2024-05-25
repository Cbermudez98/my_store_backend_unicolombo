
from dotenv import load_dotenv

from os import getenv
load_dotenv()

DB_HOST = getenv("DB_HOST", default="test")
DB_NAME = getenv("DB_NAME", default="test")
DB_USER = getenv("DB_USER", default="test")
DB_PASSWORD = getenv("DB_PASSWORD", default="test")
DB_PORT = getenv("DB_PORT", default="test")

JWT_KEY = getenv("JWT_KEY", default="test")
JWT_ALGORITHM = getenv("JWT_ALGORITHM", default="test")

ROLE_ADMIN = "admin"
ROLE_USER = "user"


API_KEY=getenv("API_KEY", default="test")
AUTH_DOMAIN=getenv("AUTH_DOMAIN", default="test")
PROJECT_ID=getenv("PROJECT_ID", default="test")
STORAGE_BUCKET=getenv("STORAGE_BUCKET", default="test")
MESSAGING_SENDER_ID=getenv("MESSAGING_SENDER_ID", default="test")
APP_ID=getenv("APP_ID", default="test")
DATABASE_URL=getenv("DATABASE_URL", default="test")
