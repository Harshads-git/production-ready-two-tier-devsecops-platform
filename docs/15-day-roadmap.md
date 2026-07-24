# 15-Day Project Roadmap

Goal: complete a portfolio-grade two-tier DevSecOps platform in 15 project days with at least three meaningful GitHub contributions per active day.

## Daily Contribution Rule

Each active project day should produce three useful commits:

1. Technical commit: code, infrastructure, test, pipeline, security, monitoring, or deployment work.
2. Verification commit: test, script, config validation, troubleshooting, or quality gate work.
3. Evidence commit: daily log, architecture decision, runbook update, diagram, troubleshooting note, or README improvement.

## Day 1 - Project Foundation

- Create repository structure.
- Add starter Flask app.
- Add README, runbook, security notes, and daily log.

## Day 2 - Local Test Workflow

- Add pytest coverage for app endpoints.
- Add local run and test scripts.
- Verify Python setup.

## Day 3 - Dockerize The Flask App

- Add `Dockerfile` for the Flask service.
- Add `.dockerignore`.
- Add Docker Compose entry for the app.

## Day 4 - Add MySQL With Docker Compose

- Add MySQL service.
- Add database environment variables.
- Add database config tests.

## Day 5 - App-To-Database Connectivity

- Add database connection logic.
- Add `/db/health`.
- Add tests for database success and failure behavior.

## Day 6 - Table-Backed API

- Add database schema initialization.
- Add `POST /visits` and `GET /visits`.
- Add API and database tests.

## Day 7 - Week 1 Reliability Review

- Add stack verification script.
- Add diagnostics script.
- Add Week 1 review.

## Day 8 - Python CI

- Add GitHub Actions Python test workflow.
- Add local CI verification.
- Add CI status badge.

## Day 9 - Docker Build CI

- Add Docker image build workflow.
- Add local Docker build verification.
- Document image build gate.

## Day 10 - Secret Hygiene

- Add Gitleaks workflow.
- Add local secret verification.
- Add secret management policy.

## Day 11 - Vulnerability Scanning

- Add Trivy filesystem and image scan workflow.
- Add local vulnerability verification helper.
- Document vulnerability response process.

## Day 12 - Jenkins Planning

- Add Jenkins pipeline design.
- Add credential plan.
- Add agent requirements.

## Day 13 - Jenkinsfile

- Add initial Jenkinsfile.
- Add Jenkinsfile verification.
- Document Jenkins workflow.

## Day 14 - Week 2 Review

- Add Week 2 review.
- Add pipeline gate inventory.
- Add Week 2 verification script.

## Day 15 - Portfolio Completion

- Add AWS deployment architecture and Terraform starter.
- Add operations, monitoring, backup, and release documentation.
- Add final verification script.
- Update README and final project summary.

