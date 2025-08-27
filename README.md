AI Ecosystem - Minimal Example

Steps:

1. Create and activate a Python virtual environment:

   python3 -m venv ~/ai-env
   source ~/ai-env/bin/activate

2. Install dependencies:

   pip install -r "requirements.txt"

3. Train the example model:

   python train.py

   This trains a RandomForest on Iris and writes the model to models/model.joblib

4. Run the API server:

   uvicorn serve:app --reload --host 0.0.0.0 --port 8000

5. Test prediction (example):

   POST http://localhost:8000/predict
   Body (JSON): {"inputs": [5.1, 3.5, 1.4, 0.2]}

Notes:
- Replace the example dataset with your data when ready.
- For GPU workloads and deep learning, install PyTorch/TensorFlow separately.

New quickstart for text classifier demo:

1. Train the synthetic text model:

   python train_text.py

2. Run the API locally:

   uvicorn serve:app --reload

3. Test the text endpoint:

   curl -X POST http://127.0.0.1:8000/predict_text -H "Content-Type: application/json" -d '{"texts":"I love this"}'

Docker
------

Build the container image and run locally:

```powershell
docker build -t hl-model-api .
docker run --rm -p 8000:8000 hl-model-api
```

After the container starts, test the endpoints:

```powershell
Invoke-RestMethod -Uri 'http://127.0.0.1:8000/health' -Method Get
Invoke-RestMethod -Uri 'http://127.0.0.1:8000/predict' -Method Post -ContentType 'application/json' -Body '{"inputs":[5.1,3.5,1.4,0.2]}'
```

## Docker tips

Tag the image for clarity:

```powershell
docker build -t hl-model-api:latest .
```

Run with resource limits (recommended):

```powershell
docker run --rm -p 8000:8000 --memory=512m --cpus=1 hl-model-api:latest
```

Or use `docker-compose` which includes a healthcheck and log rotation options:

```powershell
docker-compose up --build
```

## Run in production or long-running mode

Use a restart policy so the container restarts after host reboots or failures:

```powershell
docker run --restart unless-stopped --memory=512m --cpus=1 -p 8000:8000 hl-model-api:latest
```

When using `docker-compose`, the provided `docker-compose.yml` sets `restart: unless-stopped` for the service.

Publish to GitHub Container Registry (GHCR)
----------------------------------------

Push to the `main` branch and the workflow will build and publish the image to GHCR as:

```
ghcr.io/<your-org-or-username>/hl-model-api:latest
```

To run the published image locally:

```powershell
docker pull ghcr.io/<your-org-or-username>/hl-model-api:latest
docker run --rm -p 8000:8000 ghcr.io/<your-org-or-username>/hl-model-api:latest
```

Note: GitHub Actions uses the repository's `GITHUB_TOKEN` so no extra credentials are required for publishing within this repo.
# hl-model-api

This project contains a small example ML model and a FastAPI server.

New quickstart for text classifier demo:

1. Train the synthetic text model:

```powershell
python train_text.py
```

2. Run the API locally:

```powershell
uvicorn serve:app --reload
```

3. Test the text endpoint:

```powershell
curl -X POST http://127.0.0.1:8000/predict_text -H "Content-Type: application/json" -d '{"texts":"I love this"}'
```

The project already includes a Dockerfile and GitHub Actions workflow to run tests and build/publish the image.