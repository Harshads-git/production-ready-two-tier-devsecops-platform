# Contribution Strategy

This project targets at least three meaningful GitHub contributions every day.

## What Counts As A Good Daily Set

Use this pattern:

1. Build commit: one technical improvement.
2. Verify commit: one test, script, config, or troubleshooting improvement.
3. Explain commit: one documentation, diagram, runbook, or daily-log improvement.

Examples:

- Build commit: add Dockerfile.
- Verify commit: add health check or test command.
- Explain commit: document how the Docker image is built and tested.
- Build commit: add CI test workflow.
- Verify commit: add pipeline status badge or test note.
- Explain commit: add pipeline diagram and failure notes.
- Build commit: add Terraform security group.
- Verify commit: add validation output or security scan note.
- Explain commit: document why each port is allowed.

## Daily 1-Hour Workflow

### First 5 Minutes

- Pull latest changes.
- Check `git status`.
- Pick one small technical goal.

### Next 35 Minutes

- Build the technical change.
- Run the smallest useful verification.

### Next 8 Minutes

- Commit the technical change.
- Use a clear commit message.

### Next 7 Minutes

- Commit the verification change.
- Record test output, config validation, or troubleshooting notes.

### Final 5 Minutes

- Update `docs/daily-log.md`.
- Commit the evidence update.
- Push all three commits.

## Commit Message Style

Use short, clear messages:

```text
Day 3: add Flask Dockerfile
Day 3: verify Docker Compose config
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
- `git log -3 --format="%h %ae %s"` shows the correct email on all three commits.
- GitHub repo shows the three commits on `main`.
- GitHub profile contribution graph updates, sometimes after a short delay.

