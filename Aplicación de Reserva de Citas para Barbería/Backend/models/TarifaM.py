from sqlalchemy import Column, Integer, String, Enum, Float, Date, Boolean, func,TIMESTAMP,String,ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from models.Base_class import Base
from models.ReservaM import Reserva
from models.UsuarioM import User
from datetime import datetime

class Tarifa(Base):
    __tablename__ = 'tarifa'

    id_tarifa = Column(Integer, autoincrement=True, primary_key=True)
    id_usuario = Column(String(30),ForeignKey("usuario.id_usuario"))
    descripcion = Column(String, nullable=True)
    costo = Column(Integer, nullable=False)
    estado_tarifa = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP)
    usuario = relationship("User",back_populates="tarifa")
    reserva = relationship("Reserva",back_populates="tarifa")
    