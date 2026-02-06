# Operations Guide

## Backups
Run:
```bash
./scripts/backup.sh
```

Ensure off-host storage for backups.

## Upgrades
1. Backup
2. Pull latest images
3. Run upgrade script
4. Validate via healthcheck

```bash
./scripts/upgrade.sh
./scripts/healthcheck.sh
```

## Monitoring
- Grafana dashboards for system & app health
- Alertmanager for critical events

## Incident Handling
- Alerts trigger via Alertmanager
- Inspect logs and metrics
- Restore from backup if needed

## Maintenance Window
Recommended quarterly maintenance:
- OS updates
- Docker image updates
- Credential rotation
