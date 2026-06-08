# Jenkins Work

Jenkins work starts after the GitHub Actions test, Docker build, secret scan, and vulnerability scan gates exist.

## Current Day 12 Scope

Day 12 is planning-focused. It defines how Jenkins should fit into this project before a Jenkinsfile is added.

## Files

- `pipeline-design.md`: planned stages and how Jenkins complements GitHub Actions.
- `credentials-plan.md`: credential IDs, purpose, and handling rules.
- `agent-requirements.md`: toolchain and access needed by a Jenkins build agent.

## Planned Jenkins Role

Jenkins will model a self-hosted CI/CD path focused on:

- Build orchestration.
- Credential handling.
- Manual deployment approvals.
- Future EC2 deployment automation.

GitHub Actions remains the repository-native CI gate for pushes and pull requests.

