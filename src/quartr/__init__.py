from .hello import blueprint as hello_blueprint
from quart import Quart


def create_app() -> Quart:
    # create and configure the app
    app = Quart(__name__, static_url_path="/")
    app.config.from_mapping(
        SECRET_KEY="dev",
    )

    app.register_blueprint(hello_blueprint, url_prefix="/hello")

    return app
