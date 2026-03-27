
This pack turns the AI-friendly web design checklist into something Hermes can use directly.

The core idea is simple: build web UI that is easy for humans to use and easy for agents to navigate.
If a page is easier to read, easier to test, and easier to automate, it usually ends up being better for everyone.

## Why this pack exists

A lot of frontend bugs are really structure problems:
- buttons that are not real buttons
- forms that only work through keyboard tricks
- important actions hidden behind hover states
- unstable selectors that break automation
- pages that force agents through modals, popups, or unnecessary visual noise

This pack gives Hermes a practical way to review those issues without locking the workflow to any one model.

## Source material

This pack was adapted from:
- https://github.com/ianho7/ai-friendly-web-design-skill

The upstream package is published under CC BY 4.0, so attribution matters. Keep the credit trail intact anywhere this pack is reused or redistributed.

## Pack layout

- `skills/ai-friendly-web-design/SKILL.md` — routing skill and review checklist
- `skills/ai-friendly-web-design/references/guidelines.md` — full principle list and examples

## What this pack is good for

- frontend code review
- accessibility reviews
- agent-friendly UI checks
- Playwright / automation robustness checks
- semantic HTML and ARIA cleanup
- modal / popup / hover-state risk review
- stable locator guidance for testable interfaces

## What this pack is not

- a replacement for a full accessibility audit
- a design system
- a visual polish checklist
- a vendor-specific Claude-only skill

## Human rule of thumb

If the UI is annoying for a person and brittle for an agent, fix the structure first.
