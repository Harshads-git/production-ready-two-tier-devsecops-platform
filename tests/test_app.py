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


def test_database_health_returns_database_metadata(monkeypatch):
    monkeypatch.setattr(
        "app.app.fetch_database_status",
        lambda config: {
            "database_name": "appdb",
            "database_version": "8.4.0",
        },
    )

    app = create_app()

    with app.test_client() as client:
        response = client.get("/db/health")

    assert response.status_code == 200
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "healthy",
        "database": {
            "database_name": "appdb",
            "database_version": "8.4.0",
        },
    }


def test_database_health_reports_unreachable_database(monkeypatch):
    def raise_error(config):
        raise RuntimeError("database unavailable")

    monkeypatch.setattr("app.app.fetch_database_status", raise_error)

    app = create_app()

    with app.test_client() as client:
        response = client.get("/db/health")

    assert response.status_code == 503
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "unhealthy",
        "database": "unreachable",
        "error": "RuntimeError",
    }


def test_visits_endpoint_returns_visit_count(monkeypatch):
    monkeypatch.setattr(
        "app.app.fetch_visit_count",
        lambda config: {"total_visits": 7},
    )

    app = create_app()

    with app.test_client() as client:
        response = client.get("/visits")

    assert response.status_code == 200
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "healthy",
        "visits": {
            "total_visits": 7,
        },
    }


def test_visits_endpoint_reports_database_failure(monkeypatch):
    def raise_error(config):
        raise RuntimeError("database unavailable")

    monkeypatch.setattr("app.app.fetch_visit_count", raise_error)

    app = create_app()

    with app.test_client() as client:
        response = client.get("/visits")

    assert response.status_code == 503
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "unhealthy",
        "error": "RuntimeError",
    }


def test_create_visit_endpoint_records_visit(monkeypatch):
    monkeypatch.setattr(
        "app.app.record_visit",
        lambda config: {
            "id": 42,
            "source": "api",
        },
    )

    app = create_app()

    with app.test_client() as client:
        response = client.post("/visits")

    assert response.status_code == 201
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "created",
        "visit": {
            "id": 42,
            "source": "api",
        },
    }


def test_create_visit_endpoint_reports_database_failure(monkeypatch):
    def raise_error(config):
        raise RuntimeError("database unavailable")

    monkeypatch.setattr("app.app.record_visit", raise_error)

    app = create_app()

    with app.test_client() as client:
        response = client.post("/visits")

    assert response.status_code == 503
    assert response.get_json() == {
        "service": "two-tier-devsecops-platform",
        "status": "unhealthy",
        "error": "RuntimeError",
    }
