# Seafile Appliance – Hardened + Monitoring Bundle (v1)

This bundle adds:
- Hardening defaults for Docker Compose services
- Prometheus + Grafana monitoring stack
- Exporters: node-exporter, cAdvisor, Blackbox exporter
- Basic alerting rules (Prometheus rule evaluation)
- Grafana provisioning (datasource + starter dashboards)
- Clamscan integrated within the Seafile image (docker build -t seafile-pro-mc-clamav:11.0 ./image)

## How to use
1) Copy this bundle next to your existing `compose/` folder (or merge).
2) Adjust `.env` values in `compose/.env` (see env.example).
3) Start:
   ```bash
   cd compose
   docker compose up -d
   ```
4) Access Grafana (internal only). If you want to access it through Cloudflare Tunnel, add a second hostname + ingress for `grafana.<domain>`.

## Notes
- This is designed for a "no inbound ports" zero-trust deployment. No ports are published by default. This deployment is using cloudflared.
- Alerts are evaluated in Prometheus. You can integrate Alertmanager later (recommended).

## Security posture (high level)
- Drop Linux capabilities, enable `no-new-privileges`
- Read-only root filesystem where feasible
- Separate internal `backend` network and `edge` network
- Healthchecks for key services
