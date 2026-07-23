# Pipeline Gates

This document summarizes the current quality and security gates before the project enters cloud infrastructure work.

## GitHub Actions Gates

| Gate | Workflow | Purpose | Blocks |
| --- | --- | --- | --- |
| Python Tests | `.github/workflows/python-tests.yml` | Verifies Flask app unit tests | Broken app behavior |
| Docker Build | `.github/workflows/docker-build.yml` | Verifies the app image builds in CI | Broken image packaging |
| Secret Scan | `.github/workflows/secret-scan.yml` | Detects committed credentials and secret-like values | Secret leaks |
| Vulnerability Scan | `.github/workflows/vulnerability-scan.yml` | Scans dependencies, repo files, and image layers | High/critical known vulnerabilities |

## Jenkins Gates

| Gate | Jenkins Stage | Purpose | Status |
| --- | --- | --- | --- |
| Checkout | `Checkout` | Pull source into Jenkins workspace | Added |
| Preflight | `Preflight` | Confirm required agent tools exist | Added |
| Python Tests | `Python Tests` | Run local CI test helper | Added |
| Docker Build | `Docker Build` | Build app image with Jenkins build metadata | Added |
| Secret Scan | `Secret Scan` | Run local secret hygiene helper | Added |
| Vulnerability Scan | `Vulnerability Scan` | Run Trivy scans on repo and image | Added |
| Deploy Approval | Future stage | Require human approval before deployment | Planned |
| Deploy | Future stage | Deploy to cloud target | Planned |

## Local Verification Commands

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\verify-ci.ps1
.\scripts\verify-secrets.ps1
.\scripts\verify-jenkinsfile.ps1
```

Optional checks when tools are available:

```powershell
.\scripts\verify-docker-build.ps1
.\scripts\verify-vulnerabilities.ps1
```

## Current Readiness

The project is ready to begin cloud infrastructure planning because:

- Application tests are automated.
- Docker image builds are automated.
- Secret scanning exists.
- Vulnerability scanning exists.
- Jenkins has a non-deployment pipeline path.
- Deployment is intentionally deferred until infrastructure, credentials, and rollback are designed.

