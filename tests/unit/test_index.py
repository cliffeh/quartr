import pytest


@pytest.mark.asyncio
async def test_index(client) -> None:
    response = await client.get("/")
    assert response.status_code == 200
    payload = await response.data
    assert payload.startswith(b"<!DOCTYPE html>")


@pytest.mark.asyncio
async def test_index_html(client) -> None:
    response = await client.get("/index.html")
    assert response.status_code == 200
    payload = await response.data
    assert payload.startswith(b"<!DOCTYPE html>")
