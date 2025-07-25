FROM python:3.12-alpine

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -e .

EXPOSE 5000

CMD ["hypercorn", "quartr.asgi:app", "--bind", ":5000"]
