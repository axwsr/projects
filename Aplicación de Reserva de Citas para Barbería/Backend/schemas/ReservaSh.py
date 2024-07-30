from pydantic import BaseModel
from datetime import date, time

class ReserveCreate(BaseModel):
    cliente:str
    fecha:date
    hora:time

class ReserveRead(ReserveCreate):
    id_reserva:int
    estado_reserva:int


class ReserveUpdateStatus(BaseModel):
    id_reserva: int
    estado_reserva : int

class ReserveUpdate(BaseModel):
    id_reserva:int
    cliente:str
    fecha:date
    hora:time

class ReserveUpdateTarifa(BaseModel):
    id_reserva: int
    id_tarifa:int
