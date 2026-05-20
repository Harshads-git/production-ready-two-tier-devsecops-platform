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

## Container Health Check

Open:

```text
http://127.0.0.1:5000/health
```

Expected response:

```json
{"service":"two-tier-devsecops-platform","status":"healthy"}
```

## Current Known Setup Gaps

- Python must be available from PowerShell before the Flask service and tests can run.
- Docker Desktop must be running before containerization can begin.
- A GitHub repository URL is required before remote progress can be pushed.

See `docs/setup-checklist.md` for the setup steps.
