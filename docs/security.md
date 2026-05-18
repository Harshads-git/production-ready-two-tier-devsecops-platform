# Security Notes

## Security Goals

- Avoid hardcoded secrets.
- Restrict cloud access using least privilege.
- Scan application dependencies and container images.
- Keep deployment ports limited to what the system needs.
- Document security tradeoffs clearly.

## Day 1 Baseline

- Added `.env.example` for safe sample configuration.
- Added `.gitignore` entries for local environment files.
- Planned a dedicated security scanning stage for later CI/CD work.

## Future Controls

- Secret scanning with Gitleaks.
- Dependency and container scanning with Trivy.
- Infrastructure scanning with Checkov.
- Restricted AWS security groups.
- Separate IAM user or role with minimal permissions.

