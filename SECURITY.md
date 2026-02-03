
---

# 🔐 SECURITY.md

```markdown
# Security Policy

Security is the core design goal of this appliance.

Principles:

- zero inbound exposure
- least privilege
- customer-owned infrastructure
- defense in depth
- observable systems

---

# 🛡 Supported versions

We support:

| Version | Supported |
|-----------|------------|
| latest release | ✅ |
| previous minor | ⚠️ security fixes only |
| older | ❌ |

---

# 🚨 Reporting a vulnerability

Please DO NOT open a public issue.

Instead:

📧 security@your-company.com

Include:
- description
- reproduction steps
- impact
- suggested fix (optional)

You will receive a response within 48h.

---

# 🔒 Security architecture summary

This appliance:

- exposes NO inbound ports
- uses Cloudflare Tunnel only
- runs services on internal Docker networks
- enforces container hardening
- supports SSO with MFA
- includes monitoring + alerting

---

# 🧩 Threat model

### In scope
- network exposure
- container breakout
- weak authentication
- data leakage
- service DoS

### Out of scope
- physical host compromise
- customer misconfiguration
- malicious IdP configuration

---

# 🔄 Security updates

Critical fixes:
- ASAP patch release

Regular fixes:
- quarterly appliance update

We strongly recommend:

```bash
./scripts/upgrade.sh
