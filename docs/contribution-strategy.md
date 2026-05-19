# Contribution Strategy

This project targets at least two meaningful GitHub contributions every day.

## What Counts As A Good Daily Pair

Use this pattern:

1. Build commit: one technical improvement.
2. Explain commit: one documentation, diagram, runbook, or daily-log improvement.

Examples:

- Build commit: add Dockerfile.
- Explain commit: document how the Docker image is built and tested.
- Build commit: add CI test workflow.
- Explain commit: add pipeline diagram and failure notes.
- Build commit: add Terraform security group.
- Explain commit: document why each port is allowed.

## Daily 1-Hour Workflow

### First 5 Minutes

- Pull latest changes.
- Check `git status`.
- Pick one small technical goal.

### Next 35 Minutes

- Build the technical change.
- Run the smallest useful verification.

### Next 10 Minutes

- Commit the technical change.
- Use a clear commit message.

### Final 10 Minutes

- Update `docs/daily-log.md`.
- Commit the evidence update.
- Push both commits.

## Commit Message Style

Use short, clear messages:

```text
Day 3: add Flask Dockerfile
Day 3: document Docker run workflow
```

## Identity Rule

Local Git commits must use the GitHub-linked no-reply email:

```text
183264980+Harshads-git@users.noreply.github.com
```

Check it with:

```powershell
git config user.email
```

## Contribution Graph Checklist

Before ending each day:

- `git status` says the working tree is clean.
- `git log -2 --format="%h %ae %s"` shows the correct email on both commits.
- GitHub repo shows both commits on `main`.
- GitHub profile contribution graph updates, sometimes after a short delay.

