from typing import TYPE_CHECKING

import pytest

from quartr import create_app

if TYPE_CHECKING:
    from quart import Quart
    from quart.typing import TestClientProtocol


@pytest.fixture
def app() -> Quart:
    return create_app()


@pytest.fixture
def client(app: Quart) -> TestClientProtocol:
    return app.test_client()
