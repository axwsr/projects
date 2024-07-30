from typing import List
from sqlalchemy.orm import Session
from fastapi import APIRouter,Depends,HTTPException
from db.session import get_session
from schemas.Company import *
from controllers.Company import *

router = APIRouter()

@router.get("/get_all_companies", response_model= List[company_read])
def get_companies_route_v1(db:Session = Depends(get_session)):
    return get_companies_all(db)

@router.get("/get_companies", response_model= List[company_base])
def get_companies_route_v2(db:Session = Depends(get_session)):
    return get_companies_schemaDB(db)
    
@router.post("/create_company",response_model=company_base)
def create_company(company:company,db:Session = Depends(get_session)):
    return create_new_company(company,db)

@router.put("/update_company/{id_company}", response_model=company_base)
def update_company(id_company: int, company: company, db: Session = Depends(get_session)):
    return company_update(id_company, company, db)

@router.put("/delete_company/{id_company}",response_model=company_base)
def delete_company(id_company:int, db:Session = Depends(get_session)):
    return change_status(id_company,db)