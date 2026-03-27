name: agent-friendly-ui-review
description: >
  Perform a deeper frontend code review focused on agent-friendly UI patterns,
  accessibility, semantic HTML, stable locators, form behavior, loading states,
  URL state, popup friction, and automation robustness. Use this skill when the
  user wants a review of existing UI code, a checklist-based critique, or a
  prioritized fix plan for frontend components and flows.
metadata:
  version: 1.0.0
  origin: adapted from ianho7/ai-friendly-web-design-skill
  license: CC BY 4.0
---

# Agent-Friendly UI Review

## What this skill does

This skill is the deeper review pass for frontend code.
It takes the broad AI-friendly web design checklist and turns it into a concrete review workflow Hermes can run on a real component, page, or frontend feature.

It is model-agnostic. The skill should work the same way whether Hermes is backed by Claude, OpenAI, or a local model.

## Use this when

- you are reviewing existing frontend code
- you want a prioritized list of accessibility and automation issues
- you need a component-by-component critique
- you want a fix order instead of a general checklist
- you want to know what will break Playwright, browser automation, or agent navigation

## Review flow

1. Identify the component or page scope.
2. Check semantic structure first.
3. Check interactive elements, labels, and locators.
4. Check forms, loading states, and error states.
5. Check navigation, popups, modals, and hover-only actions.
6. Check URL state and testability.
7. Summarize the fixes in priority order.

## Severity guidance

- High: blocks automation, hides a critical action, or breaks core accessibility.
- Medium: makes the UI brittle, noisy, or hard to operate.
- Low: polish issue, but worth fixing if the component is already open.

## What to look for

- real buttons instead of clickable divs
- stable `data-testid` or `data-ai-action` markers
- readable errors attached to inputs
- explicit loading and disabled states
- pagination instead of unbounded scroll where traversal matters
- no critical actions hidden behind hover
- minimal modal and popup friction
- sensible URL state for filters and pages

## Output format

Return:
1. scope
2. high severity findings
3. medium severity findings
4. low severity findings
5. recommended fix order
6. any follow-up verification notes

## Reference material

For the reasoning behind the checklist, see `references/code-review-playbook.md`.
