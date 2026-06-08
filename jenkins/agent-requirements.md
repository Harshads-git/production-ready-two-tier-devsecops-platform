# Jenkins Agent Requirements

The Jenkins agent that runs this pipeline needs a predictable toolchain.

## Required Tools

- Git
- Python 3.12 or newer
- Docker Engine
- Docker Compose
- Trivy
- Gitleaks or equivalent secret scanner

## Required Access

- Network access to GitHub.
- Permission to build Docker images.
- Future access to a container registry.
- Future restricted access to the deployment target.

## Environment Assumptions

- The agent can run Docker commands.
- The agent workspace is disposable.
- Secrets are injected through Jenkins credentials, not stored in files.
- Deployment stages are blocked behind manual approval until the cloud target is ready.

## Preflight Checks

The Jenkinsfile should verify tool availability early:

```text
git --version
python --version
docker --version
docker compose version
trivy --version
```

