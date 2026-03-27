
## Use this reference when

- the user wants the full rationale behind the checklist
- you need examples to justify a review comment
- you want to explain why a pattern hurts automation and human accessibility

## Core principle

Treat AI agents like disciplined, non-visual users of the interface: if the UI is clear enough for assistive tech and stable enough for automation, it is usually better designed overall.

## 1. Use semantic tags and ARIA attributes
- real buttons should be buttons
- icon-only controls need labels
- headings and landmarks should describe structure

Why it matters:
- clearer navigation
- better accessibility
- fewer ambiguous element matches for agents

## 2. Hide decorative elements
- mark purely visual DOM noise as hidden from accessibility and extraction where appropriate
- avoid dumping unnecessary SVG or animation clutter into the main reading path

Why it matters:
- less noise
- fewer irrelevant tokens
- cleaner extraction

## 3. Use stable locators
- add durable `data-testid` or `data-ai-action` markers for important controls
- do not rely on generated class names

Why it matters:
- more robust automation
- fewer brittle selectors

## 4. Prefer native controls
- use native form elements when possible
- avoid pretending a div is a select or checkbox unless there is a good reason

Why it matters:
- standard APIs
- fewer automation edge cases

## 5. Do not hide actions behind hover
- important actions should be visible or explicitly expandable
- hover-only controls are easy to miss

Why it matters:
- better discoverability
- fewer broken automation flows

## 6. Prefer pagination over infinite scroll
- pagination gives a clear end state and navigation target
- infinite scroll is harder to reason about and test

Why it matters:
- predictable traversal
- better scripting and debugging

## 7. Make loading states explicit
- disable buttons while work is in progress
- show text like Saving... or Loading...

Why it matters:
- fewer double submits
- clearer agent waiting behavior

## 8. Use iframes and Shadow DOM sparingly
- keep important context in the top-level DOM when possible
- if you must isolate content, preserve enough top-level hints

Why it matters:
- many extraction tools are shallow
- agents need a readable path through the page

## 9. Sync state to the URL
- put search, filters, categories, and pagination in the URL when appropriate

Why it matters:
- reproducibility
- sharing
- resumable workflows

## 10. Show plain-text error messages
- do not rely on color alone
- attach readable error text to the relevant input

Why it matters:
- easier correction
- better accessibility

## 11. Support programmatic input
- listen to `input` and `change`
- do not depend only on keyboard events

Why it matters:
- automation tools often set values directly
- keyboard-only logic is fragile

## 12. Keep critical flows in-page
- login, checkout, and authorization should stay in the current context when possible
- avoid unnecessary tabs and popups

Why it matters:
- less context loss
- easier automation

## 13. Offer machine-readable entry points
- expose a manifest or API when a workflow is agent-heavy
- make the important actions discoverable without deep UI traversal

Why it matters:
- cleaner agent integration
- less UI scraping

## 14. Prefer softer anti-bot defenses
- rate limiting is usually better than heavy visual challenge systems
- use honeypots and behavior checks when appropriate

Why it matters:
- keeps legitimate automation alive
- avoids blocking useful agent traffic

## Review ordering

When reviewing frontend code, check in this order:
1. semantic structure
2. hidden or noisy DOM
3. stable locators
4. forms and native controls
5. hover-only actions
6. loading and error states
7. URL state
8. context boundaries
9. machine-readable entry points
10. anti-bot friction
