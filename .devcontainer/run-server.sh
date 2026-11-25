#!/bin/bash

uv sync

while true; do
    uv run quart --debug --app quartr.app run --host 0.0.0.0 --port 8000 --reload
    echo "Quart server stopped. Restarting in 3 seconds..."
    sleep 3
    echo "Restarting Quart server..."
done
