from sqlalchemy import Column, String,ForeignKey,TIMESTAMP
from sqlalchemy.orm import relationship
from models.Base_class import Base
from models.User import User
class Person(Base):
    __tablename__ = 'persons'
    id_person = Column(String(30), primary_key=True)
    id_user = Column(String(30),ForeignKey('users.id_user'))
    first_name = Column(String(70), nullable=False)
    last_name = Column(String(70), nullable=False)
    identity_document = Column(String(15), nullable=False)
    address_person = Column(String(120), nullable=False)
    cell_phone = Column(String(10), nullable=False)
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
     
    user = relationship("User",back_populates="person")