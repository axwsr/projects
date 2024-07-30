from typing import List
from fastapi import APIRouter,Depends,HTTPException
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.Person import *
from controllers.Person import get_person_information

router = APIRouter()

@router.get("/get_person_information", response_model=person_base)
def get_person_info(db:Session = Depends(get_session)):
    try:
        return get_person_information(db)
    except:
        raise HTTPException(status_code=500, detail="Ocurrio un error")
        
    