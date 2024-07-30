from schemas.Person import *
from models.Person import Person
from sqlalchemy.orm import Session

def get_person_information(db:Session):
    return db.query(Person).where(Person.id_user == '08afeeaa-78ea-43e5-9f3a-0dcad6').first()
    