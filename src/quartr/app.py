from quart import Quart

from .hello import blueprint as hello_blueprint


def create_app() -> Quart:
    # create and configure the app
    app = Quart(__name__)
    app.config.from_mapping(
        SECRET_KEY="dev",
    )

    app.register_blueprint(hello_blueprint)

    return app
