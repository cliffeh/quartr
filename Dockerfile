FROM python:3.12-slim

WORKDIR /app

# Update system packages to reduce vulnerabilities
RUN apt update && apt upgrade -y

COPY . .

RUN pip install --no-cache-dir -e .

EXPOSE 5000

CMD ["quart", "--app", "quartr", "run", "--host", "::", "--port", "5000"]
