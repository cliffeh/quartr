FROM python:3.12-alpine

WORKDIR /app

RUN adduser --disabled-password app

# install dependencies globally as root
COPY pyproject.toml .
RUN pip install --no-cache-dir --upgrade pip .

# install the application code as app
COPY hypercorn.toml src /app/
# NB dependency install creates files the app user needs to be able to write to
RUN chown -R app:app /app
USER app
RUN pip install --no-deps --user .

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--config", "hypercorn.toml"]
