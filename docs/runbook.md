# Runbook

This file will become the operational guide for running, deploying, debugging, and recovering the system.

## Local Service Start

```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -r app\requirements.txt
py app\app.py
```

## Health Check

```text
GET http://127.0.0.1:5000/health
```

Expected response:

```json
{"status":"healthy"}
```

## Current Known Setup Gaps

- Git is required before commits can be created.
- Python is required before the Flask service can be run.
- Docker is required before containerization can begin.
- A GitHub repository URL is required before remote progress can be pushed.

See `docs/setup-checklist.md` for the setup steps.
