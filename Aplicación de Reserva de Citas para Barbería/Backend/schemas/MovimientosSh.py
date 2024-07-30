from pydantic import BaseModel
from typing import List
from enum import Enum as PydanticEnum
from datetime import date

class MovimientosStatus(str,PydanticEnum):
    INGRESO = 'INGRESO'
    GASTO = 'GASTO'

class MovimientosBase(BaseModel):
    tipo_movimiento:MovimientosStatus
    descripcion : str

class MovimientosCreate(MovimientosBase):
    cuenta : int
    fecha : date

class MovimientosRead(MovimientosBase):
    fecha : date
    cuenta : int
    id_movimientos: int
    estado_gasto : bool

    
class MovimientosUpdate(MovimientosBase):
    id_movimientos: int
    cuenta : int
    
    
class MovimientosUpdateStatus(BaseModel):
    id_movimientos: int
    estado_gasto : bool


