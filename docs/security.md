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

## Day 10 Secret Scanning

- Gitleaks runs in GitHub Actions on push and pull request.
- `.gitleaks.toml` allows documented placeholder values only.
- `scripts/verify-secrets.ps1` checks local env hygiene and obvious secret-like patterns.

## Day 11 Vulnerability Scanning

- Trivy filesystem scanning checks repository and dependency vulnerabilities.
- Trivy image scanning checks the built Docker image.
- The CI workflow focuses on `HIGH` and `CRITICAL` severity findings.
- SARIF results are uploaded to GitHub code scanning when available.

## Vulnerability Response

When a high or critical finding appears:

1. Confirm whether the finding applies to the runtime path.
2. Upgrade the affected dependency or base image when possible.
3. If no fix exists, document the risk and mitigation.
4. Avoid publishing or deploying the image until the decision is clear.
