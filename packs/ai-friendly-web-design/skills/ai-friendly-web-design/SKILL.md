name: ai-friendly-web-design
description: >
  Review and improve web UI so it is easier for AI agents, automation tools, and
  humans to use. Use this skill when the user asks about accessibility, semantic
  HTML, ARIA, stable locators, Playwright compatibility, form behavior, hover-only
  actions, modals, popups, URL state, loading states, or agent-friendly frontend
  design.
metadata:
  version: 1.0.0
  origin: adapted from ianho7/ai-friendly-web-design-skill
  license: CC BY 4.0
---

# AI-Friendly Web Design

## What this skill does

This skill reviews frontend UI for the kinds of issues that make automation brittle and human use frustrating.

It is model-agnostic. Hermes can run it with Claude, OpenAI, or a local model.
The job of the skill is to point out structure problems and practical fixes.

## Use this when

- you are reviewing a UI component or page
- the user asks how to make a page easier to automate
- the user asks for accessibility or ARIA improvements
- a form or workflow keeps breaking under Playwright or browser automation
- hover-only controls, popups, or modal-heavy flows are causing trouble

## Core checklist

### Semantics and labels
- use real semantic elements for real interactions
- add `aria-label` to icon-only buttons
- hide decorative elements from assistive and agent extraction
- keep stable locators on important controls

### Forms and interactions
- prefer native controls over custom div-based lookalikes
- do not hide important actions behind hover
- listen to `input` and `change` events
- make validation errors readable as text

### State and navigation
- make loading states explicit
- prefer pagination over infinite scroll when traversal matters
- sync filter and search state to the URL
- keep critical flows in-page when possible

### Context boundaries
- use iframes and Shadow DOM sparingly
- keep essential context in the top-level DOM
- avoid forcing new tabs or popups for critical flows

### Advanced integration
- expose a machine-readable API or manifest when useful
- prefer rate limiting and honeypots over hard visual blockers

## Routing guidance

Load the reference when you need deeper rationale or examples.

See: `references/guidelines.md`

## Output format

When reviewing a page or component, return:
1. the highest-risk issue first
2. the exact UI pattern causing it
3. the practical fix
4. any accessibility or automation impact
5. a concise summary of what to change first
