from typing import List, Optional
from fastapi import APIRouter,Depends,HTTPException
from fastapi.security import OAuth2PasswordBearer
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.MovimientosSh import *
from schemas.UsuarioSh import UserRead
from cruds.MovimientosCrud import *
from routes.UsuarioR import get_current_user
router = APIRouter()

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/users/login")

BARBERO = "BARBERO"

@router.post("/create/",response_model=MovimientosRead)
async def create_movimiento(movi:MovimientosCreate,db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            return create_new_movimiento(movi,current_user.id_usuario,db)
        else:
            raise HTTPException(status_code=401, detail="Not authorized")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /create")
    

@router.get("/get/{movimiento_id}",response_model=MovimientosRead)
def read_movimiento(id_movimientos:int, db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        user = buscar_movimientos(id_movimientos,db)
        if user is None:
            raise HTTPException(status_code=404,detail="Movimiento no encontrado")
        
        return user
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")

@router.post("/weekly-expenses")
def weekly_expenses(datos: dict, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if not current_user.estado_usuario:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")
    
    if current_user.rol != 'BARBERO':
        raise HTTPException(status_code=401, detail="Not authorized")
    
    tipo = datos.get("tipo")
    if not tipo:
        raise HTTPException(status_code=400, detail="El campo 'tipo' es requerido")

    total_expenses, details = get_weekly_expenses(db, current_user.id_usuario, tipo)
    return {"total_expenses": total_expenses, "details": details}



@router.post("/consulted_expenses")
def consulted_expenses(datos: dict, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if not current_user.estado_usuario:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")
    
    if current_user.rol != 'BARBERO':
        raise HTTPException(status_code=401, detail="Not authorized")
    
    start_week = datos.get("start_week")
    end_week = datos.get("end_week")
    
    if not start_week and end_week:
        raise HTTPException(status_code=400, detail="Los campos son requeridos")

    total_expenses, details = get_consulted_expenses(db, current_user.id_usuario, start_week,end_week)
    return {"total_expenses": total_expenses, "details": details}

    
@router.get("/get-cuenta")
async def account_money(fecha_inicio : Optional[str] = None,fecha_fin : Optional[str] = None,db:Session = Depends(get_session),current_user:UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            cuenta = money_account(db,current_user.id_usuario,fecha_inicio,fecha_fin)
            return {"money_account":cuenta}
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /get_reserve_pendiente")
     
@router.post("/update-movimiento", response_model=MovimientosRead)
def update_user_func(movi: MovimientosUpdate, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
           movimientoread = update_movimiento_crud(movi,db)
           if movimientoread  is None:
               raise HTTPException(status_code=401, detail="no se encontro el movimiento")
           return movimientoread
                
        raise HTTPException(status_code=401, detail="Not authorized")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")
    

@router.post("/update-movimientos-status")
def update_movimientos_status(movi: MovimientosUpdateStatus, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        if current_user.rol == BARBERO:
            statusUpdate = update_movimientos_status_crud(movi, db)
            if statusUpdate:
                return {"message:":"The movimiento status has been successfully updated", "status": statusUpdate}
            return {"message:":"An error occurred at the time of updating the movimiento.", "status": statusUpdate}    
        raise HTTPException(status_code=401, detail="Not authorized") 
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")