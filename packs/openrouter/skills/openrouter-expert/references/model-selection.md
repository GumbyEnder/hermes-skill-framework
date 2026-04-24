# Model Selection Heuristics

Detailed guidance for choosing OpenRouter models based on task type.

## Canonical sources (always verify)

- Model list: `curl -s https://openrouter.ai/api/v1/models`
- Model details: `https://openrouter.ai/models?q=<model-id>`
- Pricing: Included in `/api/v1/models` response under `pricing` object
- Capabilities: Check `supported_parameters` and `context_length`

## Selection by task type

### General chat / simple completion

Cost-optimized, high availability:
- `google/gemini-3-flash-preview` — fast, cheap, good quality
- `meta-llama/llama-4-scout` — open weights, good availability
- `openai/gpt-5.2-mini` — balanced cost/quality

### Complex reasoning

Extended thinking / chain-of-thought:
- `openai/o3:thinking` — strong reasoning with visible traces
- `anthropic/claude-sonnet-4:thinking` — reasoning with tool support
- `google/gemini-3-flash-preview:thinking` — budget reasoning option

### Tool-calling agents

Prioritize exacto variants or models with strong tool support:
- `openai/gpt-5.2:exacto` — optimized for tool calling reliability
- `anthropic/claude-sonnet-4` — native tool support
- `google/gemini-3-flash-preview` — good tool support at low cost

Filter models: `https://openrouter.ai/models?supported_parameters=tools`

### Code generation

- `openai/gpt-5.2` — strong code, wide language support
- `anthropic/claude-sonnet-4` — excellent code + reasoning
- `google/gemini-3-flash-preview` — fast and cheap for simpler tasks

### Vision / multimodal

- `google/gemini-3-flash-preview` — image + video input
- `anthropic/claude-sonnet-4` — image input
- `openai/gpt-5.2` — image input

### High-throughput / low-latency

- Any model with `:nitro` suffix
- `provider.sort: "throughput"` in routing config
- `provider.preferred_max_latency` to cap latency

### Budget / free tier

- `:free` suffix models — zero cost, rate limited
- `provider.max_price` to cap costs
- Free models router: `models` set to `openrouter/free`

### Privacy / compliance

- `provider.data_collection: "deny"` — restrict to non-logging providers
- `provider.zdr: true` — Zero Data Retention only
- Sovereign AI for EU data residency (enterprise)

## Context window considerations

| Need | Approach |
|---|---|
| Short prompts (<4K tokens) | Any model works |
| Medium (4K-32K) | Most models support this |
| Long (32K-128K) | Check `context_length` in models API |
| Very long (128K+) | Gemini models, Claude extended, or `:extended` suffix |

Always set `max_tokens` only when needed — it narrows the provider pool.

## Pricing structure

OpenRouter pricing comes from the `/api/v1/models` response:

```json
{
  "pricing": {
    "prompt": "0.000003",
    "completion": "0.000015",
    "request": "0",
    "image": "0"
  }
}
```

Values are per-token in USD. Check live — prices change.

## Cost optimization strategies

1. **Use `:free` for development/testing** — zero cost, limited throughput
2. **Flash/mini models for bulk work** — 10-50x cheaper than flagship
3. **Response caching** — set `provider.cache` for identical requests
4. **Prompt caching** — supported for OpenAI, Anthropic, DeepSeek models
5. **Fallback chains with price ordering** — try cheap first, escalate only if needed
6. **`max_price` caps** — prevent runaway costs on variable pricing

## When to use local models instead

Consider local inference (Ollama, LM Studio, vLLM) when:
- High volume, low complexity tasks
- Data must never leave the machine
- Latency is critical (no network round-trip)
- Running the same model repeatedly (amortize hardware cost)

Use OpenRouter when:
- Need model diversity / specialization
- Don't have GPU hardware
- Need models not available locally
- Want managed reliability and fallbacks
