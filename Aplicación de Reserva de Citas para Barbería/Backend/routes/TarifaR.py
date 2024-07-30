from typing import List
from fastapi import APIRouter,Depends,HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.TarifaSh import *
from cruds.TarifaCrud import *
from schemas.UsuarioSh import UserRead
from routes.UsuarioR import get_current_user
import pytz

router = APIRouter()
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/users/login")
BARBERO = "BARBERO"


# Obtener la zona horaria de Colombia
colombia_tz = pytz.timezone('America/Bogota')

# # Obtener la fecha actual en la zona horaria de Colombia

@router.post("/create-tarifa/",response_model=TarifaRead)
def create_tarifa(tarifa_create:TarifaCreate,db:Session = Depends(get_session),current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            fecha_actual_colombia = datetime.now(colombia_tz)
            return create_new_tarifa(tarifa_create,current_user.id_usuario,fecha_actual_colombia,db)
        else:
            raise HTTPException(status_code=401, detail="No esta autorizado")
    else:
        raise HTTPException(status_code=401, detail="Su usuario esta inactivo")

@router.get("/get-tarifas/",response_model=List[TarifaRead])
def obtener_tarifas(db:Session = Depends(get_session),current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            tarifas = get_all_tarifas(db,current_user.id_usuario)
            if tarifas is None:
                raise HTTPException(status_code=404, detail="No existen tarifas")
            else:
                return tarifas
        else:
            raise HTTPException(status_code=401, detail="No esta autorizado")
    else:
        raise HTTPException(status_code=401, detail="Su usuario esta inactivo")

@router.post("/update-tarifa/",response_model=TarifaUpdate)
def update_tarifa(updateTarifa:TarifaUpdate,db:Session = Depends(get_session),current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            tarifas = tarifa_update(updateTarifa,db)
            if tarifas is None:
                raise HTTPException(status_code=404, detail="No existen tarifas")
            else:
                return tarifas
        else:
            raise HTTPException(status_code=401, detail="No esta autorizado")
    else:
        raise HTTPException(status_code=401, detail="Su usuario esta inactivo")


@router.post("/update-tarifa-status/",response_model=TarifaUpdate)
def update_tarifa_status(updateTarifaStatus:TarifaBase,db:Session = Depends(get_session),current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            tarifas = delete_tarifa(updateTarifaStatus,db)
            if tarifas is None:
                raise HTTPException(status_code=404, detail="No existen la Tarifa")
            else:
                return tarifas
        else:
            raise HTTPException(status_code=401, detail="No esta autorizado")
    else:
        raise HTTPException(status_code=401, detail="Su usuario esta inactivo")