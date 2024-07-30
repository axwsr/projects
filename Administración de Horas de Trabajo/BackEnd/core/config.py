from dotenv import load_dotenv
import os

dotenv_path = os.path.join(os.path.dirname(__file__),'..','.env')
load_dotenv(dotenv_path)
ID_USER_STATIC = "08afeeaa-78ea-43e5-9f3a-0dcad6"

class Settings:
    PROJECT_NAME: str = "App-Hours-Worked"
    PROJECT_VERSION: str = "0.0.1"
    PROJECT_DESCRIPTION: str = "Aplicacion para administrar las horas trabajadas"
    
    DB_HOST: str = os.getenv("DB_HOST")
    DB_USER: str = os.getenv("DB_USER")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")
    DB_NAME: str = os.getenv("DB_NAME")
    DB_PORT: str = os.getenv("DB_PORT",3306) # por defecto

    DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

    SECRET_KEY:str = os.getenv("SECRET_KEY")
    TOKEN_EXPIRE_MIN = 1200
    ALGORITHM: str = os.getenv("ALGORITHM")
    
    CONVERT_API_SECRET:str = os.getenv("CONVERT_API_SECRET")
    ID_USER_STATIC:str = ID_USER_STATIC

settings = Settings()