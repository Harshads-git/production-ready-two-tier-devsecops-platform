# Runbook

This file will become the operational guide for running, deploying, debugging, and recovering the system.

## Local Service Start

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\run-local.ps1
```

## Health Check

```text
GET http://127.0.0.1:5000/health
```

Expected response:

```json
{"service":"two-tier-devsecops-platform","status":"healthy"}
```

## Local Test Run

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\test-local.ps1
```

## Docker Build

Start Docker Desktop before running these commands.

```powershell
docker build -t two-tier-devsecops-app:day3 .
```

## Docker Run

```powershell
docker run --rm -p 5000:5000 --name two-tier-devsecops-app two-tier-devsecops-app:day3
```

## Docker Compose Run

```powershell
docker compose up --build
```

Stop the Compose stack:

```powershell
docker compose down
```

## Docker Compose Services

- `app`: Flask application container, published on host port `5000`.
- `db`: MySQL database container, reachable by the app as host `db`.

The MySQL container is not published to the host by default. This keeps the database internal to the Docker network and reduces accidental exposure.

## Docker Troubleshooting

If `Invoke-RestMethod http://127.0.0.1:5000/health` says the connection closed unexpectedly, inspect the containers:

```powershell
docker compose ps
docker compose logs app
docker compose logs db
```

The Flask container starts the app as a module with `python -m app.app` so package imports work correctly inside Docker.

## Container Health Check

Open:

```text
http://127.0.0.1:5000/health
```

Expected response:

```json
{"service":"two-tier-devsecops-platform","status":"healthy"}
```

## Database Health Check

After the Compose stack is running, open:

```text
http://127.0.0.1:5000/db/health
```

Expected successful response shape:

```json
{
  "service": "two-tier-devsecops-platform",
  "status": "healthy",
  "database": {
    "database_name": "appdb",
    "database_version": "8.4.x"
  }
}
```

If MySQL is unreachable, the endpoint returns HTTP `503` with an error type. This is intentional because database health is different from basic app health.

## Table-Backed Visit API

Record a visit:

```powershell
Invoke-RestMethod -Method Post http://127.0.0.1:5000/visits
```

Read total visits:

```powershell
Invoke-RestMethod http://127.0.0.1:5000/visits
```

The `app_visits` table is created automatically from:

```text
database/init/001_schema.sql
```

MySQL only runs initialization files when the database volume is first created. To test schema changes from scratch during local development:

```powershell
docker compose down -v
docker compose up -d --build
```

Use `docker compose down -v` carefully because it deletes the local MySQL volume.

## Current Known Setup Gaps

- Python must be available from PowerShell before the Flask service and tests can run.
- Docker Desktop must be running before containerization can begin.
- A GitHub repository URL is required before remote progress can be pushed.

See `docs/setup-checklist.md` for the setup steps.
