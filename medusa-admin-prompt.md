# Medusa Admin Skill — Generation Prompt

Use this prompt with any Hermes agent to generate the `medusa-admin` skill from scratch.
The agent will fetch live Medusa API documentation, verify endpoint paths, and write
the skill files using `skill_manage` and `write_file`.

---

## Prompt

```
Create a Hermes Agent skill called `medusa-admin` that wraps the Medusa.js v2
Admin REST API for managing a headless commerce store. The skill should be
published to the `GumbyEnder/hermes-skill-framework` repo under `packs/medusa/`.

### What it should do

The skill should let any Hermes agent perform these store operations:
- View, search, create, update, and delete products
- List, view, fulfill, cancel, and archive orders
- List and view customers
- List and view collections, add/remove products
- Check and update inventory levels per variant
- View store info, regions

### Skill structure

```
packs/medusa/
  README.md
  skills/medusa-admin/
    SKILL.md
    references/api-endpoints.md
    scripts/validate-connection.sh
```

Root: `medusa-admin-prompt.md`

### Auth

Support two auth methods:
1. Pre-generated admin API token via `MEDUSA_ADMIN_TOKEN` env var
2. Email/password JWT exchange via `MEDUSA_ADMIN_EMAIL` + `MEDUSA_ADMIN_PASSWORD`

Token takes priority if both are set. Include auto-refresh for expired JWTs.

### Safety rules

- Read-only by default. Destructive operations (delete, cancel, fulfill) require
  explicit `confirm=true` parameter.
- Never expose secret values in responses.
- Pagination aware: default 50 items, max 200.
- Idempotent operations for product creation (use handle as dedup key).

### Response formatting

Format all API responses as readable markdown tables and summaries.
Error responses should clearly state the HTTP status, endpoint, and message.

### Configuration

All via env vars: MEDUSA_ADMIN_URL, MEDUSA_ADMIN_TOKEN, MEDUSA_ADMIN_EMAIL,
MEDUSA_ADMIN_PASSWORD, MEDUSA_STORE_NAME. Sensible defaults for everything
except auth credentials.

### Validation script

Write `scripts/validate-connection.sh` that:
1. Checks backend health at /health
2. Validates auth (tries token first, then JWT exchange)
3. Verifies /admin/store returns store info
4. Shows quick stats (product count, order count)
5. Returns exit code 0 on success

### Reference file

Write `references/api-endpoints.md` with complete endpoint documentation:
- HTTP method, path, query params
- Request body schema with example
- Response body schema with example
- Brief description of each field's meaning
- Common HTTP status codes
- Pagination pattern

Cover these domains: auth, store, products (CRUD), orders (list/get/fulfill/
cancel/archive/notes), customers, collections, inventory, regions.

### Conventions

- Follow Hermes skill writing conventions: YAML frontmatter with name,
  description, version, author, metadata.hermes.tags
- Category: devops (for repo placement; ecommerce is the domain)
- Max 400 lines for SKILL.md, offload reference data
- Use `metadata.hermes.related_skills` for companion skills
- No invented API paths — verify against live Medusa docs at
  https://docs.medusajs.com/api/admin

### Testing

After writing the skill, test `validate-connection.sh` against a running
Medusa v2 backend (e.g., the BNS Medusa-Store at localhost:9000).

### Deliver to repo

Commit all files to the `GumbyEnder/hermes-skill-framework` repo:
- feat: add medusa skill pack
- Include the pack in the root README pack index
```

---

## Usage

```bash
cd hermes-skill-framework
hermes -s medusa-admin-prompt.md "Create the medusa-admin skill as specified"
```