from schemas.User import *
from models.User import User
from sqlalchemy.orm import Session
    
def get_users_all(db:Session):
    return db.query(User).all()
    
