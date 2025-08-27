FROM python:3.12-slim AS build
WORKDIR /app

# Use pip wheels where possible; avoid installing system build tools to speed up builds
COPY requirements.prod.txt /app/requirements.prod.txt
RUN python -m pip install --upgrade pip setuptools wheel \
 && pip install --prefix=/install --no-warn-script-location --no-cache-dir -r requirements.prod.txt

FROM python:3.12-slim
WORKDIR /app

# Runtime optimizations
ENV PYTHONDONTWRITEBYTECODE=1 \
	PYTHONUNBUFFERED=1

# Copy installed packages from build stage
COPY --from=build /install /usr/local

# Copy application
COPY . /app

EXPOSE 8000

LABEL org.opencontainers.image.title="hl-model-api" \
			org.opencontainers.image.version="0.1.0"

# Healthcheck using the bundled Python runtime (no extra tools required).
# It checks the FastAPI /health endpoint and exits non-zero if it's not healthy.
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
	CMD python -c "import urllib.request as u,sys;\ntry:\n r=u.urlopen('http://127.0.0.1:8000/health', timeout=5);\n sys.exit(0 if r.getcode()==200 else 1)\nexcept Exception:\n sys.exit(1)"

CMD ["uvicorn", "serve:app", "--host", "0.0.0.0", "--port", "8000"]
