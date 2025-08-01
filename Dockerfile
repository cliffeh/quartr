FROM python:3.12-alpine

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip

COPY hypercorn.toml pyproject.toml src ./
RUN pip install --no-cache-dir .

RUN adduser --disabled-password app
USER app

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--config", "hypercorn.toml"]
