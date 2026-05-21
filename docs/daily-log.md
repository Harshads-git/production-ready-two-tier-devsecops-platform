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
- Confirmed Day 2 work was pushed to GitHub by checking GitHub-provided no-reply email.

### Next Step

Fix Python availability from PowerShell, run `.\scripts\test-local.ps1`, then begin Dockerfile and Docker Compose work.

### Contribution Plan Update

- Added a 30-day roadmap to keep the project on schedule.
- Added a daily two-contribution strategy: one technical commit and one evidence/documentation commit per day.
- Updated Git helper scripts to use the GitHub-linked no-reply email for future contributions.

## Day 3 - Dockerize Flask App

Date: 2026-05-20

### What I Built

- Added a `Dockerfile` for the Flask application.
- Added `.dockerignore` to keep local files, Git metadata, docs, and tests out of the Docker build context.
- Added `docker-compose.yml` for a repeatable local app container run.
- Updated the Flask startup code so the app can bind to `0.0.0.0` inside a container.
- Added Docker run instructions to the README, runbook, and Docker notes.

### What I Learned

- A containerized Flask app must listen on `0.0.0.0` inside the container so traffic forwarded from the host can reach it.
- `.dockerignore` reduces build context size and avoids copying secrets or local-only files into images.
- Running the app as a non-root user inside the image is a basic container security improvement.

### Evidence

- Docker image definition is in `Dockerfile`.
- Compose service is in `docker-compose.yml`.
- Docker-specific notes are in `docker/README.md`.
- Operational commands are in `docs/runbook.md`.

### Verification

- Git state was clean at the start of Day 3.
- Docker CLI is installed, but Docker Desktop was not running in this environment, so image build could not be executed here.
- Python is still not visible from the Codex sandbox, so local pytest verification could not be executed here.
- Verified Day 3 contribution visibility check from GitHub web.

### Next Step

Run Docker Desktop, build the app image, verify `/health`, then start Day 4 by adding MySQL to Docker Compose.

## Day 4 - Add MySQL Compose Service

Date: 2026-05-21

### What I Built

- Added a MySQL 8.4 `db` service to Docker Compose.
- Added a named Docker volume, `mysql-data`, for database persistence.
- Configured the Flask app container to read database connection values from environment variables.
- Added `app/config.py` to centralize database configuration.
- Added tests for default database config and environment-based overrides.
- Updated the daily automation workflow for three meaningful contributions per day.

### What I Learned

- Docker Compose service names work as DNS names inside the Compose network, so the app can reach MySQL using host `db`.
- MySQL should stay internal to the Docker network by default unless there is a specific local debugging need.
- Named volumes allow database files to survive container restarts.
- A daily contribution system should separate technical work, verification, and documentation.

### Evidence

- MySQL service is defined in `docker-compose.yml`.
- Database environment examples are in `.env.example`.
- Database config code is in `app/config.py`.
- Config tests are in `tests/test_config.py`.
- Docker documentation is updated in `docker/README.md` and `docs/runbook.md`.

### Verification

- `docker compose config` should parse the Compose file and show `app`, `db`, and `mysql-data`.
- `.\scripts\test-local.ps1` should run app and config tests after Python dependencies are installed.
- Docker Desktop must be running before building the stack.
- If the app container closes the `/health` connection unexpectedly, check `docker compose logs app`; the container now starts Flask as a Python module so package imports work correctly.

### Next Step

Run the Day 4 verification commands, push three commits, then start Day 5 by connecting Flask to MySQL with a simple database-backed endpoint.

### Automation Update

- Added `scripts/finish-day.ps1` to make the daily two-commit workflow easier.
- Added `docs/daily-automation.md` to document the one-command daily finish process.
