# Tool Calling & Structured Outputs Gotchas

Common pitfalls when using OpenRouter's tool calling and structured output features.

## Tool calling

### How it works

1. You send `tools` array with function definitions
2. Model responds with `tool_calls` (name + arguments)
3. You execute the tool locally
4. You send `tool` role message with results back
5. Model formats the final answer

**The LLM never calls tools directly.** It suggests them; you execute them.

### Model support is not universal

Not all models support tool calling. Check before using:
- Filter: `https://openrouter.ai/models?supported_parameters=tools`
- Models API: look for `"tools"` in `supported_parameters` array
- Sending `tools` to a non-supporting model → error or silent failure

### Tool definition format

Uses OpenAI-compatible format:

```json
{
  "type": "function",
  "function": {
    "name": "get_weather",
    "description": "Get current weather for a location",
    "parameters": {
      "type": "object",
      "properties": {
        "location": {"type": "string", "description": "City name"}
      },
      "required": ["location"]
    }
  }
}
```

### Common issues

1. **Missing `description` on parameters.** Some models require descriptions
   on every parameter to generate correct tool calls. Always include them.

2. **`tool_choice` narrows routing.** Setting `tool_choice` (any, auto,
   required, or specific function) may restrict which providers are routed
   to — only providers supporting the requested `tool_choice` mode are used.

3. **Different models return different tool call formats.** OpenRouter
   normalizes to OpenAI format, but edge cases exist with some providers.
   Always handle `tool_calls` as an array, even when expecting one call.

4. **Parallel tool calls.** Some models return multiple tool calls in a
   single response. Your code must handle iterating over `tool_calls[]`.

5. **`tool_calls` with `null` content.** When a model makes tool calls,
   `message.content` is often `null`. Don't assume content is always present.

6. **Exacto suffix for reliability.** If tool calling reliability matters,
   use the `:exacto` suffix or `provider.require_parameters: true` to route
   to providers with better tool-calling track records.

## Server tools (model-invoked)

OpenRouter supports server-side tools that the model invokes automatically:

- **Web Search** — real-time search with citations
- **Datetime** — current date/time awareness
- **Image Generation** — AI image generation from prompts
- **Web Fetch** — URL content retrieval as text

These are different from client-side tools: the model decides when to call
them and OpenRouter executes them automatically. You don't handle execution.

Enable via `tools` with `type: "server"` or through the request configuration.

## Structured outputs

### How to use

Include `response_format` in your request:

```json
{
  "response_format": {
    "type": "json_schema",
    "json_schema": {
      "name": "result",
      "strict": true,
      "schema": {
        "type": "object",
        "properties": {
          "answer": {"type": "string"},
          "confidence": {"type": "number"}
        },
        "required": ["answer", "confidence"],
        "additionalProperties": false
      }
    }
  }
}
```

### Common issues

1. **`strict: true` is required.** Without it, the model may not strictly
   follow the schema. Always set `strict: true` when you need guarantees.

2. **`additionalProperties: false` is required with `strict: true`.** The
   schema must explicitly disable additional properties for strict mode.

3. **All fields must be in `required`.** Strict mode requires every property
   to be listed in the `required` array. Optional fields aren't allowed.

4. **Not all models support it.** Check `supported_parameters` for
   `response_format` with `json_schema` type.

5. **Response healing as fallback.** If structured outputs aren't available
   for your model, OpenRouter's "response healing" can auto-repair malformed
   JSON. Less reliable than native structured outputs.

## Response healing

OpenRouter can auto-repair malformed JSON responses. This is a fallback —
prefer native structured outputs when available. Enable via request
configuration.

## Prompt caching

Supported for models from OpenAI, Anthropic, and DeepSeek. Reduces cost
for repeated prompt prefixes. Check model-specific docs for cache control
parameters (`cache_control` in Anthropic, cached tokens in OpenAI).
