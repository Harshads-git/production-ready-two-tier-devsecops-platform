# Jenkins Credentials Plan

## Rule

No Jenkins credential value should be committed to this repository.

Only credential identifiers, required scopes, and usage notes belong in documentation.

## Planned Credentials

| Credential ID | Type | Purpose | Scope |
| --- | --- | --- | --- |
| `github-repo-token` | Secret text or GitHub App credential | Checkout private repository if needed | Read-only repository access |
| `docker-registry-credentials` | Username and password/token | Push images to a registry in later stages | Registry push/pull |
| `ec2-ssh-key` | SSH private key | Deploy to an EC2 host in later stages | Restricted deployment host access |
| `aws-deploy-role` | AWS credentials or role integration | Infrastructure and deployment automation | Least privilege AWS access |

## Credential Handling

- Store credentials in Jenkins Credentials Manager.
- Reference credentials by ID in the Jenkinsfile.
- Prefer short-lived tokens and role-based access when available.
- Rotate any credential that appears in logs or source control.
- Restrict Jenkins job permissions so only trusted users can run deployment stages.

## Logging Rules

- Do not echo secret values.
- Avoid printing environment variables wholesale.
- Use Jenkins masking for credentials injected into build steps.
- Keep deployment logs useful but not sensitive.

