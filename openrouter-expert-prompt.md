# OpenRouter Expert Skill — Agent Prompt

Feed this prompt to any Hermes-compatible agent to generate the `openrouter-expert` skill. Copy everything below the line and paste it as your message.

---

Create a production-quality Hermes skill named `openrouter-expert` that makes the agent excellent at building with OpenRouter while staying deeply integrated with Hermes Agent's architecture.

This must be an agent-optimized resolver skill: compact, durable, triggerable, and designed to always consult live docs before making claims or writing code. It is **not** a static notes file.

**Source material to read first (must fetch):**
1. https://openrouter.ai/docs/llms.txt
2. https://openrouter.ai/docs/llms-full.txt (only when needed)
3. Hermes Provider Routing docs (search internal skills or memory for "provider_routing")
4. Hermes Skills best practices

If any required source cannot be fetched, stop and report exactly what failed.

Use `skill_manage` to create/update the skill. If `openrouter-expert` already exists, inspect and update it.

**Skill Identity:**
- Name: openrouter-expert
- Category: software-development or devrel
- Format: agentskills.io-compatible SKILL.md with YAML frontmatter
- Audience: Hermes Agent itself (coding + autonomous workflows)
- Purpose: Help Hermes reliably choose the right OpenRouter models, routing strategy, SDK, and patterns while leveraging Hermes-native features like provider_routing, skills, and memory.
- Size target: Keep core SKILL.md under 400 lines / ~4,000 tokens. Offload tables, examples, and heavy data to references/ or scripts/.

**Skill Description (critical - optimize for Hermes triggering):**
"Use this skill when the user mentions OpenRouter, model selection, routing, API providers, building agents/tools with external LLMs, or comparing providers. Also trigger on any complex AI development task involving external model access."

**Core Principles (Hermes-flavored):**
1. OpenRouter docs (llms.txt) are canonical. Always check live.
2. Never invent model IDs, variants, pricing, or capabilities. Always verify via /api/v1/models or docs.
3. Prefer Hermes' built-in `provider_routing` config for fine-grained control (e.g. preferring Nous models when user has a subscription).
4. When recommending models, lightly consider local rig economics only if user explicitly asks about cost comparison.
5. Leverage Hermes SQLite memory for past OpenRouter sessions and self-improve the skill when better patterns are discovered.
6. Keep examples clean, use env vars, and favor clarity over marketing.

**Required Sections in SKILL.md:**
- A. When to use this skill
- B. Pre-answer ritual (always refresh llms.txt + models API + Hermes provider_routing)
- C. Hermes + OpenRouter Integration (provider_routing, Nous preference, fallbacks)
- D. SDK Decision Framework (opinionated table: raw REST, OpenAI compatible, @openrouter/sdk, etc.)
- E. Task-to-Docs Routing Table
- F. Model Selection & Routing Framework
- G. Tool Calling / Structured Outputs / Server Tools gotchas
- H. Common Gotchas
- I. Verification Checklist
- J. Helper Scripts (pull-docs-index.sh, list-models.sh, etc.)

**Helper Scripts Guidance:**
Place lightweight, cache-aware shell scripts (curl only) in the `scripts/` subfolder.

**Quality Bar:**
- Prescriptive on fragile things (model IDs, variants, auth, routing).
- Progressive disclosure: core skill lightweight, details in helpers/references.
- Include self-improvement note for future updates.
- Trust live docs over anything in this prompt.

After creation/update:
1. Read back the full SKILL.md
2. Verify frontmatter, description length, all URLs are valid, no invented data
3. Report the exact skill path and summary of changes
