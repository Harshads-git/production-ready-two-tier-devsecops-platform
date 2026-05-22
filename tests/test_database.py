from app.config import DatabaseConfig
from app.database import fetch_database_status


class FakeCursor:
    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        return False

    def execute(self, query):
        self.query = query

    def fetchone(self):
        return {
            "database_name": "appdb",
            "database_version": "8.4.0",
        }


class FakeConnection:
    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc, traceback):
        return False

    def cursor(self):
        return FakeCursor()


def test_fetch_database_status_returns_database_metadata(monkeypatch):
    config = DatabaseConfig(
        host="db",
        port=3306,
        name="appdb",
        user="appuser",
        password="secret",
    )

    monkeypatch.setattr("app.database.open_connection", lambda received: FakeConnection())

    status = fetch_database_status(config)

    assert status == {
        "database_name": "appdb",
        "database_version": "8.4.0",
    }
