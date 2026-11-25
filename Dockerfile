FROM python:3.13-alpine AS builder

COPY --from=ghcr.io/astral-sh/uv:0.9.26 /uv /bin/

# use the image's python, and don't rely on hardlinks into the uv cache
ENV UV_PYTHON_DOWNLOADS=never
ENV UV_LINK_MODE=copy
ENV UV_COMPILE_BYTECODE=1

WORKDIR /app

# install dependencies separately so they're cached across source changes
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-dev --no-install-project --no-cache

COPY README.md ./
COPY src ./src
RUN uv sync --locked --no-dev --no-cache

FROM python:3.13-alpine

WORKDIR /app

COPY --from=builder /app /app
ENV PATH="/app/.venv/bin:${PATH}"

RUN adduser --disabled-password app
USER app

# defaults that can be overridden by build args
ARG UVICORN_HOST="0.0.0.0"
ARG UVICORN_PORT=8000
ENV UVICORN_HOST=${UVICORN_HOST}
ENV UVICORN_PORT=${UVICORN_PORT}

EXPOSE ${UVICORN_PORT}

CMD ["uvicorn", "quartr.asgi:app"]
