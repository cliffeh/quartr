from quart import Quart, render_template


def create_app(test_config=None):
    # create and configure the app
    app = Quart(__name__, static_url_path="/")
    app.config.from_mapping(
        SECRET_KEY="dev",
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile("config.py", silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    @app.route("/hello", strict_slashes=False)
    async def hello():
        return "Hello, World!"

    return app
