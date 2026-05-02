# Medusa Skill Pack

Hermes Agent skills for managing Medusa.js headless commerce stores.

## Skills

| Skill | What it does |
|---|---|
| `medusa-admin` | Manage products, orders, inventory, customers, and collections via the Medusa Admin REST API |

## Quick Start

```bash
# Install the skill into your Hermes profile
cp -r packs/medusa/skills/medusa-admin ~/.hermes/profiles/<profile>/skills/devops/medusa-admin/

# Set your admin credentials
export MEDUSA_ADMIN_URL="http://localhost:9000"
export MEDUSA_ADMIN_TOKEN="your-admin-api-token"

# Verify connectivity
bash ~/.hermes/profiles/<profile>/skills/devops/medusa-admin/scripts/validate-connection.sh
```

Then start Hermes and ask: "Show me today's orders" or "Check inventory".

## Prerequisites

- **Medusa.js v2** backend running (tested with v2.13+)
- **Admin API token** generated from Medusa Admin UI → Settings → API Keys
- Or admin **email + password** for JWT-based auth

## Auth Setup

Two options:

### Option 1: API Token (Preferred)

1. Go to your Medusa Admin panel (e.g., `http://localhost:9000/app`)
2. **Settings → API Keys → Create API Key**
3. Select **Admin** type
4. Copy the token
5. `export MEDUSA_ADMIN_TOKEN="pk_..."`

### Option 2: Email/Password

```bash
export MEDUSA_ADMIN_EMAIL="admin@store.com"
export MEDUSA_ADMIN_PASSWORD="your-password"
```

The skill auto-exchanges these for a JWT token on first use.

## Configuration

All via environment variables:

| Env Var | Default | Required |
|---|---|---|
| `MEDUSA_ADMIN_URL` | `http://localhost:9000` | No |
| `MEDUSA_ADMIN_TOKEN` | — | Yes* |
| `MEDUSA_ADMIN_EMAIL` | — | Yes* |
| `MEDUSA_ADMIN_PASSWORD` | — | Yes* |

\* One auth method required. Token takes priority.

## Companion Skills

- `medusa-local-backend-recovery` — Recover a downed Medusa backend
- `medusa-printify-connector-scaffold` — Build Printify integration

## License

MIT
