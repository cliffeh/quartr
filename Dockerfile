FROM python:3.12-alpine

WORKDIR /app

RUN pip install --no-cache-dir --upgrade pip setuptools

RUN adduser --disabled-password --home /app  app

COPY hypercorn.toml pyproject.toml src /app/
RUN chown -R app:app /app
USER app
RUN pip install --no-cache-dir --user .

ENV PATH="/app/.local/bin:${PATH}"

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--config", "hypercorn.toml"]
