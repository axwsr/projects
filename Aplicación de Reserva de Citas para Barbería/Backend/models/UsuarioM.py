from sqlalchemy import Column, Integer, String, Enum, ForeignKey, Float, Date, Boolean, Time, SmallInteger
from enum import Enum as PyEnum
from sqlalchemy.orm import relationship
from models.Base_class import Base
from sqlalchemy.orm import relationship

class User(Base):
    __tablename__ = 'usuario'
    id_usuario = Column(String(30), primary_key=True)
    correo = Column(String(80), nullable=False)
    contrasenia = Column(String(250), nullable=False)
    rol = Column(Enum('SUPERADMIN', 'BARBERO', name='rol'), nullable=False)
    estado_usuario = Column(Boolean, default=True)

    tarifa = relationship("Tarifa", back_populates="usuario")
    reserva = relationship("Reserva",back_populates="usuario")
    movimiento = relationship("Movimiento",back_populates="usuario")
    
