#!/bin/bash
set -e

echo "Running database migrations..."
sleep 5
python manage.py migrate

exec "$@"
