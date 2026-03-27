
## Goal

Create a portable skill runtime that can execute the same skill definition across multiple model providers and local backends without changing the skill itself.

## Core layers

### 1. Skill manifest
A skill is described by a small manifest that declares:
- name
- description
- version
- input schema
- output schema
- tool requirements
- optional provider hints
- dependency list
- safety or validation requirements

The manifest should be easy to parse and safe to validate before execution.

### 2. Skill content
The skill content contains the actual instructions, examples, heuristics, and workflow steps.

This content should be:
- human-readable
- reusable
- portable across runtimes
- independent of a specific model family

### 3. Provider adapter
A provider adapter translates Hermes’ normalized execution request into the API or CLI call required by a backend.

Examples:
- Anthropic adapter
- OpenAI adapter
- LM Studio adapter
- Ollama adapter
- future provider adapters

The skill should never need to know which one is active.

### 4. Tool abstraction
Skills can request tools without binding themselves to a single implementation.

Examples:
- file search
- web search
- browser interaction
- Git operations
- shell commands
- repo analysis

The runtime decides which tools are available and how they are exposed.

### 5. Validation layer
Before running a skill, validate:
- manifest correctness
- required tools present
- provider compatibility
- declared inputs supplied
- output expectations defined

This prevents silent failures and makes skill packs easier to trust.

## Execution flow

1. Load skill pack
2. Parse manifest
3. Validate manifest and environment
4. Resolve provider adapter
5. Build normalized execution request
6. Run the skill
7. Validate result shape
8. Return output and metadata

## Suggested repository layout

```text
core/
  manifest/
  runtime/
  validation/
  registry/

adapters/
  anthropic/
  openai/
  lmstudio/
  ollama/

packs/
  aso/
  seo/
  research/

cli/
  commands/

docs/
  ARCHITECTURE.md
  ROADMAP.md
```

## Non-goals

This framework should not:
- assume one vendor is the default forever
- bake ASO-specific logic into the runtime
- require a cloud service to function
- force users into one agent shell
- hide important behavior behind opaque magic

## What makes it Hermes-friendly

- explicit manifests
- local-first operation
- support for multiple model backends
- clear separation between skill content and execution logic
- easy packaging into reusable skill packs

## Open questions

- Should manifests be YAML, JSON, or both?
- Should tools be declared as capabilities or as concrete commands?
- Should packs be versioned independently from the runtime?
- Should the CLI support interactive discovery and validation?
