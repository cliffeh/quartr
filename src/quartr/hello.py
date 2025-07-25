from quart import Blueprint, request

blueprint = Blueprint("hello", __name__)


@blueprint.route("/hello", methods=["GET"], strict_slashes=False)
async def hello() -> str:
    """A simple hello world endpoint."""
    name = request.args.get("name", "World")
    return f"Hello, {name}!"
