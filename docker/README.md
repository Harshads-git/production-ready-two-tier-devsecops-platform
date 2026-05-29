# Docker Work

Day 3 added the first containerized version of the Flask service. Day 4 adds MySQL as the second tier.

## Files

- `Dockerfile`: builds the Flask application image.
- `.dockerignore`: keeps local-only files out of the image build context.
- `docker-compose.yml`: runs the app service and MySQL service.

## Build

```powershell
docker build -t two-tier-devsecops-app:day3 .
```

## Run

```powershell
docker run --rm -p 5000:5000 --name two-tier-devsecops-app two-tier-devsecops-app:day3
```

## Compose

```powershell
docker compose up --build
```

Services:

- `app`: Flask application
- `db`: MySQL 8.4 database

The `db` service uses a named volume called `mysql-data` so database files survive container restarts.

## Reliability Checks

The Compose stack includes health checks for:

- `app`: calls `/health` inside the Flask container.
- `db`: uses `mysqladmin ping` inside the MySQL container.

Run the full verification workflow:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\verify-stack.ps1
```

## Health

```text
http://127.0.0.1:5000/health
```

Expected response:

```json
{"service":"two-tier-devsecops-platform","status":"healthy"}
```

## Database Health

```text
http://127.0.0.1:5000/db/health
```

This endpoint verifies that Flask can connect to MySQL and run a simple metadata query.

## Database Initialization

The MySQL container loads schema files from:

```text
database/init/
```

Current schema file:

```text
database/init/001_schema.sql
```

It creates the `app_visits` table used by the visit API.

Reset local database state:

```powershell
docker compose down -v
docker compose up -d --build
```

## Database Configuration

The app reads database settings from environment variables:

- `DATABASE_HOST`
- `DATABASE_PORT`
- `DATABASE_NAME`
- `DATABASE_USER`
- `DATABASE_PASSWORD`

In Docker Compose, `DATABASE_HOST` is set to `db`, which is the MySQL service name.
