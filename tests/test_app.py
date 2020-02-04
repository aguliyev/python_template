import pytest
from app import controller


@pytest.fixture
def client():
    return controller.app.test_client()

def test_index(monkeypatch, client):
    response = client.get('/')
    assert response.status_code == 200
