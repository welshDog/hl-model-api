FROM python:3.12-slim AS build
WORKDIR /app

# Install build deps
RUN apt-get update && apt-get install -y --no-install-recommends build-essential gcc libffi-dev && rm -rf /var/lib/apt/lists/*

COPY requirements.prod.txt /app/requirements.prod.txt
RUN python -m pip install --upgrade pip && pip install --prefix=/install --no-warn-script-location --no-cache-dir -r requirements.prod.txt

FROM python:3.12-slim
WORKDIR /app

# Copy installed packages from build stage
COPY --from=build /install /usr/local

# Copy application
COPY . /app

EXPOSE 8000

CMD ["uvicorn", "serve:app", "--host", "0.0.0.0", "--port", "8000"]
