
## New: OpenRouter Expert Pack

Resolver skill for OpenRouter model selection, provider routing, SDK patterns, and Hermes integration. Covers model variant suffixes, fallback chains, tool-calling gotchas, and cost optimization. Ships with cache-aware shell scripts for live doc/model queries.

See [`packs/openrouter/`](packs/openrouter/) or install locally via Hermes skill_manage.

**Quick start:** Grab [`openrouter-expert-prompt.md`](openrouter-expert-prompt.md) — paste it into any Hermes agent chat to generate the full skill automatically. Tailored for Hermes agent use with OpenRouter or Nous Research as the provider.

---

## New: Medusa Admin Pack

Manage a Medusa.js v2 headless commerce store directly through Hermes — view products, check orders, fulfill shipments, update inventory, manage customers and collections. All from Discord, CLI, or cron.

**Endpoints covered:** Products (CRUD), Orders (list/get/fulfill/cancel/archive), Customers, Collections, Inventory (per-variant stock), Store info, Regions. 16 endpoints documented with full request/response schemas.

**Dual auth:** Pre-generated admin API token (`MEDUSA_ADMIN_TOKEN`) or email/password JWT exchange. Read-only by default — destructive operations require `confirm=true`.

See [`packs/medusa/`](packs/medusa/) for the full pack README, prerequisites, and quick start.

**Quick start:** Grab [`medusa-admin-prompt.md`](medusa-admin-prompt.md) — paste it into any Hermes agent chat to regenerate the full skill from scratch.

---

Most skill libraries are tied too tightly to one vendor, one model, or one agent shell.

This project is meant to separate:
- the skill itself
- the execution runtime
- the provider/model adapter
- the tool integrations
- the validation layer

So a skill can run the same way whether Hermes is backed by Claude, OpenAI, LM Studio, Ollama, or something else.

## Attribution

This project is inspired by the excellent structure and skill-based workflow in:
- https://github.com/Eronred/aso-skills

That repository is MIT licensed, and any reused substantial portions must preserve the original copyright notice and license notice.

This new project should keep attribution clear while improving the architecture for a broader Hermes-first, model-agnostic runtime.

See `ATTRIBUTION.md` for the proper credit and reuse boundaries.

## Design principles

- Model-agnostic first
- Skill manifests should be explicit and portable
- Providers are adapters, not the product
- Skills describe intent, inputs, outputs, and dependencies
- Validation should happen before execution
- The framework should be easy to extend with new skill packs
- Examples should ship separately from the core runtime

## Structure

```text
hermes-skill-framework/
├── README.md
├── LICENSE
├── ATTRIBUTION.md
├── docs/
│   ├── ARCHITECTURE.md
│   └── ROADMAP.md
├── core/
├── cli/
├── adapters/
├── manifests/
├── packs/
├── examples/
└── tests/
```

## What ships here

Core deliverables for the new project:
- a skill manifest specification
- a loader for skill packs
- a provider abstraction layer
- a validation pipeline
- example packs with reference files
- documentation for Hermes integration

## Pack index

| Pack | What it covers |
|---|---|
| `packs/railway/` | Railway infrastructure operations, deploys, config, logs, and database analysis |
| `packs/seo-geo/` | SEO, GEO, search visibility, and AI-search routing |
| `packs/ai-friendly-web-design/` | Agent-friendly UI, accessibility, and frontend review workflows |
| `packs/openrouter/` | OpenRouter model selection, provider routing, SDK patterns, and Hermes integration |
| `packs/medusa/` | Medusa.js v2 store admin — products, orders, inventory, customers, collections |

## What does not belong in core

Avoid hard-coding any of the following into the core runtime:
- a single model provider
- ASO-specific assumptions
- API keys or vendor secrets
- vendor-specific prompt formats
- business logic that only applies to one use case

