from quartr import create_app

import pytest


@pytest.fixture
def app():
    test_config = {
        "TESTING": True,
    }
    app = create_app(test_config=test_config)

    yield app


@pytest.fixture
def client(app):
    return app.test_client()
