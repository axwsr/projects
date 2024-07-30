from pydantic import BaseModel
from datetime import datetime

# Clase para reutilzar en algunos casos
class TarifaBase(BaseModel):
    id_tarifa:int
    
# Esquema para recibir datos para hacer un Create
class TarifaCreate(BaseModel):
    descripcion:str
    costo:int
    
# Esquema para recibir datos para hacer un Update
class TarifaUpdate(TarifaBase):
    descripcion:str
    costo:int


# Esquema para enviar datos
class TarifaRead(TarifaBase):
    descripcion:str
    costo:int
    estado_tarifa:bool
    created_at:datetime