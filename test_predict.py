from fastapi.testclient import TestClient
from serve import app

client = TestClient(app)
resp = client.post("/predict", json={"inputs": [5.1, 3.5, 1.4, 0.2]})
print(resp.status_code)
print(resp.json())
