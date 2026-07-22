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

## Day 5 - Connect Flask To MySQL

Date: 2026-05-22

### What I Built

- Added PyMySQL as the MySQL client dependency.
- Added `app/database.py` for opening MySQL connections and querying database metadata.
- Added `/db/health`, a database-backed endpoint that verifies Flask can reach MySQL.
- Added tests for database metadata querying and `/db/health` success/failure behavior.
- Updated Docker image naming to Day 5.
- Updated documentation with database health verification steps.

### What I Learned

- App health and database health should be separate checks because the app can be alive while the database is down.
- A database health endpoint should return HTTP `503` when the database is unreachable.
- Unit tests can mock the database connection so database logic can be tested without needing MySQL running.

### Evidence

- Database connection logic is in `app/database.py`.
- Database-backed endpoint is in `app/app.py`.
- Tests are in `tests/test_app.py` and `tests/test_database.py`.
- Runtime flow is documented in `docs/architecture.md`.

### Verification

- `docker compose config` parsed successfully and showed `app`, `db`, and `mysql-data`.
- Run `.\scripts\test-local.ps1` for unit tests.
- Run `docker compose up -d --build`.
- Check `http://127.0.0.1:5000/health` for app health.
- Check `http://127.0.0.1:5000/db/health` for database connectivity.
- Codex could not run Python tests because Python is not visible in the sandbox PATH; run tests from normal PowerShell.

### Next Step

Start Day 6 by adding a real table-backed endpoint and a repeatable database initialization path.

## Day 6 - Add Table-Backed Visit API

Date: 2026-05-28

### What I Built

- Added `database/init/001_schema.sql` so MySQL can initialize the `app_visits` table automatically.
- Mounted the database initialization directory into the MySQL container.
- Added database functions for recording visits and reading total visit count.
- Added `POST /visits` to insert a visit row.
- Added `GET /visits` to read the total number of visits.
- Updated tests for database insert, commit, count, and API success/failure behavior.

### What I Learned

- MySQL initialization files run when a new database volume is created.
- A named volume preserves state, so schema changes may require `docker compose down -v` in local development.
- A table-backed endpoint proves real app-to-database behavior beyond a basic connectivity check.
- Separating insert and read endpoints makes behavior easier to test and reason about.

### Evidence

- Schema file is in `database/init/001_schema.sql`.
- Database logic is in `app/database.py`.
- API routes are in `app/app.py`.
- Tests are in `tests/test_app.py` and `tests/test_database.py`.
- Operational steps are documented in `docs/runbook.md`.

### Verification

- `.\scripts\test-local.ps1` passed with 13 tests.
- `docker compose config` parsed successfully and showed the Day 6 app image plus the MySQL schema mount.
- Live Docker runtime verification could not run because Docker Desktop's Linux engine was not running.
- When Docker Desktop is running, use `docker compose down -v` if the old database volume exists, then run `docker compose up -d --build`.
- Check `POST /visits` and `GET /visits`.

### Next Step

Start Day 7 by adding container reliability checks, restart behavior notes, and a clean Week 1 review.

## Day 7 - Week 1 Reliability Review

Date: 2026-05-29

### What I Built

- Added an explicit Docker Compose health check for the Flask app container.
- Added `scripts/verify-stack.ps1` to validate the full local stack.
- Added `scripts/diagnose-stack.ps1` to collect Docker diagnostics and logs.
- Added `docs/week-1-review.md` to summarize Week 1 outcomes, decisions, gaps, and Week 2 focus.
- Updated README, Docker notes, and runbook with reliability verification commands.

### What I Learned

- A Compose file can define both startup dependencies and ongoing health checks.
- End-to-end verification should exercise the real user path, not only check that containers are running.
- A diagnostic script saves time because troubleshooting becomes repeatable instead of improvised.
- A weekly review turns scattered commits into a clear portfolio story.
- Existing database volumes can miss new initialization files, so runtime schema checks can make local development more resilient.

### Evidence

- App health check is in `docker-compose.yml`.
- Full stack verification is in `scripts/verify-stack.ps1`.
- Diagnostics are in `scripts/diagnose-stack.ps1`.
- Week 1 summary is in `docs/week-1-review.md`.

