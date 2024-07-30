from dotenv import load_dotenv
import os

# Obtener la ruta al archivo .env
dotenv_path = os.path.join(os.path.dirname(__file__),'..','.env')

# Cargar variables de entorno desde el archivo .env
load_dotenv(dotenv_path)

class Settings:
    PROJECT_NAME: str = "Barber-Shop"
    PROJECT_VERSION: str = "0.0.1"
    PROJECT_DESCRIPTION: str = "Aplicacion para administrar los ingresos de una barberia"
    
    DB_HOST: str = os.getenv("DB_HOST")
    DB_USER: str = os.getenv("DB_USER")
    DB_PASSWORD: str = os.getenv("DB_PASSWORD")
    DB_NAME: str = os.getenv("DB_NAME")
    DB_PORT: str = os.getenv("DB_PORT",3306) # por defecto

    DATABASE_URL = f"mysql+pymysql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"

    SECRET_KEY:str = os.getenv("SECRET_KEY")
    TOKEN_EXPIRE_MIN = 1200
    ALGORITHM: str = os.getenv("ALGORITHM")

settings = Settings()