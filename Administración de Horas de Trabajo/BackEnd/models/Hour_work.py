from sqlalchemy import Column, String, Boolean, Integer, TIMESTAMP,ForeignKey,DATE
from models.Base_class import Base
from sqlalchemy.orm import relationship
from models.User import User
from models.Company import Company
class Hour_work(Base):
    __tablename__ = 'hours_worked'
    id_hour_worked = Column(Integer, primary_key=True,autoincrement=True)
    id_company = Column(Integer,ForeignKey("companies.id_company"))
    id_user = Column(String(30), ForeignKey("users.id_user"))
    day_worked = Column(String(30),nullable=False)
    date_worked = Column(DATE,nullable=False)
    start_time = Column(String(25),nullable=False)
    end_time = Column(String(25),nullable=False)
    total_hours = Column(String(24), nullable=False)
    
    created_at = Column(TIMESTAMP) 
    updated_at = Column(TIMESTAMP)
    
    user = relationship("User",back_populates="hour_work")
    company = relationship("Company",back_populates="hour_work")