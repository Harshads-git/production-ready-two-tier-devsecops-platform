from app.app import create_app


def test_index_returns_service_metadata():
    app = create_app()

    with app.test_client() as client:
        response = client.get("/")

    assert response.status_code == 200
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "version": "0.1.0",
        "status": "running",
        "message": "Flask service is alive",
    }


def test_health_endpoint_returns_healthy_status():
    app = create_app()

    with app.test_client() as client:
        response = client.get("/health")

    assert response.status_code == 200
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "healthy",
    }
