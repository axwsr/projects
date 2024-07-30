from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI,APIRouter
from routes import UsuarioR,MovimientosR,TarifaR, ReservaR
from core.config import settings

api_router = APIRouter()
api_router.include_router(UsuarioR.router,prefix="/users",tags=["users"])
api_router.include_router(MovimientosR.router,prefix="/movimientos",tags=["movimientos"])
api_router.include_router(TarifaR.router,prefix="/tarifas",tags=["tarifas"])
api_router.include_router(ReservaR.router,prefix="/reserves",tags=["reservas"])

app = FastAPI(title=settings.PROJECT_NAME,version=settings.PROJECT_VERSION,description=settings.PROJECT_DESCRIPTION)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
app.include_router(api_router)

