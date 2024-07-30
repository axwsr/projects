from sqlalchemy.orm import relationship
from sqlalchemy import Column, Integer, String, Float, Date, Boolean, func,Time,ForeignKey,TIMESTAMP
from models.Base_class import Base
from models.UsuarioM import User


class Reserva(Base):
    tablename = 'reserva'
    id_reserva = Column(Integer, primary_key=True, autoincrement=True)
    id_usuario = Column(String(30), ForeignKey('usuario.id_usuario'))
    cliente = Column(String(100), nullable=False)
    fecha = Column(Date, nullable=False)
    hora = Column(Time, nullable=False)
    estado_reserva = Column(Integer,default=0)
    id_tarifa = Column(Integer, ForeignKey('tarifa.id_tarifa'))
    created_at = Column(TIMESTAMP)
    
    tarifa = relationship("Tarifa",back_populates="reserva")
    usuario = relationship("User", back_populates="reserva")