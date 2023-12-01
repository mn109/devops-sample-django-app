#!/bin/bash
set -e

# Run database migrations
echo "Running database migrations..."
python manage.py migrate

# Execute the passed command
exec "$@"
