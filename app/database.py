from typing import Any

import pymysql
from pymysql.cursors import DictCursor

from app.config import DatabaseConfig


VISIT_SCHEMA_SQL = """
CREATE TABLE IF NOT EXISTS app_visits (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    source VARCHAR(80) NOT NULL DEFAULT 'api',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
)
"""


def open_connection(config: DatabaseConfig):
    return pymysql.connect(
        host=config.host,
        port=config.port,
        user=config.user,
        password=config.password,
        database=config.name,
        cursorclass=DictCursor,
        connect_timeout=5,
        read_timeout=5,
        write_timeout=5,
    )


def fetch_database_status(config: DatabaseConfig) -> dict[str, Any]:
    with open_connection(config) as connection:
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT
                    DATABASE() AS database_name,
                    VERSION() AS database_version
                """
            )
            row = cursor.fetchone()

    return {
        "database_name": row["database_name"],
        "database_version": row["database_version"],
    }


def ensure_visit_schema(connection) -> None:
    with connection.cursor() as cursor:
        cursor.execute(VISIT_SCHEMA_SQL)
    connection.commit()


def record_visit(config: DatabaseConfig, source: str = "api") -> dict[str, Any]:
    with open_connection(config) as connection:
        ensure_visit_schema(connection)
        with connection.cursor() as cursor:
            cursor.execute(
                """
                INSERT INTO app_visits (source)
                VALUES (%s)
                """,
                (source,),
            )
            visit_id = cursor.lastrowid
        connection.commit()

    return {
        "id": visit_id,
        "source": source,
    }


def fetch_visit_count(config: DatabaseConfig) -> dict[str, Any]:
    with open_connection(config) as connection:
        ensure_visit_schema(connection)
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT COUNT(*) AS total_visits
                FROM app_visits
                """
            )
            row = cursor.fetchone()

    return {
        "total_visits": row["total_visits"],
    }
