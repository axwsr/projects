from typing import Optional
from pydantic import BaseModel

class person_base(BaseModel):
    id_person:str
    first_name:str
    last_name :str
    identity_document :str
    address_person :str
    cell_phone :str
    id_user :str