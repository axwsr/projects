from datetime import date
from pydantic import BaseModel

class hour_base(BaseModel):
    day_worked:str
    date_worked:date
    start_time:str
    end_time:str

class hour_create(hour_base):
    id_company:int
    total_hours:str 
    
class hour_update(hour_base):
    id_company:int
    total_hours:str 
    
class hour_read(hour_base):
    name_company:str   
    total_hours:str 

class hour_all(hour_base):
    id_hour_worked:int
    id_company:int

class hour_get(BaseModel):
    start_date:date
    end_date:date
    