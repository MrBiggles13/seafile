# Contributing

Thank you for your interest in improving the **Seafile Zero‑Trust Appliance** ❤️  

This project aims to provide a **secure, production‑grade, customer‑owned file collaboration appliance** built around Seafile Pro and modern zero‑trust principles.

We welcome thoughtful contributions that improve **security, reliability, maintainability, and clarity**.

---

## 📌 Ground Rules

Before contributing, please keep the following principles in mind:

- **Security first** – no changes that weaken isolation, authentication, or hardening
- **Customer ownership** – no SaaS dependencies, no vendor lock‑in
- **Least privilege** – containers, networks, and services should only have what they need
- **Production mindset** – changes should be upgrade‑safe and observable
- **Documentation matters** – every non‑trivial change must be documented

---

## 📦 What Can I Contribute?

### ✅ Good First Contributions
Perfect if you’re new to the project:

- Documentation improvements
- README fixes or clarifications
- Script cleanup or simplification
- Healthcheck improvements
- Monitoring dashboards (Grafana)
- Prometheus alert tuning
- Error handling improvements

### 🚀 Advanced Contributions
For experienced contributors:

- New exporters or metrics
- Additional Alertmanager rules
- Security hardening (AppArmor, seccomp, rootless patterns)
- Upgrade and rollback automation
- SSO / SAML improvements
- Backup & restore tooling
- Proxmox VE templates
- Infrastructure as Code (Ansible / Terraform / Helm)

---

## 🛠 Development Setup

### Recommended Environment
- Ubuntu Server 22.04 / 24.04
- Docker + Docker Compose (v2)
- 8 GB RAM minimum (16 GB recommended)
- Nested VM (VMware / Proxmox) preferred

### Start the Stack
```bash
cd compose
docker compose up -d
```

Verify everything is healthy:
```bash
./scripts/healthcheck.sh
```

---

## 🧪 Testing Guidelines

All contributions should be tested locally:

- Fresh install on a clean VM
- Upgrade from a previous version (if applicable)
- Healthcheck must pass
- No new open ports introduced
- No container running as privileged

If your change affects:
- **Networking** → test with Cloudflare Tunnel
- **Auth / SSO** → test with a real IdP
- **Storage** → verify persistence and backup compatibility

---

## 🔐 Security Contributions

Security improvements are **highly valued**.

If you discover:
- a vulnerability
- a misconfiguration
- a hardening opportunity

Please **do not open a public issue immediately**.  
Instead, contact the maintainer privately or clearly mark the issue as **security‑sensitive**.

---

## 🧾 Commit & PR Guidelines

- Use clear, descriptive commit messages  
  `feat: add blackbox probe for nginx`
- Keep PRs focused and small
- One logical change per PR
- Explain *why* the change is needed, not only *what* changed
- Update documentation if behavior changes

---

## 🧭 Project Direction

This repository focuses on:
- Single‑tenant, customer‑owned deployments
- Zero‑trust exposure (Cloudflare Tunnel)
- Observability by default
- Compliance readiness (GDPR, audits)

Multi‑tenant and managed hosting scenarios may be explored later but are **out of scope for now**.

---

## ❤️ Thank You

Every contribution — big or small — helps make this project better and safer.

If you’re unsure whether an idea fits, open a discussion or draft PR.  
We’re happy to guide you 🙂

