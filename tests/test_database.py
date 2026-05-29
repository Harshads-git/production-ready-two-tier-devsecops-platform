from app.config import DatabaseConfig
from app.database import fetch_database_status, fetch_visit_count, record_visit


class FakeCursor:
    lastrowid = 42

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        return False

    def execute(self, query, params=None):
        self.query = query
        self.params = params

    def fetchone(self):
        if "COUNT" in self.query:
            return {"total_visits": 7}

        return {
            "database_name": "appdb",
            "database_version": "8.4.0",
        }


class FakeConnection:
    def __init__(self):
        self.commit_count = 0

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        return False

    def cursor(self):
        return FakeCursor()

    def commit(self):
        self.commit_count += 1


def make_config():
    return DatabaseConfig(
        host="db",
        port=3306,
        name="appdb",
        user="appuser",
        password="secret",
    )


def test_fetch_database_status_returns_database_metadata(monkeypatch):
    config = make_config()

    monkeypatch.setattr("app.database.open_connection", lambda received: FakeConnection())

    status = fetch_database_status(config)

    assert status == {
        "database_name": "appdb",
        "database_version": "8.4.0",
    }


def test_record_visit_inserts_visit_and_commits(monkeypatch):
    config = make_config()
    connection = FakeConnection()

    monkeypatch.setattr("app.database.open_connection", lambda received: connection)

    visit = record_visit(config, source="test")

    assert visit == {
        "id": 42,
        "source": "test",
    }
    assert connection.commit_count == 2


def test_fetch_visit_count_returns_total(monkeypatch):
    config = make_config()

    monkeypatch.setattr("app.database.open_connection", lambda received: FakeConnection())

    count = fetch_visit_count(config)

    assert count == {
        "total_visits": 7,
    }
