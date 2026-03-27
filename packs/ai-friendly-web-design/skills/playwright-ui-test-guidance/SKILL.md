name: playwright-ui-test-guidance
description: >
  Design and review frontend UI tests for Playwright-style automation. Use this
  skill when the user wants better selectors, more stable test flows, reliable
  waits, component interaction guidance, or advice on making a UI easier to test
  end-to-end.
metadata:
  version: 1.0.0
  origin: adapted from ianho7/ai-friendly-web-design-skill
  license: CC BY 4.0
---

# Playwright UI Test Guidance

## What this skill does

This skill helps Hermes suggest test-friendly UI patterns and write better Playwright-oriented guidance for frontend code.

It is model-agnostic and should work the same across Hermes backends.

## Use this when

- the user wants UI test strategy
- Playwright selectors are flaky
- a flow needs better test hooks
- you want to know how to make a page easier to automate end-to-end
- the user is reviewing a component for testability, not just accessibility

## Test design focus

### Stable selectors
- prefer explicit test IDs or durable data attributes
- avoid brittle CSS selectors or generated class names
- use readable selector names tied to user intent

### Reliable actions
- use real buttons, links, inputs, and selects
- prefer explicit waits for loading or state transitions
- do not depend on hover-only controls for critical actions

### Predictable flow
- keep pagination explicit
- keep URL state in sync where helpful
- avoid modal chains that trap the test in unnecessary context switches

### Assertions that matter
- assert visible user outcomes, not just implementation details
- check text, state, and navigation changes that reflect actual behavior

## Output format

Return:
1. what makes the UI hard to test
2. selector and flow risks
3. recommended changes to the component
4. recommended changes to the test approach
5. a short testability summary

## Reference material

See `references/test-playbook.md` for the deeper test guidance.
