#!/bin/bash
set -e

echo "Launching docker-compose..."
/usr/bin/docker-compose -f /home/lllyt/cb-etl-pipeline/docker-compose.yml up -d

echo "Waiting for DB to be healthy..."
until /usr/bin/docker-compose -f /home/lllyt/cb-etl-pipeline/docker-compose.yml ps db | grep -q "healthy"; do
    sleep 2
done

echo "Launching load data script..."
/usr/bin/docker-compose -f /home/lllyt/cb-etl-pipeline/docker-compose.yml run --rm app python app/load_data.py

echo "Data loaded successfully!"
