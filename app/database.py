from typing import Any

import pymysql
from pymysql.cursors import DictCursor

from app.config import DatabaseConfig


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
