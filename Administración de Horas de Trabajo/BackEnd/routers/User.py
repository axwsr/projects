from typing import List
from fastapi import APIRouter,Depends,HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.User import *
from controllers.User import get_users_all

router = APIRouter()

@router.get("/get_all_users", response_model= List[user_read])
def read_all_users_func(db:Session = Depends(get_session)):
    try:
        return get_users_all(db)
    except:
        raise HTTPException(status_code=500, detail="Ocurrio un error al traer los usuarios")
        
    