FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

WORKDIR /build

# install dependencies globally as root
COPY pyproject.toml .
RUN pip install --upgrade pip .[dev]

EXPOSE 5000

WORKDIR /workspaces/quartr
USER vscode
CMD [".devcontainer/run-server.sh"]
