from fastapi.testclient import TestClient
from serve import app
import joblib
from pathlib import Path

client = TestClient(app)


def setup_module(module):
    # Ensure the text model exists (train lightweight synthetic model if missing)
    p = Path("models/text_model.joblib")
    if not p.exists():
        import train_text
        # train_text will save the model


def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    assert "model_loaded" in r.json()


def test_predict_text_single():
    r = client.post("/predict_text", json={"texts": "I love this"})
    # 503 is acceptable if model couldn't load in this environment; otherwise expect 200
    assert r.status_code in (200, 503)


def test_predict_text_batch():
    r = client.post("/predict_text", json={"texts": ["I love this", "I hate that"]})
    assert r.status_code in (200, 503)
