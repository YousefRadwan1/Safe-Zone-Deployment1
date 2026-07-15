#!/bin/bash
set -e

echo ">> Starting the API server..."

export PORT="${PORT:-8000}"
export WORKERS="${WORKERS:-1}"   # Keeping this at 1 is perfect for avoiding memory overload with heavy models

gunicorn main:app \
    --bind "0.0.0.0:${PORT}" \
    --timeout 600 \
    --workers "${WORKERS}" \
    --worker-class uvicorn.workers.UvicornWorker
