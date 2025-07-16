import pytest


@pytest.mark.asyncio
async def test_hello(client):
    response = await client.get("/hello")
    assert response.status_code == 200
    payload = await response.data
    assert payload == b"Hello, World!"


@pytest.mark.asyncio
async def test_hello_name(client):
    response = await client.get("/hello?name=Quartr")
    assert response.status_code == 200
    payload = await response.data
    assert payload == b"Hello, Quartr!"
