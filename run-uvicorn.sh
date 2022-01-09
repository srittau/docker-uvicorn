#!/bin/bash

set -e

touch /app/log/access.log
touch /app/log/error.log
tail --pid $$ -F /app/log/access.log &
tail --pid $$ -F /app/log/error.log &
exec /app/virtualenv/bin/uvicorn \
    --app-dir /app \
    --log-config=/app/logging.yml \
    --workers=${UVICORN_WORKERS:-4} \
    --host=0.0.0.0 \
    --port=80 \
    --proxy-headers \
    "$@"
