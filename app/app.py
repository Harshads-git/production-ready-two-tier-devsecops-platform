import os

from flask import Flask, jsonify

from app.config import load_database_config
from app.database import fetch_database_status


def create_app() -> Flask:
    app = Flask(__name__)
    app.config["SERVICE_NAME"] = "two-tier-devsecops-platform"
    app.config["SERVICE_VERSION"] = "0.1.0"
    app.config["DATABASE"] = load_database_config()

    @app.get("/")
    def index():
        return jsonify(
            {
                "service": app.config["SERVICE_NAME"],
                "version": app.config["SERVICE_VERSION"],
                "status": "running",
                "message": "Flask service is alive",
            }
        )

    @app.get("/health")
    def health():
        return jsonify(
            {
                "service": app.config["SERVICE_NAME"],
                "status": "healthy",
            }
        )

    @app.get("/db/health")
    def database_health():
        try:
            database_status = fetch_database_status(app.config["DATABASE"])
        except Exception as exc:
            return (
                jsonify(
                    {
                        "service": app.config["SERVICE_NAME"],
                        "status": "unhealthy",
                        "database": "unreachable",
                        "error": exc.__class__.__name__,
                    }
                ),
                503,
            )

        return jsonify(
            {
                "service": app.config["SERVICE_NAME"],
                "status": "healthy",
                "database": database_status,
            }
        )

    return app


if __name__ == "__main__":
    host = os.getenv("APP_HOST", "127.0.0.1")
    port = int(os.getenv("APP_PORT", "5000"))
    debug = os.getenv("FLASK_DEBUG", "false").lower() == "true"

    create_app().run(host=host, port=port, debug=debug)
