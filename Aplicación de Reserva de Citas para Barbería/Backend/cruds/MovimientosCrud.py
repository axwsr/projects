import sys
from models.MovimientosM import Movimiento
from fastapi import HTTPException
from schemas.MovimientosSh import *
from sqlalchemy.orm import Session
from datetime import date,datetime,timedelta
from sqlalchemy import func,between
from core.utils import get_current_date
def create_new_movimiento(movi:MovimientosCreate,id_usuario:str,db:Session):
    db_movimiento = Movimiento(
        id_usuario = id_usuario,
        cuenta = movi.cuenta,
        tipo_movimiento = movi.tipo_movimiento,
        fecha = movi.fecha,
        descripcion = movi.descripcion,
    )

    try:
        db.add(db_movimiento)
        db.commit()
        db.refresh(db_movimiento)
        db.close()
        return db_movimiento
    except Exception as e :
        db.rollback()
        # Imprimir el error en la consola
        print(f"Error al crear un usuario: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"Error al crear un movimiento: {str(e)} ")

def get_weekly_expenses(db: Session, user_id: str,tipo:str):
    today = datetime.today()
    if tipo == "SEMANA":
        start_week = today - timedelta(days=today.weekday())
        end_week = start_week + timedelta(days=6)
        
    if tipo == "MES":
        start_week = today.replace(day=1)
        next_month = start_week.replace(month=start_week.month + 1, day=1)
        end_week = next_month - timedelta(days=1)

    if tipo == "HOY":
        start_week = today.replace(hour=0, minute=0, second=0, microsecond=0)

        # Obtener el último momento del día (23:59:59)
        end_week = today.replace(hour=23, minute=59, second=59, microsecond=999999)
        
    expenses = db.query(Movimiento.descripcion, Movimiento.cuenta,Movimiento.id_movimientos).\
                filter(Movimiento.id_usuario == user_id, 
                    Movimiento.tipo_movimiento == 'GASTO', 
                    Movimiento.estado_gasto == True, 
                    between(Movimiento.fecha, start_week.date(), end_week.date())).\
                all()

    total_expenses = sum(exp[1] for exp in expenses)  
    details = [{"descripcion": exp[0], "cuenta": float(exp[1]),"id_movimientos":int(exp[2])} for exp in expenses]
    return total_expenses,details


def get_consulted_expenses(db: Session, user_id: str,start_week : date,end_week:date):
    expenses = db.query(Movimiento.descripcion, Movimiento.cuenta).\
                filter(Movimiento.id_usuario == user_id, 
                    Movimiento.tipo_movimiento == 'GASTO', 
                    Movimiento.estado_gasto == True, 
                    between(Movimiento.fecha, start_week, end_week)).\
                all()

    total_expenses = sum(exp[1] for exp in expenses)  # Sumando las cuentas (índice 1)
    
    # Convertir los detalles de gastos a una lista de diccionarios
    details = [{"descripcion": exp[0], "cuenta": float(exp[1])} for exp in expenses]
    return total_expenses,details

def buscar_movimientos(id:int,db:Session):
    movimiento_db = db.query(Movimiento).filter(Movimiento.id_movimientos == id).first()
    return movimiento_db

def money_account(db:Session,id_usuario:str,fecha_inicio:date = None,fecha_fin:date = None):
    if fecha_inicio is None or fecha_fin is None:
        fecha_inicio = get_current_date()
        fecha_fin = get_current_date()
        
    ingresos = db.query(func.sum(Movimiento.cuenta)).filter(
        Movimiento.tipo_movimiento == 'INGRESO',
        between(Movimiento.fecha,fecha_inicio,fecha_fin),
        Movimiento.id_usuario == id_usuario,
        Movimiento.estado_gasto == 1
    ).scalar() or 0

    gastos = db.query(func.sum(Movimiento.cuenta)).filter(
        Movimiento.tipo_movimiento == 'GASTO',
        between(Movimiento.fecha,fecha_inicio,fecha_fin),
        Movimiento.id_usuario == id_usuario,
        Movimiento.estado_gasto == 1
    ).scalar() or 0
    
    resultado = ingresos - gastos;
    return resultado


def update_movimiento_crud(movi:MovimientosUpdate,db:Session):
    movimiento_db = buscar_movimientos(movi.id_movimientos,db)
    if movimiento_db:
        try:
            movimiento_db.cuenta = movi.cuenta
            movimiento_db.tipo_movimiento = movi.tipo_movimiento
            movimiento_db.descripcion = movi.descripcion
            db.add(movimiento_db)
            db.commit()
            db.refresh(movimiento_db)
            return movimiento_db    
        except Exception as e :
            db.rollback()
            print(f"Error al actualizar movimiento: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al actualizar un movimiento: {str(e)} ")
    return None


def update_movimientos_status_crud(movi:MovimientosUpdateStatus, db:Session):
    movimientos_db = buscar_movimientos(movi.id_movimientos, db)
    if movimientos_db:
        try:
            movimientos_db.estado_gasto = movi.estado_gasto
            db.add(movimientos_db)
            db.commit()
            
            return True
        except Exception as e :
            db.rollback()
            print(f"Error al update un movimiento {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al update movimiento: {str(e)} ")
        
    return False