#!/bin/bash
set -e

echo ">> Setting up environment..."

# لو عندك virtualenv اسمه venv وعايز تفعّله، شيل الكومنت من السطرين دول
# source venv/bin/activate

echo ">> Installing dependencies..."
pip install --no-cache-dir -r requirements.txt

echo ">> Starting the API server..."
# PORT و WORKERS ممكن تتحدد كـ environment variables، ولهم قيم افتراضية لو مش موجودة
export PORT="${PORT:-8000}"
export WORKERS="${WORKERS:-1}"   # خليها 1 لو شغال على GPU (كل worker بيحمّل نسخة منفصلة من الموديل)

gunicorn main:app \
    --bind "0.0.0.0:${PORT}" \
    --timeout 600 \
    --workers "${WORKERS}" \
    --worker-class uvicorn.workers.UvicornWorker
