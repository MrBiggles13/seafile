![Docker](https://img.shields.io/badge/Docker-required-blue)
![Zero Trust](https://img.shields.io/badge/architecture-zero--trust-success)
![Monitoring](https://img.shields.io/badge/monitoring-Prometheus%20%7C%20Grafana-orange)
![Security](https://img.shields.io/badge/security-hardened-critical)
![License](https://img.shields.io/badge/license-internal-lightgrey)

# Seafile Zero-Trust Appliance

A **self-hosted, hardened file collaboration appliance** built around **Seafile Pro**, designed for **customer-owned, zero-trust deployments**.

This project provides a complete, opinionated stack that can be deployed on-prem or in private infrastructure without exposing inbound ports.

---

## ✨ What’s included

- **Seafile Pro** – enterprise file sync & collaboration  
- **Elasticsearch** – full-text search  
- **ClamAV** – antivirus scanning  
- **Nginx** – internal reverse proxy  
- **Cloudflare Tunnel** – zero-trust publishing (no public ports)  
- **Prometheus** – metrics collection  
- **Grafana** – dashboards & visualization  
- **Alertmanager** – alerting & notifications  
- **SSO** – Entra ID (Azure AD), Okta, and other SAML providers  

---

## 🎯 Goals

This appliance is built with the following principles in mind:

- **Zero inbound ports**
- **Zero-trust networking**
- **Customer-owned infrastructure & data**
- **Predictable upgrades**
- **Full observability & alerting**
- **Security-first defaults**

---

## 🏗 Architecture

Internet → Cloudflare → Tunnel → Nginx → Seafile Stack

---

## ⚡ Quick Start

### Requirements

- Ubuntu Server 24.04 LTS
- Docker Engine
- Docker Compose (v2)
- 4–8 GB RAM

### Installation

```bash
git clone https://github.com/MrBiggles13/seafile.git
cd seafile
./scripts/install.sh
```

Verify deployment:

```bash
./scripts/healthcheck.sh
```

---

## 🌍 Publishing (Zero-Trust)

Publishing is done exclusively via Cloudflare Tunnel.

```bash
cloudflared tunnel login
cloudflared tunnel create seafile
```

No public ports are exposed.

---

## 🔐 Single Sign-On (SSO)

Supports any SAML 2.0 compatible IdP:

- Entra ID (Azure AD)
- Okta
- Other SAML providers

Metadata endpoint:

```
https://<your-domain>/saml/metadata/
```

---

## 📊 Monitoring & Alerting

Includes Prometheus, Grafana, and Alertmanager with preconfigured dashboards and alerts.

---

## 🔄 Updates & Maintenance

```bash
./scripts/backup.sh
./scripts/upgrade.sh
```

---

## 💾 Backups

```bash
./scripts/backup.sh
```

---

## 📁 Repository Structure

```
compose/
scripts/
image/
```

---

## 🧭 Philosophy

> Deploy once. Sleep well.

Single-tenant, customer-owned by design.

---

![Version](https://img.shields.io/github/v/release/MrBiggles13/seafile)
![Issues](https://img.shields.io/github/issues/MrBiggles13/seafile)
