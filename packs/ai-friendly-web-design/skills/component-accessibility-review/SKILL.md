name: component-accessibility-review
description: >
  Review a frontend component for accessibility structure, semantic HTML, ARIA
  usage, labels, keyboard behavior, contrast risk, state announcements, and
  interaction clarity. Use this skill when the user wants a component-level
  accessibility pass or a focused review of a UI widget, form field, menu,
  dialog, or interactive block.
metadata:
  version: 1.0.0
  origin: adapted from ianho7/ai-friendly-web-design-skill
  license: CC BY 4.0
---

# Component Accessibility Review

## What this skill does

This skill looks at one component at a time and asks a simple question: is this thing understandable, operable, and testable without guessing?

It is model-agnostic and works across Hermes backends.

## Use this when

- you want a focused accessibility review for a single component
- you are checking a form field, menu, modal, dialog, card, or control group
- you want to know whether a component has good semantics and ARIA support
- you want a fix list that is specific to one UI piece instead of the whole page

## Review focus

### Semantics
- use the correct element for the action
- label the control clearly
- make headings and landmarks reflect the structure

### Keyboard and focus
- ensure keyboard access works naturally
- make focus visible
- keep tab order sensible
- make modal focus trapping predictable when a modal is actually needed

### Labels and state
- connect labels to controls
- expose validation and status changes as readable text
- announce important state changes when needed

### Sensory clarity
- do not rely on color alone
- avoid icon-only controls without accessible names
- keep the component understandable without visual context

## Output format

Return:
1. component scope
2. top accessibility risks
3. medium-risk issues
4. low-risk cleanup notes
5. recommended fix order

## Reference material

See `references/a11y-playbook.md` for the deeper review notes.
