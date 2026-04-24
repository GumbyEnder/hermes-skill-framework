---
name: openrouter-expert
description: >
  Use this skill when the user mentions OpenRouter, model selection, routing,
  API providers, building agents/tools with external LLMs, comparing providers,
  or configuring Hermes provider/fallback settings. Also trigger on any complex
  AI development task involving external model access.
version: 1.0.0
author: GumbyEnder
metadata:
  hermes:
    tags: [openrouter, llm, routing, providers, model-selection, api]
    related_skills: [hermes-agent]
---

# OpenRouter Expert

Resolver skill for OpenRouter model selection, routing, SDK patterns, and
Hermes integration. Always consult live docs before making claims or writing
code.

## When to use this skill

- User asks about OpenRouter models, pricing, or capabilities
- Configuring Hermes `providers`, `fallback_providers`, or `credential_pool_strategies`
- Building agents or tools that call external LLMs via OpenRouter
- Comparing providers or choosing between model variants
- Debugging OpenRouter API errors (auth, routing, tool calling)
- Setting up fallback chains or provider routing policies

## Pre-answer ritual

Before recommending models, writing config, or claiming capabilities:

1. **Refresh llms.txt** — `curl -s https://openrouter.ai/docs/llms.txt`
2. **Check live models** — `curl -s https://openrouter.ai/api/v1/models | jq '.data[].id'`
3. **Read Hermes config** — check current `providers`, `fallback_providers`, and `credential_pool_strategies` in the active profile's `config.yaml`

Never invent model IDs, pricing, or capabilities. If a doc fetch fails, report exactly what failed before proceeding.

## Hermes + OpenRouter integration

### Config structure

Hermes routes models through its own provider layer. OpenRouter appears as
a provider in `config.yaml`:

```yaml
model:
  default: openai/gpt-5.2
  provider: openrouter
  base_url: https://openrouter.ai/api/v1
providers: {}
fallback_providers: []
fallback_model:
  provider: openrouter
  model: anthropic/claude-sonnet-4
```

### Key config fields

| Field | Purpose |
|---|---|
| `model.default` | Primary model ID (use OpenRouter format: `provider/model`) |
| `model.provider` | `openrouter` to route through OpenRouter |
| `model.base_url` | `https://openrouter.ai/api/v1` (OpenRouter endpoint) |
| `fallback_model` | Automatic failover on 429/503/connection errors |
| `providers` | Explicit provider overrides (keyed by provider name) |
| `fallback_providers` | Ordered list of fallback provider names |
| `credential_pool_strategies` | Key rotation / load balancing across API keys |

### Auth

Set `OPENROUTER_API_KEY` in the profile's `.env` file. Hermes reads it
automatically. Never hardcode keys in config.yaml.

### Nous subscription integration

If the user has a Nous subscription, prefer the `nous` provider over
`openrouter` for models available through Nous. Nous handles Firecrawl,
FAL, Browser Use, and managed inference. Use OpenRouter only when:

- The specific model is not available via Nous
- The user explicitly requests OpenRouter routing
- Provider diversity / failover is needed beyond Nous' coverage

## Model variant suffixes

OpenRouter appends suffixes to model IDs to select variants:

| Suffix | Example | Purpose |
|---|---|---|
| `:free` | `google/gemini-3-flash-preview:free` | Zero-cost tier (rate limited) |
| `:nitro` | `anthropic/claude-sonnet-4:nitro` | High-speed inference |
| `:thinking` | `openai/o3:thinking` | Extended reasoning / chain-of-thought |
| `:extended` | `google/gemini-3-flash-preview:extended` | Extended context window |
| `:exacto` | `openai/gpt-5.2:exacto` | Stronger tool-calling quality |
| `:online` | `perplexity/sonar:online` | Real-time web search |

Verify suffix availability per model via the live models API — not all
suffixes are available for all models.

## Provider routing (request-level)

OpenRouter supports per-request routing via the `provider` object:

```json
{
  "model": "anthropic/claude-sonnet-4",
  "provider": {
    "order": ["anthropic", "azure"],
    "allow_fallbacks": true,
    "require_parameters": true,
    "data_collection": "deny",
    "sort": "throughput"
  }
}
```

