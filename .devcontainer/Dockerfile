FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

WORKDIR /build

# install dependencies
COPY pyproject.toml .
RUN pip install --upgrade pip .[dev]
