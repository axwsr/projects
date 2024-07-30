from typing import List
from fastapi import APIRouter,Depends,HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
from sqlalchemy.orm import Session
from db.session import get_session
from schemas.UsuarioSh import *
from cruds.UsuarioCrud import create_new_user,get_user_by_email,get_user_by_id, authenticate_user, update_user_crud, update_user_status_crud, get_all_users_bd
from core.seguridad import verify_token, verify_password, create_access_token, get_hashed_password

router = APIRouter()

tokens = []

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/users/login")

SUPERADMIN = "SUPERADMIN"

async def get_current_user(token: str = Depends(oauth2_scheme), db: Session = Depends(get_session)):
    user_id = await verify_token(token)
    if user_id is None:
        if token in tokens:
            tokens.remove(token)
            raise HTTPException(status_code=484, detail="Token delete for time ")
        else:
            raise HTTPException(status_code=400, detail="El token proporcionado no es válido")
    user_db = get_user_by_id(user_id, db)
    if user_db is None:
        raise HTTPException(status_code=484, detail="User not found")
    return user_db

@router.post("/create/",response_model=UserRead)
async def create_user(user:UserCreate,db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        
        if current_user.rol == SUPERADMIN:
        
            verify_user = get_user_by_email(user.correo,db)
            if verify_user is None:
                return create_new_user(user,db)
            
            raise HTTPException(status_code=404,detail="Email already exists")
        else:
            raise HTTPException(status_code=401, detail="Not authorized")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo /create")
    

@router.get("/get/{user_id}",response_model=UserRead)
def read_user(user_id:str, db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        if current_user.rol == SUPERADMIN:
            user = get_user_by_id(user_id,db)
            if user is None:
                raise HTTPException(status_code=404,detail="usuario no encontrado")
            
            return user
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")

@router.get("/get-all-users", response_model= List[UserRead])
def read_all_users_func(db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):

    if current_user.estado_usuario:
        if current_user.rol == SUPERADMIN:
            usersFind = get_all_users_bd(db)
            if usersFind is None:
                raise HTTPException(status_code=404,detail="No hay usuarios registrados por el momento")
            return usersFind
        raise HTTPException(status_code=401, detail="Not authorized")
    raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")



    

@router.post("/login",response_model=Token)
async def login_for_acces(form_data: OAuth2PasswordRequestForm= Depends(), db: Session = Depends(get_session)):
    curr_user = authenticate_user(form_data.username, form_data.password, db)
    if not curr_user:
        raise HTTPException(
            status_code=401,
            detail="Invalid username or password",
            headers={"WWW-Authenticate": "Bearer"}
        )
    if curr_user.estado_usuario:
        access_token = create_access_token(data={"sub": curr_user.id_usuario})
        tokens.append(access_token)
        return {"access_token": access_token, "correo":curr_user.correo,"token_type":"bearer","rol":curr_user.rol}
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")
     
     
@router.post("/update-user", response_model=UserRead)
def update_user_func(user: UserUpdate, db: Session = Depends(get_session), current_user: UserCurrent = Depends(get_current_user)):
        
    if current_user.estado_usuario:
        if current_user.id_usuario == user.id_usuario:
            user_verify = get_user_by_email(user.correo, db)
            if user_verify is None or user_verify.id_usuario == user.id_usuario:
                if user.contrasenia and user.contraActual:  #Verificar si la contrasenia actual y la nueva son diferentes de null (None)
                    passwordVer = verify_password(user.contraActual, current_user.contrasenia)
                    if passwordVer: 
                        user_return = update_user_crud(user, db)
                        if user_return is None:
                            raise HTTPException(status_code=403, detail="No se encontró el usuario por el id")
                        return user_return
                    raise HTTPException(status_code=404, detail="La contraseña actual es incorrecta")
                else:
                    user_return = update_user_crud(user, db)
                    if user_return is None:
                        raise HTTPException(status_code=403, detail="No se encontró el usuario por el id")
                    return user_return
            raise HTTPException(status_code=404, detail="El email ya existe")
        raise HTTPException(status_code=401, detail="Not authorized")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")

@router.post("/update-user-status")
def update_user_status_func(user: UserUpdateStatus, db: Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    
    if current_user.estado_usuario:
        if current_user.rol == SUPERADMIN:
            statusUpdate = update_user_status_crud(user, db)
            if statusUpdate:
                return {"message:":"The user's status has been successfully updated", "status": statusUpdate}
            return {"message:":"An error occurred at the time of updating the user.", "status": statusUpdate}    
        raise HTTPException(status_code=401, detail="Not authorized") 
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")



@router.post("/logout")
def logout_user(token: str, current_user: UserRead = Depends(get_current_user)):
    print(token)
    if current_user.estado_usuario:
        if token in tokens:
            tokens.remove(token)
            return {"msg": "Sesión cerrada exitosamente","status":True}
        else:
            raise HTTPException(status_code=400, detail="El token proporcionado no es válido")
    else:
        raise HTTPException(status_code=403, detail="El estado del usuario es inactivo")


@router.post("/get-user-token", response_model=UserRead)
async def get_user_log(token:str, db:Session = Depends(get_session), current_user: UserRead = Depends(get_current_user)):
    if current_user.estado_usuario:
        user_id = await verify_token(token)
        if user_id:
            user = get_user_by_id(user_id, db)
            if user is None:
                raise HTTPException(status_code=400, detail="El usuario no existe")
            return user
        raise HTTPException(status_code=400, detail="El usuario no se encontró con el token")
    raise HTTPException(status_code=400, detail="El usuario esta desactivado")
            
            