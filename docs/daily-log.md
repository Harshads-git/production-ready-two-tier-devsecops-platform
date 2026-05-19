# Daily Progress Log

## Day 1 - Project Foundation

Date: 2026-05-18

### What I Built

- Created the project structure for a portfolio-grade DevSecOps project.
- Added a minimal Flask service with `/` and `/health` endpoints.
- Started documentation for architecture, security, and operations.
- Added `.gitignore` and `.env.example` to avoid committing secrets.

### What I Learned

- A strong DevOps portfolio project should show system thinking, not only code.
- A health endpoint is a basic but important reliability feature.
- Environment files should be treated carefully because they often contain secrets.

### Evidence

- Flask app exists in `app/app.py`.
- Dependencies are listed in `app/requirements.txt`.
- Project overview is documented in `README.md`.
- Setup requirements are documented in `docs/setup-checklist.md`.
- A helper script exists at `scripts/push-day1.ps1` to publish the Day 1 commit.

### Verification

- File structure was created successfully.
- Python execution could not be verified yet because Python is not installed on this machine.
- GitHub progress could not be pushed from Codex because the sandbox could not update Git metadata. It should be pushed from normal Windows PowerShell.

### Next Step

Run `.\scripts\push-day1.ps1` from normal Windows PowerShell, verify the commit on GitHub, then fix Python availability before beginning Docker setup.

## Day 2 - Local App Test Workflow

Date: 2026-05-19

### What I Built

- Improved the Flask service response to include service name and version metadata.
- Kept `/health` as a simple machine-readable health check for future Docker and CI/CD use.
- Added pytest tests for the root endpoint and health endpoint.
- Added `scripts/run-local.ps1` for starting the app locally.
- Added `scripts/test-local.ps1` for running the test suite locally.
- Updated the README and runbook with the new local workflow.

### What I Learned

- A health endpoint is useful because infrastructure tools need a simple way to know whether a service is alive.
- Tests protect even small services from accidental behavior changes.
- A clean run script and test script make the project easier for recruiters, teammates, and future automation to understand.

### Evidence

- App code is in `app/app.py`.
- Tests are in `tests/test_app.py`.
- Local commands are in `scripts/run-local.ps1` and `scripts/test-local.ps1`.
- Run instructions are documented in `README.md` and `docs/runbook.md`.

### Verification

- Git state was clean at the start of Day 2.
- The local test script was executed with PowerShell's temporary execution-policy bypass.
- The local test script now reports a clear setup blocker: Python is not available from PowerShell.
- Docker is installed, but Docker Desktop was not running, so container checks were not executed.
- Confirmed Day 2 work was pushed to GitHub.

### Next Step

Fix Python availability from PowerShell, run `.\scripts\test-local.ps1`, then begin Dockerfile and Docker Compose work.
