# SDK Decision Framework

Which integration approach to use for OpenRouter, based on task requirements.

## Comparison table

| Approach | Best for | Dependencies | Type safety | Streaming | Tool calling |
|---|---|---|---|---|---|
| **Raw REST** (curl/requests) | Scripts, debugging, minimal deps | None | No | Manual SSE parsing | Manual |
| **OpenAI SDK** (python/openai) | Existing OpenAI codebases, quick migration | `openai` package | Partial | Yes | Yes |
| **OpenAI SDK** (TS openai) | TypeScript projects, Vercel AI SDK | `openai` npm | Yes | Yes | Yes |
| **@openrouter/sdk** (TS) | Agent workflows with tools, loops, state | `@openrouter/sdk` npm | Full | Yes | Native |
| **Vercel AI SDK** | Next.js/React apps, streaming UI | `ai` + `@ai-sdk/openrouter` | Yes | Yes | Yes |
| **LangChain** | Multi-step chains, RAG pipelines | `langchain-openrouter` | Partial | Yes | Via callbacks |

## Decision flow

```
Do you need an agent loop (tools + state + multi-turn)?
  YES → @openrouter/sdk
  NO → Are you in a TypeScript project?
    YES → Do you need React/Next.js streaming?
      YES → Vercel AI SDK + @ai-sdk/openrouter
      NO → openai (TS) with baseURL override
    NO → Are you in a Python project?
      YES → Do you already use the OpenAI SDK?
        YES → Reuse it, just change base_url
        NO → Raw requests (fewer deps) or openai SDK
      NO → Raw REST (curl/requests) for scripts
```

## OpenAI SDK compatibility

OpenRouter is OpenAI-compatible. Use any OpenAI SDK by changing the base URL:

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=os.environ["OPENROUTER_API_KEY"],
)
```

```typescript
import OpenAI from "openai";

const client = new OpenAI({
  baseURL: "https://openrouter.ai/api/v1",
  apiKey: process.env.OPENROUTER_API_KEY,
});
```

This is the easiest migration path for existing codebases.

## @openrouter/sdk (Agent SDK)

Purpose-built for agent workflows:

```typescript
import { OpenRouter } from "@openrouter/sdk";

const openRouter = new OpenRouter({ apiKey: process.env.OPENROUTER_API_KEY });

const completion = await openRouter.chat.send({
  model: "anthropic/claude-sonnet-4",
  messages: [{ role: "user", content: "Hello" }],
  tools: [...],
});
```

Use this when:
- Building autonomous agents with tool loops
- Need native multi-model fallback via `models` array
- Want type-safe tool definitions
- Managing agent state across turns

## Raw REST examples

### Python (requests)

```python
import requests, json, os

response = requests.post(
    "https://openrouter.ai/api/v1/chat/completions",
    headers={
        "Authorization": f"Bearer {os.environ['OPENROUTER_API_KEY']}",
        "Content-Type": "application/json",
    },
    data=json.dumps({
        "model": "google/gemini-3-flash-preview",
        "messages": [{"role": "user", "content": "Hello"}],
    }),
)
print(response.json()["choices"][0]["message"]["content"])
```

### Streaming (SSE)

```bash
curl -s https://openrouter.ai/api/v1/chat/completions \
  -H "Authorization: Bearer $OPENROUTER_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"google/gemini-3-flash-preview","messages":[{"role":"user","content":"Hello"}],"stream":true}' \
  | while IFS= read -r line; do
      [[ "$line" == data:* ]] && echo "${line#data: }" | jq -r '.choices[0].delta.content // empty'
    done
```

## Optional headers

| Header | Purpose |
|---|---|
| `HTTP-Referer` | App URL for OpenRouter rankings |
| `X-OpenRouter-Title` | App name for OpenRouter rankings |

These are optional and only affect leaderboard attribution.
