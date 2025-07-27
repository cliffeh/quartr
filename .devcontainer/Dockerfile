FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

WORKDIR /build

# install dependencies
COPY .devcontainer/entrypoint.sh pyproject.toml /build/
RUN pip install --upgrade pip .[dev]

EXPOSE 5000

USER vscode
ENTRYPOINT ["./entrypoint.sh"]
