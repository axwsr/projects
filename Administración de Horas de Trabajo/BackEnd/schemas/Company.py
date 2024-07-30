from pydantic import BaseModel

class company_base(BaseModel):
    id_company:int
    name_company:str
    status_company:bool

class company_read(BaseModel):
    name: str
    code: str

class company(BaseModel):
    name_company:str

