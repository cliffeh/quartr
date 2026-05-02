FROM python:3.12-alpine

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip

COPY pyproject.toml src ./
RUN pip install --no-cache-dir .

RUN adduser --disabled-password app
USER app

# defaults that can be overridden by build args
ARG UVICORN_HOST="0.0.0.0"
ARG UVICORN_PORT=8000
ENV UVICORN_HOST=${UVICORN_HOST}
ENV UVICORN_PORT=${UVICORN_PORT}

EXPOSE ${UVICORN_PORT}

CMD ["uvicorn", "quartr.asgi:app"]
