import typing as t

from quart import Blueprint, current_app

blueprint = Blueprint("health", __name__)


@blueprint.route("/healthz", methods=["GET"], strict_slashes=False)
async def healthz() -> dict[str, t.Any]:
    """A simple health check endpoint."""
    return {"status": "ok", "env": current_app.config.get("QUARTR_ENV")}


@blueprint.route("/livez", methods=["GET"], strict_slashes=False)
async def livez() -> dict[str, t.Any]:
    """A simple liveness check endpoint."""
    return {"status": "ok", "env": current_app.config.get("QUARTR_ENV")}


@blueprint.route("/readyz", methods=["GET"], strict_slashes=False)
async def readyz() -> dict[str, t.Any]:
    """A simple readiness check endpoint."""
    return {"status": "ok", "env": current_app.config.get("QUARTR_ENV")}
