import secrets
import string
import pytz
from datetime import datetime

# Funcion para generar un ID de usuario aleatorio
def generate_user_id(length = 30):
    # Caracteres posibles para le ID aleatorio
    characteres = string.ascii_letters + string.digits

    # Genera un ID aleatorio de la longitud deseada
    random_id = ''.join(secrets.choice(characteres) for _ in range(length))

    return random_id

list_reserve = ["10:00:00","11:00:00","14:00:00","15:00:00","16:00:00","17:00:00","18:00:00","19:00:00","20:00:00"]
def get_list_reserve():
    return list_reserve

def sort_object_by_index(object):
    sorted_keys = sorted(object.keys())
    sorted_reservations = {key: object[key] for key in sorted_keys}
    return sorted_reservations

def get_current_date():
    tz = pytz.timezone('America/Bogota')
    fecha_actual = datetime.now(tz) # Obtener la fecha y hora actual en la zona horaria de Colombia
    fecha = fecha_actual.strftime('%Y-%m-%d') # Convertir la fecha actual en un string con formato YYYY-MM-DD
    return fecha