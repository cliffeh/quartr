FROM mcr.microsoft.com/devcontainers/python:1-3.12-bullseye

WORKDIR /build

# install dependencies globally as root
COPY pyproject.toml .
RUN pip install --upgrade pip
RUN pip install .[dev]

# install quartr as the vscode user
# TODO figure out how to use a more generic app user here
COPY src README.md /build/
RUN chown -R vscode:vscode /build
USER vscode
RUN pip install --user -e .[dev]

EXPOSE 5000

# this should get restarted by the dev container pip install
CMD ["quart", "--debug", "--app", "quartr.app", "run", "--host", "localhost", "--port", "5000", "--reload"]
