![Docker](https://img.shields.io/badge/Docker-required-blue)
![Zero Trust](https://img.shields.io/badge/architecture-zero--trust-success)
![Monitoring](https://img.shields.io/badge/monitoring-Prometheus%20%7C%20Grafana-orange)
![Security](https://img.shields.io/badge/security-hardened-critical)
![License](https://img.shields.io/badge/license-internal-lightgrey)

# Seafile Zero-Trust Appliance

Self-hosted, secure file collaboration appliance built around Seafile Pro.

Includes:
- Seafile Pro
- Elasticsearch (search)
- ClamAV (antivirus)
- Nginx (reverse proxy)
- Cloudflare Tunnel (zero-trust publishing)
- Prometheus + Grafana (monitoring)
- Alertmanager (alerting)
- SSO (Entra ID / Okta)

---

# 🚀 Goals
Production-ready, secure, customer-owned deployment with:
- Zero inbound ports
- Zero-trust networking
- Easy upgrades
- Full observability

---

# 🏗 Architecture
Internet → Cloudflare → Tunnel → Nginx → Seafile stack

---

# ⚡ Quick Start

## Requirements
- Ubuntu Server 24.04 (recommended)
- Docker + Compose
- 4–8 GB RAM

## Install
`curl -fsSL https://get.docker.com | sh`

`git clone https://github.com/MrBiggles13/seafile.git`

`cd compose`

`cp env.example .env`

`docker compose up -d`

`../scripts/healthcheck.sh`

---

# 🌍 Publishing
cloudflared tunnel login
cloudflared tunnel create seafile

No public ports required.

---

# 🔐 SSO
Supports Entra ID, Okta, any SAML provider.

Metadata:
https://<domain>/saml/metadata/

---

# 📊 Monitoring
Prometheus + Grafana + Alertmanager included.

---

# 🔄 Updates
./scripts/backup.sh
./scripts/upgrade.sh

---

# 💾 Backups
./scripts/backup.sh

---

# 📁 Structure
compose/
scripts/
docs/

---

# ❤️ Philosophy
Deploy once. Sleep well.



![Version](https://img.shields.io/github/v/release/<org>/<repo>)
![Issues](https://img.shields.io/github/issues/<org>/<repo>)
