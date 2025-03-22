from fastapi import FastAPI
from pydantic import BaseModel
import uvicorn
import joblib
import pandas as pd
import os
import pathlib
import sys

model_dir= pathlib.Path(__file__ ).resolve().parent / 'model'
scr = pathlib.Path(__file__ ).resolve().parent / 'src'
sys.path.append(str(scr))

model_path=model_dir / 'iris_model.joblib'
model=joblib.load(model_path)

app = FastAPI()

@app.get("/")
def home():
    return {"message": "Welcome to the Application"}

class Iris(BaseModel):
    sepal_length: float
    sepal_width: float
    petal_length: float
    petal_width: float

@app.post("/predict")
def predict(data: Iris):
    
    #supported by pydantic v2
    data = data.model_dump()

    sepal_length = data['sepal_length']
    sepal_width = data['sepal_width']
    petal_length = data['petal_length']
    petal_width = data['petal_width']
    
    data= {
        'sepal.length': sepal_length,
        'sepal.width': sepal_width,
        'petal.length': petal_length,
        'petal.width': petal_width
    }

    df= pd.DataFrame(data, index=[0])

    pred = model.predict(df)[0]
    return {"Prediction": pred}

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)