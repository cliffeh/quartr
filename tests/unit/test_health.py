import pytest


@pytest.mark.asyncio
async def test_healthz(client) -> None:
    response = await client.get("/healthz")
    assert response.status_code == 200
    payload = await response.json
    assert isinstance(payload, dict)
    assert "status" in payload and payload["status"] == "ok"
    assert "env" in payload and payload["env"] == "testing"


@pytest.mark.asyncio
async def test_livez(client) -> None:
    response = await client.get("/livez")
    assert response.status_code == 200
    payload = await response.json
    assert isinstance(payload, dict)
    assert "status" in payload and payload["status"] == "ok"
    assert "env" in payload and payload["env"] == "testing"


@pytest.mark.asyncio
async def test_readyz(client) -> None:
    response = await client.get("/readyz")
    assert response.status_code == 200
    payload = await response.json
    assert isinstance(payload, dict)
    assert "status" in payload and payload["status"] == "ok"
    assert "env" in payload and payload["env"] == "testing"
