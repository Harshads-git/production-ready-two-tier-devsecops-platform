# Jenkins Pipeline Design

## Purpose

Jenkins will model a self-hosted CI/CD path for the two-tier platform. GitHub Actions already provides repository-native quality gates. Jenkins adds experience with an external automation server, credential management, build agents, and deployment-oriented pipeline design.

## Pipeline Goals

- Run the same Python test gate used by GitHub Actions.
- Build the Flask Docker image.
- Run secret and vulnerability checks before deployment.
- Prepare a later deployment stage for EC2 or another target host.
- Keep credentials out of source control.

## Planned Stages

```mermaid
flowchart LR
    Checkout["Checkout"] --> Test["Python Tests"]
    Test --> Build["Docker Build"]
    Build --> SecretScan["Secret Scan"]
    SecretScan --> VulnScan["Vulnerability Scan"]
    VulnScan --> Package["Tag Image"]
    Package --> DeployGate["Manual Deploy Approval"]
    DeployGate --> Deploy["Deploy To Target"]
```

## Stage Details

| Stage | Purpose | Current Status |
| --- | --- | --- |
| Checkout | Pull repository source into Jenkins workspace | Planned |
| Python Tests | Run `pytest` through the project test command | Planned |
| Docker Build | Build the application image from `Dockerfile` | Planned |
| Secret Scan | Run secret hygiene verification | Planned |
| Vulnerability Scan | Run Trivy filesystem and image scans | Planned |
| Tag Image | Apply a traceable image tag from build metadata | Future |
| Manual Deploy Approval | Require human approval before deployment | Future |
| Deploy To Target | Deploy to EC2 or another host | Future |

## Jenkins vs GitHub Actions

GitHub Actions is the repository-native CI system. It is good for fast feedback on pushes and pull requests.

Jenkins is useful for learning:

- Self-hosted automation server operations.
- Plugin and tool installation.
- Credentials stored outside Git.
- Long-running deployment jobs.
- Manual approval gates.
- Deployment to private infrastructure.

## Design Decision

Jenkins will not replace GitHub Actions. It will provide a second automation path focused on deployment operations and self-hosted CI/CD skills.

