from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.ext.declarative import declarative_base
from core.config import settings


engine = create_engine(settings.DATABASE_URL,pool_pre_ping=True)
SessionLocal = sessionmaker(autocommit=False,autoflush=False,bind=engine)
Base = declarative_base()

def get_session():
    database = SessionLocal()
    try:
        yield database
    finally:
        database.close() 