from datetime import date
from pydantic import BaseModel

class document_base(BaseModel):
    total_hrs:str
    pay_number:str
    pay_word:str
    observation:str
    start_date:date
    end_date:date