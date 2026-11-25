FROM mcr.microsoft.com/devcontainers/python:3-3.14-trixie

COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /uvx /usr/local/bin/

# keep the environment outside of the workspace so it doesn't collide with a .venv
# created on the host
ENV UV_PROJECT_ENVIRONMENT=/opt/venv
ENV UV_PYTHON_DOWNLOADS=never
ENV UV_LINK_MODE=copy
ENV PATH="/opt/venv/bin:${PATH}"

RUN install -d -o vscode -g vscode /opt/venv

USER vscode
WORKDIR /build

# install dependencies; the project itself is installed by run-server.sh
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-install-project

EXPOSE 8000

ENV QUARTR_ENV=development
ENV IN_DEVCONTAINER=true

# NB this requires the local workspace to be mounted at /workspaces/quartr
WORKDIR /workspaces/quartr
CMD [".devcontainer/run-server.sh"]
