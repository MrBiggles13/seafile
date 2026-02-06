# SAML 2.0 Single Sign-On (SSO) – Seafile Zero-Trust Appliance

This document explains how to enable **SAML 2.0 Single Sign-On (SSO)** for the Seafile Zero-Trust Appliance.

The appliance image already includes all required dependencies (including `xmlsec1`).  
No custom Docker image steps are required.

The instructions below apply to **Microsoft Entra ID (Azure AD)**, **Okta**, and **on‑premise ADFS**.  
Other SAML 2.0 identity providers work in a very similar way.

---

## Overview

Seafile acts as the **Service Provider (SP)**.  
Your identity provider (Entra ID / Okta / ADFS) acts as the **Identity Provider (IdP)**.

Authentication flow:

```
User → Seafile → Identity Provider → Seafile → User logged in
```

---

## 1. Prepare certificate directory (persistent)

On the Docker host, create the certificate directory:

```bash
mkdir -p /opt/seafile-data/seahub-data/certs
```

---

## 2. Generate Service Provider (SP) certificates

```bash
cd /opt/seafile-data/seahub-data/certs
openssl req -x509 -nodes -days 3650 -newkey rsa:2048   -keyout sp.key   -out sp.crt
```

---

## 3. Obtain Identity Provider (IdP) certificate

Download the Base‑64 encoded X.509 certificate from your IdP and save it as:

```
/opt/seafile-data/seahub-data/certs/idp.crt
```

---

## 4. Configure Seafile (`seahub_settings.py`)

File path:

```
/opt/seafile-data/seafile/conf/seahub_settings.py
```

Add:

```python
ENABLE_ADFS_LOGIN = True
LOGIN_REDIRECT_URL = '/saml2/complete/'

SAML_REMOTE_METADATA_URL = 'https://<IDP_METADATA_URL>'

SAML_ATTRIBUTE_MAPPING = {
    'name': ('display_name',),
    'mail': ('contact_email',),
}

SAML_CERTS_DIR = '/shared/seahub-data/certs'
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')

CSRF_TRUSTED_ORIGINS = [
    'https://files.yourdomain.tld',
]
```

---

## 5. Configure public service URL

```
/opt/seafile-data/seafile/conf/ccnet.conf
```

```ini
SERVICE_URL = https://files.yourdomain.tld
```

---

## 6. Required SAML endpoints

| Purpose | URL |
|------|-----|
| Metadata | https://files.yourdomain.tld/saml2/metadata/ |
| ACS | https://files.yourdomain.tld/saml2/acs/ |
| Login | https://files.yourdomain.tld/ |

---

## 7. Restart Seafile

```bash
docker compose restart seafile
```

---

## 8. Test login

Click **Single Sign-On** on the Seafile login page.

---

## Notes

- HTTPS is mandatory
- Cloudflare Tunnel recommended
- SP certificates should be rotated
- Group sync optional

---

## Supported IdPs

- Entra ID
- Okta
- ADFS
- Any SAML 2.0 IdP

