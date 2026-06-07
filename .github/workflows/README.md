# GitHub Actions

## Python Tests

`python-tests.yml` runs on pushes and pull requests targeting `main`.

The workflow:

- Checks out the repository.
- Sets up Python 3.12.
- Installs dependencies from `app/requirements.txt`.
- Runs `pytest`.

This is the first CI quality gate for the project. Docker build and security scanning workflows will be added after this test workflow is stable.

## Docker Build

`docker-build.yml` runs on pushes and pull requests targeting `main`.

The workflow:

- Checks out the repository.
- Sets up Docker Buildx.
- Builds the Flask application image from `Dockerfile`.
- Uses GitHub Actions cache for Docker layers.
- Does not push the image to a registry yet.

This is the second CI quality gate. It proves that the application image can be built in a clean CI environment.

## Vulnerability Scan

`vulnerability-scan.yml` runs on pushes and pull requests targeting `main`.

The workflow:

- Runs a Trivy filesystem scan for dependency and repository vulnerabilities.
- Builds the Docker image locally in CI.
- Runs a Trivy image scan against the built image.
- Uploads SARIF results to GitHub code scanning.

This is the fourth CI quality gate. It checks for high and critical vulnerabilities before deployment automation is added.
