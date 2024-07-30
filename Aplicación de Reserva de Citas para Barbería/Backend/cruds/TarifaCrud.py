import sys
from models.TarifaM import Tarifa
from fastapi import HTTPException
from schemas.TarifaSh import *
from sqlalchemy.orm import Session
from sqlalchemy import desc
from datetime import datetime

def create_new_tarifa(tarifa_create:TarifaCreate,id_usuario:str,fecha_hora:datetime,db:Session):
    db_tarifa = Tarifa(
        id_usuario = id_usuario,
        descripcion = tarifa_create.descripcion,
        costo = tarifa_create.costo,
        created_at = fecha_hora
    )

    try:
        db.add(db_tarifa)
        db.commit()
        db.refresh(db_tarifa)
        db.close()
        return db_tarifa
    except Exception as e :
        db.rollback()
        # Imprimir el error en la consola
        print(f"Error al crear una tarifa: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"Error al crear una tarifa: {str(e)} ")

def get_all_tarifas(db:Session,id_usuario:str):
    tarifas = db.query(Tarifa).filter(Tarifa.id_usuario == id_usuario,Tarifa.estado_tarifa == 1).order_by(desc(Tarifa.created_at)).all()
    if tarifas is None:
        return None
    return tarifas

def get_tarifa_by_id(id_tarifa:int,db:Session):
    tarifa_db = db.query(Tarifa).filter(Tarifa.id_tarifa == id_tarifa).first()
    return tarifa_db

def tarifa_update(tarifaUpdate:TarifaUpdate,db:Session):
    tarifa_db = get_tarifa_by_id(tarifaUpdate.id_tarifa,db)
    if tarifa_db:
        try:
            tarifa_db.descripcion = tarifaUpdate.descripcion
            tarifa_db.costo = tarifaUpdate.costo
            db.add(tarifa_db)
            db.commit()
            db.refresh(tarifa_db)
            return tarifa_db    
        except Exception as e :
            db.rollback()
            print(f"Error al crear un usuario: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al crear usuario: {str(e)} ")
    raise HTTPException(status_code=404, detail="No existen tarifas")


def delete_tarifa(tarifaUpdateStatus:TarifaBase,db:Session):
    tarifa_db = get_tarifa_by_id(tarifaUpdateStatus.id_tarifa,db)
    if tarifa_db:
        try:
            tarifa_db.estado_tarifa = False
            db.add(tarifa_db)
            db.commit()
            db.refresh(tarifa_db)
            return tarifa_db
        except Exception as e:
            db.rollback()
            print(f"Error al Editar Estado: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al Editar usuario: {str(e)} ")
    raise HTTPException(status_code=404, detail="No existe la tarifas")


