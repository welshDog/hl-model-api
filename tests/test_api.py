from fastapi.testclient import TestClient
from serve import app

client = TestClient(app)


def test_health():
    r = client.get("/health")
    assert r.status_code == 200
    data = r.json()
    assert "status" in data


def test_predict_single():
    r = client.post("/predict", json={"inputs": [5.1, 3.5, 1.4, 0.2]})
    assert r.status_code == 200
    data = r.json()
    assert "predictions" in data
    assert isinstance(data["predictions"], list)


def test_predict_batch():
    r = client.post("/predict", json={"inputs": [[5.1, 3.5, 1.4, 0.2], [6.2, 3.4, 5.4, 2.3]]})
    assert r.status_code == 200
    data = r.json()
    assert len(data["predictions"]) == 2
