from sqlalchemy import Column, String, Boolean, Integer, TIMESTAMP
from models.Base_class import Base
from sqlalchemy.orm import relationship
class Company(Base):
    __tablename__ = 'companies'
    id_company = Column(Integer, autoincrement=True, primary_key=True)
    name_company = Column(String(100), nullable=True)
    status_company = Column(Boolean, default=True)
    created_at = Column(TIMESTAMP)
    updated_at = Column(TIMESTAMP)
    
    hour_work = relationship("Hour_work",back_populates="company")