# Operations Guide

This guide summarizes how to run, verify, troubleshoot, back up, and release the platform.

## Start The Stack

```powershell
docker compose up -d --build
```

## Stop The Stack

```powershell
docker compose down
```

## Verify The Stack

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\verify-stack.ps1
```

## Diagnose Failures

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\diagnose-stack.ps1
```

## Back Up MySQL

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\backup-db.ps1
```

Backups are written to:

```text
backups/
```

The `backups/` directory is ignored by Git because database dumps can contain sensitive data.

## Restore MySQL

Use restore only against a local or approved target:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\restore-db.ps1 -BackupFile .\backups\appdb-latest.sql
```

## Release Checklist

Before calling the project release-ready:

- Python tests pass.
- Docker Compose config validates.
- Stack verification passes.
- Secret hygiene check passes.
- Jenkinsfile structure check passes.
- CI/CD docs and runbooks are current.
- No real `.env` files or database dumps are committed.

