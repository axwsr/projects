from sqlalchemy import Column, String, Enum, ForeignKey, Boolean
from enum import Enum as PyEnum
from sqlalchemy.orm import relationship
from models.Base_class import Base

class User(Base):
    __tablename__ = 'users'
    id_user = Column(String(30), primary_key=True)
    email = Column(String(80), nullable=False, unique=True)
    username = Column(String(250), nullable=True)
    role_user = Column(Enum('USER', 'SUPERADMIN', name='role_user'), nullable=False,default='USER')
    status_user = Column(Boolean, default=True)
    
    hour_work = relationship("Hour_work",back_populates="user")
    person = relationship("Person",back_populates="user")