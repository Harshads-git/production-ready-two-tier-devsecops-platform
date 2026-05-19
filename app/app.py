from flask import Flask, jsonify


def create_app() -> Flask:
    app = Flask(__name__)
    app.config["SERVICE_NAME"] = "two-tier-devsecops-platform"
    app.config["SERVICE_VERSION"] = "0.1.0"

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

    return app


if __name__ == "__main__":
    create_app().run(host="127.0.0.1", port=5000, debug=True)
