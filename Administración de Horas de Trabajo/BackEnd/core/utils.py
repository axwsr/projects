import secrets
import string
import pytz
from datetime import datetime

def generate_uuid(length = 30):
    characteres = string.ascii_letters + string.digits
    random_id = ''.join(secrets.choice(characteres) for _ in range(length))
    return random_id

def get_current_date():
    tz = pytz.timezone('America/Bogota')
    current_date = datetime.now(tz) 
    date = current_date.strftime('%Y-%m-%d')
    return date

def get_current_datetime():
    tz = pytz.timezone('America/Bogota')
    current_datetime = datetime.now(tz) 
    return current_datetime

def tuple_to_dict(tup):
        keys = ["day_worked", "date_worked", "start_time", "end_time", "name_company", "total_hours"]
        return dict(zip(keys, tup[1:]))