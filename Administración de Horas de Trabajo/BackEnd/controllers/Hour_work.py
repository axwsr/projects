from fastapi import HTTPException
from schemas.Hour_work import *
from models.Hour_work import Hour_work
from models.Company import Company
from sqlalchemy.orm import Session
from sqlalchemy import func,between
from core.config import settings
import sys
from core.utils import get_current_datetime

def create_new_hour_work(schema_create:hour_create,db:Session):
    db_hour = Hour_work(
        id_user = settings.ID_USER_STATIC,
        id_company = schema_create.id_company,
        day_worked = schema_create.day_worked,
        date_worked =  schema_create.date_worked,
        start_time =  schema_create.start_time,
        end_time =  schema_create.end_time,
        total_hours = schema_create.total_hours,
        created_at = get_current_datetime(),
    )

    try:
        db.add(db_hour)
        db.commit()
        db.refresh(db_hour)
        db.close()
        return db_hour
    except Exception as e :
        db.rollback()
        print(f"Error al registrar la hora trabajada: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"Error al registrar la hora trabajada: {str(e)} ")

def update_hour_work(id_hour: int, schema_update: hour_update, db: Session):
    db_hour = db.query(Hour_work).filter(Hour_work.id_hour_worked == id_hour).first()

    if not db_hour:
        raise HTTPException(status_code=404, detail="Registro no encontrado")

    db_hour.id_company = schema_update.id_company
    db_hour.day_worked = schema_update.day_worked
    db_hour.date_worked = schema_update.date_worked
    db_hour.start_time = schema_update.start_time
    db_hour.end_time = schema_update.end_time
    db_hour.total_hours = schema_update.total_hours
    db_hour.updated_at = get_current_datetime()

    try:
        db.commit()
        db.refresh(db_hour)
        db.close()
        return db_hour
    except Exception as e:
        db.rollback()
        print(f"Error al actualizar la hora trabajada: {str(e)}", file=sys.stderr)
        raise HTTPException(status_code=500, detail=f"Error al actualizar la hora trabajada: {str(e)}")

def delete_hour_work(id_hour:int,db:Session):
    db_hour = db.query(Hour_work).filter(Hour_work.id_hour_worked == id_hour).first()
    if db_hour is not None:
        db.delete(db_hour)
        db.commit()
        return db_hour
    else:
        raise HTTPException(status_code=404, detail=f"Hour with id {id_hour} not found")

def get_hour_work_by_date(db:Session,data:hour_get):
    return db.query(Hour_work.day_worked,Hour_work.date_worked,Hour_work.start_time,Hour_work.end_time,Company.name_company,Hour_work.total_hours).join(Company, Hour_work.id_company == Company.id_company).filter(
        Hour_work.id_user == settings.ID_USER_STATIC,
        between(Hour_work.date_worked, data.start_date, data.end_date)
    ).order_by(Hour_work.date_worked).all()

def get_hour_all(db:Session):
    return db.query(Hour_work).all()