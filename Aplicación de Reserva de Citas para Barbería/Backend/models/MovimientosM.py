from sqlalchemy import Column, Integer, String, Enum, Float, Date, Boolean, func,ForeignKey
from sqlalchemy.orm import relationship
from models.Base_class import Base
from models.UsuarioM import User
class Movimiento(Base):
    __tablename__ = 'movimientos'

    id_movimientos = Column(Integer, autoincrement=True, primary_key=True)
    id_usuario = Column(String(30),ForeignKey("usuario.id_usuario"))
    cuenta = Column(Float(10,2), nullable=False)
    tipo_movimiento = Column(Enum('INGRESO', 'GASTO', name='tipo_movimiento'), nullable=False)
    fecha = Column(Date, nullable=False)  # Usa func.current_date() para obtener la fecha actual
    descripcion = Column(String, nullable=True)
    estado_gasto = Column(Boolean, default=True)
    
    usuario = relationship("User", back_populates="movimiento")