from fastapi import APIRouter

from app.api.v1.endpoints import air_quality

api_router = APIRouter()

api_router.include_router(air_quality.router)
# Teammates add their routers below, same pattern:
# api_router.include_router(traffic.router)
