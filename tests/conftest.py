import pytest
from quart import Quart

from quartr.app import create_app


@pytest.fixture
def app():
    app = create_app()
    app.config["TESTING"] = True
    return app


@pytest.fixture
def client(app: Quart):
    return app.test_client()
