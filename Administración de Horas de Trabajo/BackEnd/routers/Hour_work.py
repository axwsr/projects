from typing import List
from fastapi import APIRouter,Depends,HTTPException
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.Hour_work import *
from controllers.Hour_work import *

router = APIRouter()

@router.post("/register_hour_work", response_model=hour_create)
def register_hour_work(data:hour_create,db:Session = Depends(get_session)):
    try:
        return create_new_hour_work(data,db)
    except:
        raise HTTPException(status_code=500, detail="Ocurrio un error")
    
@router.put("/hours_worked/{id_hour}", response_model=hour_update)
def update_hour(id_hour: int, hour: hour_update, db: Session = Depends(get_session)):
    return update_hour_work(id_hour, hour, db)

@router.get("/get_hours_worked_all", response_model=List[hour_all])
def get_hour_work_all(db:Session = Depends(get_session)):
    return get_hour_all(db)


@router.post("/get_hours_worked", response_model=List[hour_read])
def get_hours_worked(dates:hour_get,db:Session = Depends(get_session)):
    hour_works = get_hour_work_by_date(db, dates)
    return hour_works

@router.delete("/delete_hour_work/{id_hour}",response_model=hour_base)
def delete_hour(id_hour:int, db:Session = Depends(get_session)):
    return delete_hour_work(id_hour, db)    