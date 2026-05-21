# Daily Automation Workflow

The project uses a simple local automation script to finish each day with three meaningful commits.

## Why This Exists

The goal is at least three useful GitHub contributions per day:

1. A technical commit.
2. A verification commit.
3. A documentation or evidence commit.

The script keeps commit identity consistent and reduces repeated Git commands.

## One-Time Setup

Run this once in PowerShell:

```powershell
cd "C:\Users\harsh\Documents\New project 3"
git config --global user.name "Harshads-git"
git config --global user.email "183264980+Harshads-git@users.noreply.github.com"
```

## Daily Finish Command

After Codex completes the day's work, run:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\finish-day.ps1 -Day "Day 3" -TechnicalMessage "dockerize Flask app" -EvidenceMessage "document Docker workflow"
```

Change the day and messages each day.

Day 4 example:

```powershell
.\scripts\finish-day.ps1 -Day "Day 4" -TechnicalMessage "add MySQL Compose service" -VerificationMessage "add database config tests" -EvidenceMessage "document MySQL Compose workflow"
```

## Daily Verification

After the script runs, check:

```powershell
git log -3 --format="%h %ad %ae %s" --date=short
git status
```

The latest commits should show:

```text
183264980+Harshads-git@users.noreply.github.com
```

`git status` should show a clean working tree.

## GitHub Visibility Backup

If the GitHub contribution graph does not update quickly:

- Confirm the repo default branch is `main`.
- Confirm private contributions are visible if the repo is private.
- Open the latest three commits in GitHub and check that they appear under the correct account.
- As a fallback, create one GitHub web edit to `docs/daily-log.md` and one GitHub issue for the next day.
