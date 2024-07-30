import sys # Mandar mensajes de error al log

from models.UsuarioM import User
from fastapi import HTTPException
from schemas.UsuarioSh import UserCreate,UserRead, UserUpdate, UserUpdateStatus
from sqlalchemy.orm import Session
from core.seguridad import get_hashed_password,verify_password
from core.utils import generate_user_id

def create_new_user(user:UserCreate,db:Session):
    db_user = User(
        id_usuario = generate_user_id(),
        correo = user.correo,
        contrasenia = get_hashed_password(user.contrasenia),
        rol = "BARBERO"
    )

    try:
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        db.close()
        return db_user
    except Exception as e :
        db.rollback()
        # Imprimir el error en la consola
        print(f"Error al crear un usuario: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"Error al crear usuario: {str(e)} ")

def get_user_by_email(email:str,db:Session):
    user = db.query(User).filter(User.correo == email).first()
    return user

# def get_user_by_email_verify(user_id : str,email:str,db:Session):
#     user_db = db.query(User).filter(User.user_id == user_id).first()
#     if user_db.mail != email: 
#         validation = get_user_by_email(email,db)
#         if validation is None:
#             return True
#         else:
#             return False
#     return True
    
        

def get_user_by_id(id:str,db:Session):
    user = db.query(User).filter(User.id_usuario == id).first()
    return user

def get_all_users_bd(db:Session):
    users = db.query(User).filter(User.rol == "BARBERO").all()
    return users

def authenticate_user(username:str,password:str,db:Session):
    user = get_user_by_email(username,db)
    if not user:
        return False
    if not verify_password(password,user.contrasenia):
        return False
    
    return user

def update_user_crud(user:UserUpdate,db:Session):
    user_db = get_user_by_id(user.id_usuario,db)
    if user_db:
        try:
            if user.contrasenia:
                user_db.contrasenia = get_hashed_password(user.contrasenia)
            user_db.correo = user.correo
            db.add(user_db)
            db.commit()
            db.refresh(user_db)
            return user_db    
        except Exception as e :
            db.rollback()
            print(f"Error al crear un usuario: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al crear usuario: {str(e)} ")
    return None


def update_user_status_crud(user:UserUpdateStatus, db:Session):
    user_db = get_user_by_id(user.user_id, db)
    if user_db:
        try:
            user_db.estado_usuario = user.estado_usuario
            db.add(user_db)
            db.commit()
            
            return True
        except Exception as e :
            db.rollback()
            print(f"Error al crear un usuario: {str(e)}",file=sys.stderr)
            raise HTTPException(status_code=500,detail=f"Error al crear usuario: {str(e)} ")
        
    return False

