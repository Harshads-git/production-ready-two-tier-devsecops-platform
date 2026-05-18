from flask import Flask, jsonify


def create_app() -> Flask:
    app = Flask(__name__)

    @app.get("/")
    def index():
        return jsonify(
            {
                "service": "two-tier-devsecops-platform",
                "status": "running",
                "message": "Day 1 Flask service is alive",
            }
        )

    @app.get("/health")
    def health():
        return jsonify({"status": "healthy"})

    return app


if __name__ == "__main__":
    create_app().run(host="127.0.0.1", port=5000, debug=True)

