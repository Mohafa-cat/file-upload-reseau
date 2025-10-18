#!/bin/bash
set -e

# Wait for MySQL TCP port
echo "Waiting for MySQL on db:3306..."
while ! bash -c "echo > /dev/tcp/db/3306" 2>/dev/null; do
  sleep 1
done
echo "MySQL reachable."

# Install dependencies
composer install -n

# clear cache
php bin/console cache:clear --no-warmup || true

# Start the container's main process
exec "$@"