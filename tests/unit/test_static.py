import pytest


@pytest.mark.asyncio
async def test_static(client) -> None:
    response = await client.get("/site.webmanifest")
    assert response.status_code == 200
    payload = await response.json
    assert isinstance(payload, dict)
