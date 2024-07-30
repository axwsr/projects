import sys
from fastapi import HTTPException
from schemas.Company import *
from models.Company import Company
from sqlalchemy.orm import Session

def get_companies_all(db:Session):
    try:
        companies = db.query(Company).where(Company.status_company == True).all()
        return [
                company_read(name=company.name_company, code=str(company.id_company))
                for company in companies
            ]
    except:
        raise HTTPException(status_code=500, detail="Ocurrio un error")
    
def get_companies_schemaDB(db:Session):
    try:
        return db.query(Company).where(Company.status_company == True).all()
    except:
        raise HTTPException(status_code=500, detail="Ocurrio un error")

def create_new_company(company:company,db:Session):
    db_company = Company(name_company = company.name_company)

    try:
        db.add(db_company)
        db.commit()
        db.refresh(db_company)
        db.close()
        return db_company
    except Exception as e :
        db.rollback()
        print(f"Error al registrar la empresa: {str(e)}",file=sys.stderr)
        raise HTTPException(status_code=500,detail=f"Error al registrar la empresa: {str(e)} ")

def company_update(id_company:int,company:company,db:Session):
    db_company = db.query(Company).filter(Company.id_company == id_company).first()

    if not db_company:
        raise HTTPException(status_code=404, detail="Empresa no encontrada")
    
    db_company.name_company = company.name_company

    try:
        db.commit()
        db.refresh(db_company)
        db.close()
        return db_company
    except Exception as e:
        db.rollback()
        print(f"Error al actualizar la empresa: {str(e)}", file=sys.stderr)
        raise HTTPException(status_code=500, detail=f"Error al actualizar la empresa: {str(e)}")
    
def change_status(id_company:int,db:Session):
    db_company = db.query(Company).filter(Company.id_company == id_company).first()
    
    if not db_company:
        raise HTTPException(status_code=404, detail="Empresa no encontrada")
    
    db_company.status_company = False if db_company.status_company else True

    try:
        db.commit()
        db.refresh(db_company)
        db.close()
        return db_company
    except Exception as e:
        db.rollback()
        print(f"Error al cambiar el estado de la empresa: {str(e)}", file=sys.stderr)
        raise HTTPException(status_code=500, detail=f"Error al cambiar el estado de la empresa: {str(e)}")

    
