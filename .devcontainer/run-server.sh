#!/bin/bash

pip install --user --no-deps -e .[dev]

while true; do
    quart --debug --app quartr.app run --host localhost --port 5000 --reload
    echo "Quart server stopped. Restarting in 3 seconds..."
    sleep 3
    echo "Restarting Quart server..."
done
