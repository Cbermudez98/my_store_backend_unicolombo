import pyrebase

from src.utils.environment import API_KEY, AUTH_DOMAIN, PROJECT_ID, STORAGE_BUCKET, MESSAGING_SENDER_ID, APP_ID, DATABASE_URL

firebase_credentials = {
    "apiKey": API_KEY,
    "authDomain": AUTH_DOMAIN,
    "projectId": PROJECT_ID,
    "storageBucket": STORAGE_BUCKET,
    "messagingSenderId": MESSAGING_SENDER_ID,
    "appId": APP_ID,
    "databaseURL": DATABASE_URL
}

firebase = pyrebase.initialize_app(config=firebase_credentials)