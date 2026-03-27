
## Use this reference when

- you need to explain why a frontend issue matters
- you want a consistent review process for Hermes
- you need a more detailed pass than the summary checklist

## Review sequence

### 1. Scope the surface area
Ask what is being reviewed:
- one component
- one page
- a full flow
- a specific interaction

Do not review the whole app unless the user asked for it.

### 2. Check semantics first
Real interactive UI should use real interactive elements.

Look for:
- buttons that are actually buttons
- navigation that is actually navigation
- inputs that are actually inputs
- labels tied to fields
- headings that reflect page structure

### 3. Check stable locators
Automation and agents need selectors that do not break every time CSS changes.

Look for:
- `data-testid`
- `data-ai-action`
- other stable IDs or attributes
- avoidance of generated class names as the only selector

### 4. Check form behavior
Forms should work in a way that supports both humans and automation.

Look for:
- native controls
- readable validation errors
- submit buttons with explicit disabled/loading states
- input and change handling that does not depend only on keyboard events

### 5. Check traversal friction
Agents and humans both suffer when navigation is hidden or unstable.

Look for:
- hover-only controls
- infinite scroll where pagination would be clearer
- modal-heavy flows
- popup windows for critical steps
- unnecessary tab switching

### 6. Check URL state and reproducibility
If a page has filters, paging, or search terms, the URL should usually reflect it.

Look for:
- query params for filters
- shareable deep links
- predictable back/forward behavior

### 7. Check error and loading states
Good UI tells the user what is happening.

Look for:
- explicit disabled states during async actions
- readable loading text
- plain-text errors linked to the right field
- no color-only failure signaling

## Practical severity rules

### High
- hides a critical action
- blocks form submission or automation
- breaks accessibility in a core flow
- forces a modal or popup where the user cannot continue safely

### Medium
- increases brittleness
- makes automation harder than it should be
- causes noisy extraction or ambiguous UI state

### Low
- polish issue
- semantic cleanup
- minor selector improvement
- small readability gain

## Reporting format

When Hermes reports findings, use this structure:

- Finding
- Why it matters
- Suggested fix
- Severity

## Good review habits

- prefer the smallest useful fix
- do not invent issues that are not in the code
- prioritize anything that breaks navigation or submission first
- keep the report actionable for a human engineer

## Human rule

If a change improves both accessibility and automation robustness, it is usually worth doing early.
