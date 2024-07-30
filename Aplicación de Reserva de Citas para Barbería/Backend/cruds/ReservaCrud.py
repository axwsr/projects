import sys

from fastapi import HTTPException
from schemas.ReservaSh import *
from models.ReservaM import Reserva
from sqlalchemy.orm import Session
from sqlalchemy import asc,between
from datetime import date,time
from datetime import datetime
from core.utils import get_list_reserve,sort_object_by_index,get_current_date
list_reserve = get_list_reserve()
def create_new_reserve(reserve:ReserveCreate, id_usuario:str,created_at:datetime,db:Session):
    isExistReserve = get_reserve_by_time_date(reserve.hora,reserve.fecha,id_usuario,db)
    if isExistReserve != None:
        raise HTTPException(status_code=409, detail="Conflict:The reserve already exist.")
    db_reserve = Reserva(
        id_usuario = id_usuario,
        cliente = reserve.cliente,
        fecha = reserve.fecha,
        hora = reserve.hora,
        created_at = created_at
    )

    try:
        db.add(db_reserve)
        db.commit()
        db.refresh(db_reserve)
        db.close()

        return db_reserve
    except Exception as e:
        db.rollback()
        print(f"error creating reserve: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"error creating reserve: {str(e)}")
    
def update_reserve(reserve:ReserveUpdate, user_id:str, db:Session):
    reserve_db = get_reserve_by_id(reserve.id_reserva, user_id, db)
    if reserve_db.estado_reserva == 0:
        isExistReserve = get_reserve_by_time_date(reserve.hora,reserve.fecha,user_id,db)
        if isExistReserve != None:
            raise HTTPException(status_code=409, detail="Conflict:The reserve already exist.")
        try:
            reserve_db.cliente = reserve.cliente
            reserve_db.fecha = reserve.fecha
            reserve_db.hora = reserve.hora
            db.add(reserve_db)
            db.commit()
            db.refresh(reserve_db)
            db.close()

            return reserve_db
        except Exception as e:
            db.rollback()
            print(f"error updating reserve: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"error updating reserve: {str(e)} ")
    else:
        return None
    
def update_reserve_tarifa(reserve:ReserveUpdateTarifa, user_id:str, db:Session):
    reserve_db = get_reserve_by_id(reserve.id_reserva, user_id, db)
    if reserve_db:
        try:
            reserve_db.estado_reserva = 1
            reserve_db.id_tarifa = reserve.id_tarifa

            db.add(reserve_db)
            db.commit()
            db.refresh(reserve_db)
            db.close()

            return reserve_db
        except Exception as e:
            db.rollback()
            print(f"error updating reserve: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"error updating reserve: {str(e)} ")
    else:
        return None
    

def get_reserve_by_id(id_reserve:int, user_id:str, db:Session):
    reserve_db = db.query(Reserva).filter((Reserva.id_reserva == id_reserve) & (Reserva.id_usuario == user_id)  ).first()
    return reserve_db

def get_reserve_by_time_date(time:time,date:date, user_id:str, db:Session):
    reserve_db = db.query(Reserva).filter(
        Reserva.hora == time,
        Reserva.fecha == date,
        Reserva.estado_reserva < 2,
        Reserva.id_usuario == user_id
    ).first()
    if reserve_db is None:
        return None
    return reserve_db

def update_status_reserve(reserve:ReserveUpdateStatus,db:Session,id_user:str):
    reserve_db = get_reserve_by_id(reserve.id_reserva,id_user,db)
    if reserve_db:
        try:
            reserve_db.estado_reserva = reserve.estado_reserva
            db.add(reserve_db)
            db.commit()
            return reserve_db

        except Exception as e:
            db.rollback()
            print(f"Error al update una reserva {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al update una reserva: {str(e)} ")
    raise HTTPException(status_code=500,detail="No se encontro nada")




def get_reserve_false(id_user:str,db):
    fecha = get_current_date()
    reserve_db = db.query(Reserva).filter((Reserva.id_usuario == id_user ) & (Reserva.fecha == fecha) & (Reserva.estado_reserva == 0)).order_by(asc(Reserva.hora)).all()
    return reserve_db

def get_reserve_all(id_user:str,db,fecha_inicio:date = None,fecha_fin:date = None):
    if fecha_inicio is None or fecha_fin is None:
        fecha_inicio = get_current_date()
        fecha_fin = get_current_date()
        
    reserve_db = db.query(Reserva).filter(
        Reserva.id_usuario == id_user, 
        between(Reserva.fecha, fecha_inicio, fecha_fin)
    ).order_by(asc(Reserva.hora)).all()
    
    return reserve_db

def get_reservations_by_date(id_user:str,db,fecha:date = None): 
    if (fecha is None): fecha = get_current_date()
    reservations_db = db.query(Reserva).filter(
        Reserva.id_usuario == id_user,
        Reserva.fecha == fecha,
        Reserva.estado_reserva < 2
    ).all()
    return reservations_db
    

def get_reservations_available(id_user:str,db,fecha:date = None):
    list_reservations = get_reservations_by_date(id_user,db,fecha)
    object_reservations = {}
        
    for reserva_db in list_reservations:
        time_reserve = reserva_db.hora.strftime('%H:%M:%S')
        if time_reserve in list_reserve:
            object_reservations[time_reserve] = reserva_db.cliente;
            
    for time_reserve in list_reserve:
        # bueno mi so el setdefault lo que hace es que si el objeto tiene esa clave no lo modifica de lo contrario coloca el valor Disponible
        object_reservations.setdefault(time_reserve, "Disponible")
            
    object_sort = sort_object_by_index(object_reservations)
    reservations_available = list(object_sort.items())
    return reservations_available
        
    
    