Key fields:
- `order` — Provider slugs to try in sequence
- `allow_fallbacks` — Allow backup providers (default: true)
- `require_parameters` — Only route to providers supporting all request params
- `data_collection` — `"allow"` or `"deny"` (restrict to providers that don't store data)
- `sort` — `"price"`, `"throughput"`, or `"latency"`
- `only` / `ignore` — Whitelist/blacklist provider slugs
- `quantizations` — Filter by quantization level (e.g. `["int4", "int8"]`)
- `max_price` — Cap prompt/completion/request/image pricing

## Model fallbacks (multi-model)

OpenRouter supports falling back to different models (not just providers):

```json
{
  "models": ["anthropic/claude-sonnet-4.6", "google/gemini-3-flash-preview"],
  "messages": [...]
}
```

Tried in order. Falls back on: provider down, rate limited (429), content
refusal, or connection failure.

## Routing decision framework

| Scenario | Recommended approach |
|---|---|
| Simple chat, cost-sensitive | Default provider routing (price-based) |
| Tool-calling agents | `:exacto` suffix or `require_parameters: true` |
| High throughput needed | `sort: "throughput"` or `:nitro` suffix |
| Privacy-sensitive data | `data_collection: "deny"` or `zdr: true` |
| Cost-capped workloads | `max_price` object or `:free` suffix |
| Maximum reliability | `models` array with fallback chain |
| Extended reasoning tasks | `:thinking` suffix |
| Live information needed | `:online` suffix or server tools web search |

## Common gotchas

1. **Model IDs change.** Always verify against `/api/v1/models`. A model
   ID that worked yesterday may be renamed or deprecated.

2. **Suffixes are model-specific.** Not every model supports every suffix.
   Check `supported_parameters` in the models API response.

3. **Tool calling is not universal.** Filter models via
   `?supported_parameters=tools` on the models page. Sending `tools` to a
   non-supporting model silently fails or returns an error.

4. **Structured outputs require `response_format`.** Use
   `type: "json_schema"` with a valid JSON Schema. Not all models support
   this — check `supported_parameters`.

5. **`max_tokens` affects routing.** If set, only providers supporting that
   length are routed to. Can silently narrow the provider pool.

6. **Free tier has rate limits.** `:free` models are heavily rate-limited.
   Don't use them for production workloads.

7. **Hermes `provider` field vs OpenRouter `provider` object.** In Hermes
   config, `provider` means "which provider backend to use." In OpenRouter
   API requests, `provider` is a routing configuration object. Don't confuse
   them.

8. **API key in .env, not config.yaml.** Hermes reads `OPENROUTER_API_KEY`
   from the profile's `.env` file. Never put it in `config.yaml`.

## Verification checklist

Before shipping OpenRouter integration:

- [ ] Model IDs verified against `/api/v1/models`
- [ ] Auth key in `.env`, not in config or code
- [ ] Fallback model configured for reliability
- [ ] `provider` routing object tested (if used)
- [ ] Tool calling validated with target model
- [ ] Structured outputs validated (if used)
- [ ] Pricing checked against live docs
- [ ] Suffix variants confirmed available for chosen model
- [ ] Hermes config passes `hermes config validate` (if available)
- [ ] No hardcoded model IDs in code — use env vars or config

## Helper scripts

See `scripts/` for cache-aware shell utilities:

- `pull-docs-index.sh` — Fetch and cache `llms.txt`
- `list-models.sh` — Query live model list with filtering

Scripts use `curl` only and cache results in `/tmp/openrouter-cache/`
for 5 minutes to avoid rate limiting.

## References

For deeper detail, load these reference files via `skill_view`:

- `references/sdk-decision-framework.md` — Which SDK/approach to use
- `references/model-selection.md` — Detailed model selection heuristics
- `references/tool-calling-gotchas.md` — Tool calling and structured output pitfalls

## Self-improvement

When better OpenRouter patterns are discovered during usage:
1. Save key findings to Hermes memory for cross-session recall
2. Flag the skill for update if model IDs, routing, or SDK patterns have shifted
3. Re-verify against live docs before updating the skill

Trust live docs over anything in this skill file.
