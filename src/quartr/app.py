from quart import Quart, render_template

from .blueprints.health import blueprint as health_blueprint
from .blueprints.hello import blueprint as hello_blueprint


def create_app() -> Quart:
    """Create and configure the quartr application."""
    app = Quart(
        __name__,
        static_url_path="",
        static_folder="static",
        template_folder="templates",
    )
    app.config.from_prefixed_env("QUARTR")

    @app.route("/")
    @app.route("/index.html")
    async def index():
        return await render_template("index.html")

    app.register_blueprint(health_blueprint)
    app.register_blueprint(hello_blueprint)

    return app
