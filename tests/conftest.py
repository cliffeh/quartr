import pytest
from quart import Quart
from quart.typing import TestClientProtocol

from quartr import create_app


@pytest.fixture
def app() -> Quart:
    return create_app()


@pytest.fixture
def client(app: Quart) -> TestClientProtocol:
    return app.test_client()
