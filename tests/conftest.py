import pytest
from quart import Quart

from quartr import create_app


@pytest.fixture
def app():
    return create_app()


@pytest.fixture
def client(app: Quart):
    return app.test_client()
