from pydantic import BaseModel,EmailStr
from enum import Enum as PydanticEnum
from typing import Optional
class UserRole(str,PydanticEnum):
    SUPERADMIN = 'SUPERADMIN'
    BARBERO = 'BARBERO'

class UserBase(BaseModel):
    correo:EmailStr

class UserCreate(UserBase):
    contrasenia:str

class UserRead(UserBase):
    id_usuario :str
    rol:UserRole
    estado_usuario : bool
    
class UserCurrent(UserBase):
    id_usuario:str
    rol: UserRole
    contrasenia:str
    estado_usuario: bool
    
class UserUpdate(UserBase):
    id_usuario: str
    contraActual:Optional[str]
    contrasenia:Optional[str]
    
class UserUpdateStatus(BaseModel):
    user_id: str
    estado_usuario: bool

class Token(UserBase):
    access_token:str
    token_type:str
    rol:UserRole
    class Config:
        from_attributes = True

    # Cuando orm_mode esta habilitado, permite la conversion directa de objetos SQLAlchemy a modelos Pydantic sin necesidad de definir explicitamente todos los campos

