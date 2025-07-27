FROM python:3.12-alpine

WORKDIR /app

RUN adduser --disabled-password app

# install dependencies globally as root
COPY --chown app:app pyproject.toml .
RUN pip install --no-cache-dir --upgrade pip .

# install the application code as app
COPY --chown app:app hypercorn.toml src /app/
USER app
RUN pip install --no-deps --user .

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--config", "hypercorn.toml"]
