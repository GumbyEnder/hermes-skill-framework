---
name: medusa-admin
description: >
  Manage a Medusa.js v2 commerce store via the Admin REST API.
  Use when the user asks to view products, check orders, manage inventory,
  fulfill shipments, handle customers, or perform any store admin operations.
  Triggers on: Medusa, store management, products, orders, inventory,
  customers, collections, fulfill order, check stock, ecommerce admin.
version: 1.0.0
author: GumbyEnder
metadata:
  hermes:
    tags: [medusa, ecommerce, admin, store-management, orders, products]
    related_skills: [medusa-local-backend-recovery]
---

# Medusa Admin

Manage a Medusa.js v2 headless commerce store through Hermes. This skill wraps
the Medusa Admin REST API for common store operations — products, orders,
inventory, customers, and collections.

## Quick Start

```bash
# Set your admin credentials (one of these):
export MEDUSA_ADMIN_URL="http://localhost:9000"
export MEDUSA_ADMIN_TOKEN="your-admin-api-token"       # Preferred
# OR
export MEDUSA_ADMIN_EMAIL="you@store.com"               # JWT fallback
export MEDUSA_ADMIN_PASSWORD="your-password"
```

Then ask Hermes: "Show me today's orders" or "Check inventory for product X".

## Configuration

All via environment variables. No config file needed.

| Env Var | Required | Default | Description |
|---|---|---|---|
| `MEDUSA_ADMIN_URL` | No | `http://localhost:9000` | Backend base URL |
| `MEDUSA_ADMIN_TOKEN` | Yes* | — | Pre-generated admin API token |
| `MEDUSA_ADMIN_EMAIL` | Yes* | — | Admin user email (JWT fallback) |
| `MEDUSA_ADMIN_PASSWORD` | Yes* | — | Admin user password (JWT fallback) |
| `MEDUSA_STORE_NAME` | No | `"Medusa Store"` | Display name in responses |

\* At least one auth method required. Token takes priority if both are set.

### Token Discovery

The skill auto-discovers credentials in this order:
1. `MEDUSA_ADMIN_TOKEN` env var
2. `MEDUSA_ADMIN_EMAIL` + `MEDUSA_ADMIN_PASSWORD` → auto-exchanges for JWT
3. Project `.env` file (`apps/backend/.env`) if running in a Medusa repo

### Generating an Admin API Token

In the Medusa Admin UI: **Settings → API Keys → Create API Key**
Select "Admin" type. Copy the token and set `MEDUSA_ADMIN_TOKEN`.

## Common Workflows

### View Recent Orders

Ask: "Show me the last 10 orders" or "What orders are pending fulfillment?"

The agent will:
1. `GET /admin/orders?limit=10&fields=id,status,email,total,created_at`
2. Format results in a table with status, customer, total, date

### Check Product Stock

Ask: "Check inventory for the Clan Pendant" or "Which products are low on stock?"

The agent will:
1. Search products: `GET /admin/products?q=Clan+Pendant`
2. For each variant, check: `GET /admin/inventory-items?variant_id=...`
3. Report stock levels with warnings for low quantities

### Fulfill an Order

Ask: "Fulfill order ord_abc123"

The agent will:
1. Verify order exists and is pending: `GET /admin/orders/ord_abc123`
2. Show order summary and ask for confirmation
3. Fulfill: `POST /admin/orders/ord_abc123/fulfillment` *(requires confirm=true)*

### Create a Product

Ask: "Add a new product: 'Dark Clan T-Shirt' at $29.99"

The agent will:
1. Show the draft payload for review
2. Create: `POST /admin/products` with title, options, variants, prices
3. Report back with the new product ID and URL

### Check Store Health

Ask: "Is the store healthy?"

The agent will:
1. `GET /admin/store` — verify backend responds with store info
2. Report: store name, default currency, region, and link to admin

## API Reference

See `references/api-endpoints.md` for the complete endpoint catalog
with request/response examples for all 16 supported endpoints.

## Auth Details

### Method 1: Admin API Token (Preferred)

```
Authorization: Bearer {MEDUSA_ADMIN_TOKEN}
```

Generate in Medusa Admin UI → Settings → API Keys. Tokens don't expire.

### Method 2: Email/Password JWT

```
POST /admin/auth/token
Body: { "email": "...", "password": "..." }
→ Returns: { "token": "eyJ..." }

Then: Authorization: Bearer {token}
```

JWT tokens expire after 24 hours. The skill auto-refreshes when getting 401.

## Response Formatting

All responses use structured markdown for readability:

**Products:**
```
## Products (page 1, 20 total)
| ID | Title | Status | Variants | Min Price |
|---|---|---|---|---|
| prod_abc | Clan Pendant | published | 3 | $24.99 |
```

**Orders:**
```
## Order #ord_123
Status: pending | Customer: user@email.com | Total: $52.97
Items:
- 2× Clan Pendant @ $24.99 = $49.98
- Shipping: $2.99
```

**Errors:**
```
## Medusa Error
Status: 404 | Endpoint: GET /admin/products/nonexistent
Message: Product with id 'nonexistent' not found
```

## Safety Rules

- **Read-only by default.** Destructive operations (delete product, cancel order,
  fulfill order) require explicit `confirm=true` parameter.
- **Never expose secrets.** Token values are masked in all responses.
- **Pagination aware.** List endpoints return up to 50 items by default.
  Use `?limit=200` for larger batches.
- **Idempotent operations.** Product creation uses handle as dedup key.
  Fulfillment checks for existing fulfillments before creating.

## Pitfalls

- **Token not found:** If `MEDUSA_ADMIN_TOKEN` is unset and no email/password
  configured, the skill reports `MEDUSA_ADMIN_TOKEN` as missing and suggests
  generating one in the Admin UI.
- **Backend unreachable:** If `/health` fails, the skill points to
  `medusa-local-backend-recovery` for diagnosis.
- **Rate limiting:** Medusa doesn't enforce hard rate limits by default, but
  avoid bursts of >50 requests/second.
- **Pagination defaults:** List endpoints default to 50 items. If you need all
  records, use `?limit=200` and paginate via `?offset=N`.
- **Variant vs Product:** Inventory levels are per-variant, not per-product.
  Always query by variant ID when checking stock.
- **Auth method mismatch:** Admin API tokens do NOT work on storefront endpoints
  (`/store/*`). Those need a publishable API key.

## Verification

After configuring credentials, verify with:

```bash
bash ~/.hermes/profiles/<profile>/skills/packs/medusa/skills/medusa-admin/scripts/validate-connection.sh
```

Expected output:
```
✓ Backend reachable at http://localhost:9000
✓ Auth valid
✓ Store: By Night Studios (USD, US region)
```

## Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| 401 Unauthorized | Invalid/missing token | Check `MEDUSA_ADMIN_TOKEN` or regenerate in Admin UI |
| 404 on /admin/* | Wrong URL | Verify `MEDUSA_ADMIN_URL` includes no trailing slash |
| Connection refused | Backend down | Run `medusa-local-backend-recovery` skill |
| Empty product list | No products in store | Seed with demo data or import from BigCommerce/Printify |
| "not_allowed" on /store/* | Using admin token on storefront | Storefront needs publishable API key, not admin token |
