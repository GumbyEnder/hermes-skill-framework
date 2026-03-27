## Why this exists

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

## Included packs

- `packs/railway/` — model-agnostic adaptation of the Railway workflow
- `packs/seo-geo/` — SEO, GEO, and search-visibility routing pack
- `packs/ai-friendly-web-design/` — agent-friendly UI and accessibility pack

## What does not belong in core

Avoid hard-coding any of the following into the core runtime:
- a single model provider
- ASO-specific assumptions
- API keys or vendor secrets
- vendor-specific prompt formats
- business logic that only applies to one use case

