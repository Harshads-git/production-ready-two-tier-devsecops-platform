import os
from dataclasses import dataclass, field


@dataclass(frozen=True)
class DatabaseConfig:
    host: str
    port: int
    name: str
    user: str
    password: str = field(repr=False)


def load_database_config() -> DatabaseConfig:
    return DatabaseConfig(
        host=os.getenv("DATABASE_HOST", "localhost"),
        port=int(os.getenv("DATABASE_PORT", "3306")),
        name=os.getenv("DATABASE_NAME", "appdb"),
        user=os.getenv("DATABASE_USER", "appuser"),
        password=os.getenv("DATABASE_PASSWORD", "change-me-locally"),
    )
