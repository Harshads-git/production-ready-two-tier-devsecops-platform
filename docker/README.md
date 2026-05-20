# Docker Work

Day 3 adds the first containerized version of the Flask service.

## Files

- `Dockerfile`: builds the Flask application image.
- `.dockerignore`: keeps local-only files out of the image build context.
- `docker-compose.yml`: runs the app service with a stable local port.

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

## Health

```text
http://127.0.0.1:5000/health
```

Expected response:

```json
{"service":"two-tier-devsecops-platform","status":"healthy"}
```
