from fastapi.testclient import TestClient
import sys
import pathlib

BASE_DIR= pathlib.Path(__file__).resolve().parent.parent
sys.path.append(str(BASE_DIR))

from main import app

client = TestClient(app)

def test_home_endpoint():
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Welcome to the Application"}

def test_predict_endpoint():
    data = {
        "sepal_length": 5.1,
        "sepal_width": 3.5,
        "petal_length": 1.4,
        "petal_width": 0.2
    }
    response = client.post("/predict", json=data)
    assert response.status_code == 200
    assert "Prediction" in response.json()
    assert response.json()["Prediction"] in ["Setosa", "Versicolor", "Virginica"]

def test_predict_endpoint_invalid_input():
    data = {
        "sepal_length": 5.1,
        "sepal_width": 3.5,
        "petal_length": 1.4,
        "petal_width": "invalid"
    }
    response = client.post("/predict", json=data)
    assert response.status_code == 422