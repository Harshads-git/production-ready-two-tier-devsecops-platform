# Secret Management Policy

## Rules

- Never commit real `.env` files.
- Keep only `.env.example` in Git.
- Use placeholders such as `change-me-locally` in examples.
- Store cloud, database, and registry credentials in GitHub Actions secrets or a cloud secret manager.
- Rotate a secret immediately if it is accidentally committed.

## Current Controls

- `.gitignore` blocks `.env` and `.env.*`.
- `.gitleaks.toml` enables default Gitleaks rules and allows documented placeholders.
- `.github/workflows/secret-scan.yml` runs Gitleaks on push and pull request.
- `scripts/verify-secrets.ps1` checks for local env files and obvious secret-like patterns.

## Incident Response

If a secret is committed:

1. Revoke or rotate the secret at the provider.
2. Remove the secret from the codebase.
3. Review GitHub Actions logs and repository history.
4. Document the incident and prevention step in the runbook.

