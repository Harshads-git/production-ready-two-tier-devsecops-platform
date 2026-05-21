from app.config import load_database_config


def test_database_config_uses_local_defaults(monkeypatch):
    monkeypatch.delenv("DATABASE_HOST", raising=False)
    monkeypatch.delenv("DATABASE_PORT", raising=False)
    monkeypatch.delenv("DATABASE_NAME", raising=False)
    monkeypatch.delenv("DATABASE_USER", raising=False)
    monkeypatch.delenv("DATABASE_PASSWORD", raising=False)

    config = load_database_config()

    assert config.host == "localhost"
    assert config.port == 3306
    assert config.name == "appdb"
    assert config.user == "appuser"
    assert config.password == "change-me-locally"


def test_database_config_reads_environment(monkeypatch):
    monkeypatch.setenv("DATABASE_HOST", "db")
    monkeypatch.setenv("DATABASE_PORT", "3307")
    monkeypatch.setenv("DATABASE_NAME", "prodapp")
    monkeypatch.setenv("DATABASE_USER", "produser")
    monkeypatch.setenv("DATABASE_PASSWORD", "secret")

    config = load_database_config()

    assert config.host == "db"
    assert config.port == 3307
    assert config.name == "prodapp"
    assert config.user == "produser"
    assert config.password == "secret"
