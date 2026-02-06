# Architecture Overview

## High-Level Flow

Internet
 → Cloudflare (Zero Trust Edge)
 → Cloudflare Tunnel
 → Nginx (Unprivileged Reverse Proxy)
 → Seafile Application Stack
 → Persistent Storage

## Trust Zones

- **Edge**: Cloudflare + Nginx
- **Backend**: Seafile, DB, Redis, Elasticsearch, ClamAV
- **Monitoring**: Prometheus, Grafana, Alertmanager
- **Egress**: Controlled outbound-only access

No inbound ports are exposed.

## Design Principles
- Explicit trust boundaries
- Network isolation via Docker networks
- No shared credentials
- Observable by default
