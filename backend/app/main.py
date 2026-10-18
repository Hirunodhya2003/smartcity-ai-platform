from fastapi import FastAPI

app = FastAPI(
    title="Smart City AI Platform API",
    description="Backend API for the Smart City Management Platform",
    version="1.0.0",
)


@app.get("/")
def root():
    return {
        "message": "Smart City AI Platform API is running",
        "status": "success",
    }


@app.get("/health")
def health_check():
    return {"status": "healthy"}


@app.get("/api/v1")
def api_info():
    return {
        "message": "Smart City API v1",
        "modules": [
            "Authentication",
            "Traffic Management",
            "Waste Management",
            "Energy Management",
            "Water Management",
            "Air Quality",
            "Safety and Complaints",
            "AI and Analytics",
        ],
    }
