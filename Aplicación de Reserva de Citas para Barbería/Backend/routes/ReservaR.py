from typing import List,Optional
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from core.seguridad import verify_token
from cruds.ReservaCrud import *
from cruds.UsuarioCrud import get_user_by_id
import pytz
from db.session import get_session
from schemas.ReservaSh import *
from schemas.UsuarioSh import UserRead

# Obtener la zona horaria de Colombia
colombia_tz = pytz.timezone('America/Bogota')

router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/users/login")

BARBERO = "BARBERO"

async def get_current_user(token:str = Depends(oauth2_scheme), db:Session = Depends(get_session)):
    user_id = await verify_token(token)
    if user_id is None:
        raise HTTPException(status_code=481,detail="Invalid token")
    user_db = get_user_by_id(user_id, db)
    if user_db is None:
        raise HTTPException(status_code=484,detail="User not found")
    return user_db

@router.post("/create-reserve",response_model=ReserveRead)
async def create_reserve(reserve:ReserveCreate,db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            fecha_actual_colombia = datetime.now(colombia_tz)
            return create_new_reserve(reserve,current_user.id_usuario,fecha_actual_colombia,db)
        else:
            raise HTTPException(status_code=401, detail="Not authorized")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /create-reserve")
    
@router.post("/update-reserve", response_model=ReserveRead)
def reserve_update(reserve: ReserveUpdate, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario and current_user.rol == BARBERO:
        updated_reserve = update_reserve(reserve, current_user.id_usuario, db)
        if updated_reserve is None:
            raise HTTPException(status_code=404, detail="reserve not found or reserva is not at 0")
        return updated_reserve
    else:
        raise HTTPException(status_code=401, detail="Not authorized")
    
@router.post("/update-reserve-tarifa", response_model=ReserveRead)
def reserve_update_tarifa(reserve: ReserveUpdateTarifa, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario and current_user.rol == BARBERO:
        updated_reserve_tarifa = update_reserve_tarifa(reserve, current_user.id_usuario, db)
        if updated_reserve_tarifa is None:
            raise HTTPException(status_code=404, detail="reserve tarifa not found")
        return updated_reserve_tarifa
    else:
        raise HTTPException(status_code=401, detail="Not authorized")
    
@router.post("/delete-reserve",response_model=ReserveRead)
async def update_status(reserve:ReserveUpdateStatus,db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            return update_status_reserve(reserve,db,current_user.id_usuario)
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /update-reserve")



@router.get("/get-reserve-pendiente",response_model=List[ReserveRead])
async def get_reserve_pendiente(db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            return get_reserve_false(current_user.id_usuario,db)
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /get_reserve_pendiente")


@router.get("/get-reserve-all",response_model=List[ReserveRead])
async def get_all(fecha_inicio : Optional[str] = None,fecha_fin : Optional[str] = None,db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            return get_reserve_all(current_user.id_usuario,db,fecha_inicio,fecha_fin)
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /get_reserve_all")

@router.get("/get-reservations-available")
async def reservations_available(fecha:Optional[str] = None,db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            return get_reservations_available(current_user.id_usuario,db,fecha)
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /get-reservations-available")
