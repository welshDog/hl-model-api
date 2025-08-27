from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Union
import joblib
import numpy as np
import logging

app = FastAPI()

logger = logging.getLogger("serve")

# Load model at import-time (small example)
try:
    model_data = joblib.load("models/model.joblib")
    model = model_data["model"]
    target_names = model_data.get("target_names", None)
except Exception as e:
    # make failures explicit at startup
    logger.exception("Failed to load model: %s", e)
    model = None
    target_names = None


class PredictRequest(BaseModel):
    # Accept a single feature vector or a list of feature vectors
    inputs: Union[List[float], List[List[float]]]


@app.get("/")
def read_root():
    return {"message": "Model API. Use /predict POST or /health GET."}


@app.get("/health")
def health():
    return {"status": "ok", "model_loaded": model is not None}


@app.post("/predict")
def predict(req: PredictRequest):
    if model is None:
        raise HTTPException(status_code=503, detail="Model not loaded")

    try:
        arr = np.array(req.inputs)
        if arr.ndim == 1:
            arr = arr.reshape(1, -1)
    except Exception as e:
        logger.exception("Invalid input data: %s", e)
        raise HTTPException(status_code=400, detail="Invalid input format")

    # Basic shape check
    if arr.shape[1] == 0:
        raise HTTPException(status_code=400, detail="Empty feature vectors")

    try:
        preds = model.predict(arr)
    except Exception as e:
        logger.exception("Model prediction failed: %s", e)
        raise HTTPException(status_code=500, detail="Prediction failed")

    labels = [target_names[int(p)] if target_names is not None else int(p) for p in preds]
    return {"predictions": labels}
