# Production-Ready Two-Tier DevSecOps Platform

This is my independent portfolio project for learning AI-resilient cloud, DevOps, and systems design skills. The project starts as a simple two-tier Flask and MySQL application, then grows into a secure, automated, observable, and resilient cloud deployment.

## Goal

Build a production-minded platform around a small web application:

- Flask application layer
- MySQL database layer
- Docker-based local runtime
- CI/CD pipeline
- AWS deployment
- Infrastructure as Code
- Security scanning and secret hygiene
- Monitoring, logging, backup, and failure recovery

## Why This Project Matters

The focus is not only writing application code. The focus is designing and operating the system around it:

- Architecture decisions
- Security tradeoffs
- Deployment automation
- Reliability practices
- Cost awareness
- Documentation and runbooks

## Current Status

Day 4 is in progress:

- Project structure created
- Starter Flask service added with `/` and `/health` endpoints
- Basic pytest coverage added
- Local run and test scripts added
- Flask app containerized with Docker
- MySQL service added to Docker Compose
- Database configuration prepared through environment variables
- Documentation started
- Daily progress log created

Before the app can be run locally, complete the Python setup checklist in [docs/setup-checklist.md](docs/setup-checklist.md).

## Local Run

From the project root:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\run-local.ps1
```

Then open:

```text
http://127.0.0.1:5000
```

## Local Tests

From the project root:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\test-local.ps1
```

## Docker Run

Start Docker Desktop first, then run:

```powershell
docker build -t two-tier-devsecops-app:day3 .
docker run --rm -p 5000:5000 --name two-tier-devsecops-app two-tier-devsecops-app:day3
```

Or use Docker Compose:

```powershell
docker compose up --build
```

The Compose stack starts:

- `app`: Flask application container
- `db`: MySQL database container on the internal Docker network

Health check:

```text
http://127.0.0.1:5000/health
```

Database connectivity check:

```text
http://127.0.0.1:5000/db/health
```

Visit API:

```powershell
Invoke-RestMethod -Method Post http://127.0.0.1:5000/visits
Invoke-RestMethod http://127.0.0.1:5000/visits
```

## Planned Architecture

```mermaid
flowchart LR
    User["User"] --> Nginx["Nginx / Reverse Proxy"]
    Nginx --> Flask["Flask App Container"]
    Flask --> MySQL["MySQL Database Container"]
    CI["CI/CD Pipeline"] --> Registry["Container Registry"]
    Registry --> Flask
    Monitor["Prometheus + Grafana"] --> Flask
    Monitor --> MySQL
```

## Learning Log

Daily progress is tracked in [docs/daily-log.md](docs/daily-log.md).

## Delivery Plan

- 30-day roadmap: [docs/30-day-roadmap.md](docs/30-day-roadmap.md)
- Daily contribution strategy: [docs/contribution-strategy.md](docs/contribution-strategy.md)
- Daily automation workflow: [docs/daily-automation.md](docs/daily-automation.md)
