# OpenRouter Pack

Skills for building with OpenRouter's unified LLM API, integrated with Hermes Agent's provider routing and model selection.

## What it covers

- Choosing the right OpenRouter models and routing strategy
- Integrating OpenRouter with Hermes' `providers`, `fallback_providers`, and `credential_pool_strategies` config
- SDK selection (REST, OpenAI-compatible, @openrouter/sdk)
- Model variant suffixes (`:free`, `:nitro`, `:thinking`, etc.)
- Provider routing and fallback configuration
- Tool calling, structured outputs, and server tools gotchas
- Cost optimization and Nous subscription integration

## Skills

| Skill | Description |
|---|---|
| `openrouter-expert` | Resolver skill for OpenRouter model selection, routing, SDK patterns, and Hermes integration |

## Canonical docs

Always consult live docs — do not rely on cached data for model IDs, pricing, or capabilities.

- https://openrouter.ai/docs/llms.txt (summary index)
- https://openrouter.ai/docs/llms-full.txt (full content, when needed)
- https://openrouter.ai/api/v1/models (live model list)
