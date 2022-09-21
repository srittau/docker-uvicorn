#!/bin/bash

set -e

if test "${UVICORN_ENV}" = dev; then
    EXTRA_ARGS=--reload
fi

touch /app/log/access.log
touch /app/log/error.log
tail -n 0 --pid $$ -F /app/log/access.log &
tail -n 0 --pid $$ -F /app/log/error.log &
exec /app/virtualenv/bin/uvicorn \
    --app-dir /app \
    --log-config=/app/logging.yml \
    --workers=${UVICORN_WORKERS:-4} \
    --host=0.0.0.0 \
    --port=80 \
    --proxy-headers \
    ${EXTRA_ARGS} \
    "$@"
