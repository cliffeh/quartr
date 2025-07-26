FROM python:3.12-alpine

WORKDIR /app

COPY hypercorn.toml pyproject.toml src /app/

RUN pip install --no-cache-dir .
RUN adduser --disabled-password app

USER app

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--config", "hypercorn.toml"]
