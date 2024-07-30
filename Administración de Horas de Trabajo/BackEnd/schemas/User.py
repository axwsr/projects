from pydantic import BaseModel,EmailStr
from enum import Enum as PydanticEnum
from typing import Optional

class user_role(str,PydanticEnum):
    SUPERADMIN = 'SUPERADMIN'
    USER = 'USER'
    
class user_base(BaseModel):
    email:EmailStr
    
class user_read(user_base):
    id_user:str
    username:str
    role_user: user_role
    status_user: bool