from fastapi import FastAPI, APIRouter
from fastapi.middleware.cors import CORSMiddleware
from core.config import settings
from routers import User,Company,Person,Hour_work,Document

api_router = APIRouter()

api_router.include_router(User.router,prefix="/users",tags=["users"])
api_router.include_router(Company.router,prefix="/companies",tags=["companies"])
api_router.include_router(Person.router,prefix="/persons",tags=["persons"])
api_router.include_router(Hour_work.router,prefix="/hour_work",tags=["hour_work"])
api_router.include_router(Document.router,prefix="/document",tags=["document"])

app = FastAPI(title=settings.PROJECT_NAME,version=settings.PROJECT_VERSION,description=settings.PROJECT_DESCRIPTION)

app.add_middleware(CORSMiddleware,allow_origins=["*"],allow_credentials=True,allow_methods=["*"],allow_headers=["*"])
app.include_router(api_router)

@app.get("/")
def read_root():
    return {"Hello": "World"}
