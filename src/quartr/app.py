from quart import Quart

from .blueprints.health import blueprint as health_blueprint
from .blueprints.hello import blueprint as hello_blueprint


def create_app() -> Quart:
    """Create and configure the quartr application."""
    app = Quart(__name__)
    app.config.from_prefixed_env("QUARTR")

    app.register_blueprint(health_blueprint)
    app.register_blueprint(hello_blueprint)

    return app
