# Monitoring Plan

Monitoring is planned as the next operational layer after the 15-day portfolio completion.

## Current Signals

- `/health`: verifies the Flask process is alive.
- `/db/health`: verifies Flask can reach MySQL and run a metadata query.
- `docker compose ps`: shows container state and health.
- `docker compose logs app`: shows application logs.
- `docker compose logs db`: shows database logs.

## Planned Metrics

| Metric | Why It Matters |
| --- | --- |
| App container health | Detects application process failure |
| Database container health | Detects database availability failure |
| Request count | Shows traffic and basic usage |
| Request latency | Detects performance degradation |
| HTTP 5xx count | Detects application or dependency failures |
| MySQL volume usage | Prevents storage exhaustion |

## Future Stack

- Prometheus for metrics collection.
- Grafana for dashboards.
- Node exporter or container exporter for host/container metrics.
- Alerting rules for app down, database down, and high error rate.

## Alert Candidates

- App `/health` fails for more than 2 minutes.
- `/db/health` fails for more than 2 minutes.
- MySQL container restarts repeatedly.
- Disk usage crosses 80 percent.
- Error rate increases after deployment.