### Verification

- `.\scripts\test-local.ps1` passed with 13 tests.
- `docker compose config` passed.
- `.\scripts\verify-stack.ps1` passed end to end.
- Live verification confirmed `/health`, `/db/health`, `POST /visits`, and `GET /visits`.
- Live verification initially found an old-volume schema issue, so the app now ensures the visit table exists before visit reads and writes.

### Next Step

Start Week 2 by adding GitHub Actions CI for Python tests.

## Day 8 - Add GitHub Actions Python CI

Date: 2026-05-30

### What I Built

- Added `.github/workflows/python-tests.yml`.
- Configured CI to run on pushes and pull requests targeting `main`.
- Added Python setup, dependency installation, and pytest execution to the workflow.
- Added a README status badge for the Python Tests workflow.
- Added `scripts/verify-ci.ps1` for local CI-style verification.
- Added CI/CD notes in `docs/ci-cd.md`.

### What I Learned

- CI turns tests into an automated quality gate instead of a manual habit.
- GitHub Actions workflows should start small and reliable before adding Docker, security scans, and deployment.
- Running a local CI-equivalent script before pushing reduces avoidable pipeline failures.

### Evidence

- CI workflow is in `.github/workflows/python-tests.yml`.
- Local CI verification is in `scripts/verify-ci.ps1`.
- CI documentation is in `docs/ci-cd.md`.
- README includes a GitHub Actions status badge.

### Verification

- `.\scripts\verify-ci.ps1` passed locally with 13 tests.
- Push to GitHub and confirm the Python Tests workflow runs on `main`.

### Next Step

Start Day 9 by adding a Docker image build workflow in GitHub Actions.

## Day 9 - Add Docker Build CI

Date: 2026-05-31

### What I Built

- Added `.github/workflows/docker-build.yml`.
- Configured Docker image build CI on pushes and pull requests targeting `main`.
- Added Docker Buildx setup and GitHub Actions layer caching.
- Kept image publishing disabled until scanning and registry decisions are added.
- Added `scripts/verify-docker-build.ps1` for local Docker build verification.
- Added a Docker Build badge to the README.

### What I Learned

- Python test CI and Docker build CI validate different risks.
- A Docker image should build successfully in a clean CI environment before deployment is automated.
- It is better to build first, then add scanning, then decide registry publishing.
- Docker layer caching makes repeated CI builds faster.

### Evidence

- Docker workflow is in `.github/workflows/docker-build.yml`.
- Local Docker build verification is in `scripts/verify-docker-build.ps1`.
- CI/CD notes are updated in `docs/ci-cd.md`.
- README includes a Docker Build badge.

### Verification

- `.\scripts\verify-ci.ps1` passed locally with 13 tests.
- `.\scripts\verify-docker-build.ps1` stopped correctly because Docker Desktop's Linux engine was not running.
- Push to GitHub and confirm Docker Build workflow runs on `main`.
- Local Docker build verification correctly fails if the Docker engine is not running.

### Next Step

Start Day 10 by adding secret hygiene checks and a documented secret-handling policy.

## Day 11 - Add Vulnerability Scanning

Date: 2026-06-07

### What I Built

- Added `.github/workflows/vulnerability-scan.yml`.
- Added Trivy filesystem scanning for repository and dependency vulnerabilities.
- Added Trivy Docker image scanning after a CI image build.
- Configured SARIF upload for GitHub code scanning.
- Added `scripts/verify-vulnerabilities.ps1` for local vulnerability verification.
- Updated security, CI/CD, runbook, and README docs.

### What I Learned

- Secret scanning and vulnerability scanning solve different security problems.
- Filesystem scanning catches dependency and repository issues.
- Image scanning catches operating system package and container-layer issues.
- High and critical findings should block deployment decisions until reviewed.

### Evidence

- Vulnerability workflow is in `.github/workflows/vulnerability-scan.yml`.
- Local vulnerability helper is in `scripts/verify-vulnerabilities.ps1`.
- Security process is documented in `docs/security.md`.
- CI/CD process is documented in `docs/ci-cd.md`.

### Verification

