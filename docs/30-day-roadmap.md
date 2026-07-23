# 30-Day Project Roadmap

Goal: complete a portfolio-grade two-tier DevSecOps platform in 30 days while making at least three meaningful GitHub contributions per day.

## Daily Contribution Rule

Each day should produce three useful commits:

1. Technical commit: code, infrastructure, test, pipeline, security, monitoring, or deployment work.
2. Verification commit: test, script, config validation, troubleshooting, or quality gate work.
3. Evidence commit: daily log, architecture decision, runbook update, diagram, troubleshooting note, or README improvement.

This keeps the GitHub graph active and also proves the project was built with documentation and operational thinking.

## Week 1 - Local App And Containers

### Day 1 - Project Foundation

- Create repository structure.
- Add starter Flask app.
- Add README, runbook, security notes, and daily log.

### Day 2 - Local Test Workflow

- Add pytest coverage for app endpoints.
- Add local run and test scripts.
- Verify Python setup.

### Day 3 - Dockerize The Flask App

- Add `Dockerfile` for the Flask service.
- Add `.dockerignore`.
- Build and run the app container locally.
- Document image build and run commands.

### Day 4 - Add MySQL With Docker Compose

- Add MySQL service to Docker Compose.
- Add database environment variables.
- Verify app and database containers start together.

### Day 5 - App-To-Database Connectivity

- Add database connection logic.
- Add a simple table and endpoint that reads from MySQL.
- Add health checks for app and database readiness.

### Day 6 - Local Reliability Improvements

- Add restart policies.
- Add Compose health checks.
- Add troubleshooting notes for container failures.

### Day 7 - Week 1 Review

- Clean README.
- Add first architecture diagram.
- Verify local setup from scratch.

## Week 2 - CI/CD And Security Basics

### Day 8 - GitHub Actions CI

- Add workflow for tests.
- Run CI on push.
- Add status badge to README.

### Day 9 - Docker Build In CI

- Add CI job to build Docker image.
- Validate image build without pushing secrets.

### Day 10 - Secret Hygiene

- Add `.env.example` improvements.
- Document secret handling.
- Add basic secret scanning plan.

### Day 11 - Dependency Scanning

- Add Trivy or equivalent dependency/container scan.
- Document findings and remediation process.

### Day 12 - Jenkins Planning

- Add Jenkins pipeline design.
- Document why Jenkins is included and how it differs from GitHub Actions.
- Document Jenkins credential IDs and agent requirements.

### Day 13 - Jenkinsfile

- Add initial Jenkinsfile for test and build stages.
- Document required Jenkins plugins and credentials.

### Day 14 - Week 2 Review

- Review CI/security docs.
- Add diagrams for pipeline flow.
- Fix weak README sections.

## Week 3 - Cloud And Infrastructure

### Day 15 - AWS Deployment Plan

- Document target AWS architecture.
- Decide EC2-first deployment scope.
- Add cost and security assumptions.

### Day 16 - Terraform Foundation

- Add Terraform provider and variables.
- Add VPC/security group planning.

### Day 17 - EC2 Infrastructure

- Add Terraform for EC2 and security group.
- Restrict ports deliberately.

### Day 18 - Provisioning Script

- Add bootstrap script for Docker installation.
- Document server setup workflow.

### Day 19 - Cloud Deployment

- Deploy the app stack to EC2.
- Capture deployment evidence and screenshots.

### Day 20 - Safer Access

- Restrict SSH and admin ports.
- Document access model and risk.

### Day 21 - Week 3 Review

- Verify cloud deployment from a clean machine.
- Update cost notes and runbook.

## Week 4 - Observability, Resilience, And Portfolio Polish

### Day 22 - Logging

- Improve application logs.
- Document how to inspect container logs.

### Day 23 - Monitoring Plan

- Add Prometheus and Grafana design.
- Decide metrics to expose.

### Day 24 - Metrics And Dashboard

- Add basic metrics endpoint or container metrics.
- Add dashboard screenshot or exported config.

### Day 25 - Backup And Restore

- Add database backup command.
- Add restore procedure to runbook.

### Day 26 - Failure Testing

- Simulate app crash and database restart.
- Document observed behavior and fixes.

### Day 27 - Security Review

- Review open ports, secrets, IAM, and dependency scan results.
- Add final security notes.

### Day 28 - Architecture Decision Records

- Add ADRs for major decisions.
- Explain tradeoffs: EC2 vs RDS, Jenkins vs GitHub Actions, Compose vs Kubernetes.

### Day 29 - Final Portfolio Polish

- Clean README.
- Add screenshots, diagrams, and final project summary.
- Add recruiter-friendly skills map.

### Day 30 - Final Verification

- Run tests.
- Verify local and cloud deployment steps.
- Create final release tag.
- Write final project retrospective.

