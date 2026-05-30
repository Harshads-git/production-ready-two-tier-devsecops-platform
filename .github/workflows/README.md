# GitHub Actions

## Python Tests

`python-tests.yml` runs on pushes and pull requests targeting `main`.

The workflow:

- Checks out the repository.
- Sets up Python 3.12.
- Installs dependencies from `app/requirements.txt`.
- Runs `pytest`.

This is the first CI quality gate for the project. Docker build and security scanning workflows will be added after this test workflow is stable.

