import pytest
from quart import Quart

from quartr.app import create_app


@pytest.fixture
def app():
    return create_app()


@pytest.fixture
def client(app: Quart):
    return app.test_client()