- `.\scripts\verify-ci.ps1` passed locally with 13 tests.
- `.\scripts\verify-vulnerabilities.ps1` correctly reported that Trivy is not installed locally.
- The GitHub Actions workflow will run Trivy in CI after push.
- Push to GitHub and confirm Vulnerability Scan workflow runs on `main`.

### Next Step

Start Day 12 by planning Jenkins pipeline stages and how Jenkins fits alongside GitHub Actions.

## Day 12 - Plan Jenkins Pipeline

Date: 2026-06-08

### What I Built

- Added a Jenkins pipeline design document.
- Added a Jenkins credential handling plan.
- Added Jenkins agent requirements and preflight checks.
- Updated Jenkins README with its role in the project.
- Updated CI/CD and security docs to explain how Jenkins complements GitHub Actions.

### What I Learned

- Jenkins should not be added just because it is popular; it needs a clear role.
- GitHub Actions is useful for repository-native quality gates.
- Jenkins is useful for self-hosted automation, deployment jobs, credential management, and manual approvals.
- Credential IDs can be documented, but real credential values must stay outside Git.

### Evidence

- Pipeline design is in `jenkins/pipeline-design.md`.
- Credential plan is in `jenkins/credentials-plan.md`.
- Agent requirements are in `jenkins/agent-requirements.md`.
- Jenkins role is documented in `docs/ci-cd.md` and `docs/security.md`.

### Verification

- Run `.\scripts\verify-ci.ps1` for Python tests.
- Review Jenkins docs for clear stage, credential, and agent requirements.
- No Jenkins runtime is required yet because Day 12 is planning-focused.

### Next Step

Start Day 13 by adding the first Jenkinsfile with test, Docker build, and security scan stages.

## Day 13 - Add Initial Jenkinsfile

Date: 2026-07-22

### What I Built

- Added the first repo-root `Jenkinsfile`.
- Added Jenkins stages for checkout, preflight checks, Python tests, Docker build, secret scan, and vulnerability scan.
- Added `scripts/verify-jenkinsfile.ps1` for local Jenkinsfile structure checks.
- Updated Jenkins docs, CI/CD notes, and runbook.

### What I Learned

- A Jenkinsfile should begin with safe non-deployment stages before touching servers.
- Preflight checks make agent problems obvious early.
- Jenkins pipeline code should call existing project verification scripts instead of duplicating logic.
- Deployment should wait until credentials, target infrastructure, rollback, and approvals are designed.

### Evidence

- Jenkins pipeline is in `Jenkinsfile`.
- Jenkinsfile verification helper is in `scripts/verify-jenkinsfile.ps1`.
- Jenkins documentation is in `jenkins/README.md` and `jenkins/pipeline-design.md`.
- CI/CD documentation is updated in `docs/ci-cd.md`.

### Verification

- Run `.\scripts\verify-ci.ps1` for Python tests.
- Run `.\scripts\verify-jenkinsfile.ps1` for Jenkinsfile structure checks.
- Run the actual Jenkins pipeline later on a configured Jenkins agent.

### Next Step

Start Day 14 by reviewing Week 2 CI/CD and security gates, then polish the pipeline documentation before cloud planning begins.

## Day 10 - Add Secret Hygiene Checks

Date: 2026-06-01

### What I Built

- Added Gitleaks secret scanning through GitHub Actions.
- Added `.gitleaks.toml` with placeholder allowlisting.
- Added `scripts/verify-secrets.ps1` for local secret hygiene checks.
- Added `docs/secret-management.md` as the project secret policy.
- Added a Secret Scan badge to the README.

### What I Learned

- Secret scanning is a preventive DevSecOps control.
- Example credentials must be clearly fake and allowlisted intentionally.
- If a real secret leaks, rotation matters more than simply deleting the file.

### Verification

- Run `.\scripts\verify-secrets.ps1` locally.
- Push to GitHub and confirm the Secret Scan workflow runs on `main`.

### Next Step

Start Day 11 by adding dependency and container vulnerability scanning.

### Automation Update

- Added `scripts/finish-day.ps1` to make the daily two-commit workflow easier.
- Added `docs/daily-automation.md` to document the one-command daily finish process.
