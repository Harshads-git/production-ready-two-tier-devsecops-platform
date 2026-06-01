# CI/CD Notes

## Day 8 Baseline

The first CI workflow is `.github/workflows/python-tests.yml`.

It runs on:

- Pushes to `main`.
- Pull requests targeting `main`.

## Pipeline Steps

```mermaid
flowchart LR
    Push["Push or Pull Request"] --> Checkout["Checkout Repository"]
    Checkout --> Python["Set Up Python 3.12"]
    Python --> Dependencies["Install Dependencies"]
    Dependencies --> Tests["Run Pytest"]
```

## Why This Matters

This workflow turns tests into a shared quality gate. The project is no longer only tested manually on one laptop; GitHub now validates the Python test suite whenever code changes reach `main` or a pull request.

## Current Scope

The workflow checks application unit tests only.

It does not yet:

- Build the Docker image.
- Start the MySQL Compose stack.
- Scan dependencies or containers.
- Deploy to cloud infrastructure.

Those checks will be added in later project days.

## Day 9 Docker Build Gate

The second CI workflow is `.github/workflows/docker-build.yml`.

It runs on:

- Pushes to `main`.
- Pull requests targeting `main`.

## Docker Build Steps

```mermaid
flowchart LR
    Push["Push or Pull Request"] --> Checkout["Checkout Repository"]
    Checkout --> Buildx["Set Up Docker Buildx"]
    Buildx --> Build["Build Docker Image"]
    Build --> Cache["Use GitHub Actions Cache"]
```

## Why This Matters

Python tests prove the code behaves as expected. Docker build CI proves the app can be packaged in a clean environment. Both gates are needed before deployment automation is trustworthy.

The workflow intentionally does not push to a registry yet. Publishing images should come after scanning, tagging strategy, and registry decisions are documented.

## Local Equivalent

Run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\verify-ci.ps1
```

For Docker build verification:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\verify-docker-build.ps1
```

## Day 10 Secret Scan Gate

The third CI workflow is `.github/workflows/secret-scan.yml`.

It runs Gitleaks on pushes and pull requests targeting `main`. This helps catch accidentally committed API keys, private keys, tokens, and other secret-like values before they become operational risk.
