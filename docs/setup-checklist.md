# Setup Checklist

Complete these once before daily project work begins.

## Required Accounts

- Create or use your GitHub account.
- Create an empty GitHub repository for this project.
- Do not fork the reference repository.

Suggested repository name:

```text
production-ready-two-tier-devsecops-platform
```

## Required Tools

- Git: https://git-scm.com/downloads
- Python: https://www.python.org/downloads/
- Docker Desktop: https://www.docker.com/products/docker-desktop/
- VS Code: https://code.visualstudio.com/

During Python installation, enable the option that adds Python to PATH.

During Git setup, use the same email address that is connected to your GitHub account. GitHub only shows commits in the contribution graph when they match GitHub's contribution rules.

## After Installing Git

Run this command in normal Windows PowerShell from the project folder:

```powershell
.\scripts\push-day1.ps1
```

If you prefer to run the commands manually, use:

```powershell
git init
git branch -M main
git config user.name "Your Name"
git config user.email "your-github-email@example.com"
git add .
git commit -m "Day 1: initialize DevSecOps platform project"
git remote add origin https://github.com/YOUR_USERNAME/production-ready-two-tier-devsecops-platform.git
git push -u origin main
```

For this project, the remote repository is:

```text
https://github.com/Harshads-git/production-ready-two-tier-devsecops-platform.git
```

## After Installing Python

Run:

```powershell
python --version
py --version
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\scripts\test-local.ps1
.\scripts\run-local.ps1
```

Then open:

```text
http://127.0.0.1:5000/health
```

## After Installing Docker

Run:

```powershell
docker --version
docker compose version
```

If Docker is installed but the daemon is not running, open Docker Desktop first and wait until it says the engine is running.
