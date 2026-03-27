
## Use this reference when

- you need a more detailed accessibility review than the summary checklist
- you want to explain why a component is risky
- you need a practical pass on one component at a time

## Component review order

### 1. Identify the component role
Ask what this thing is supposed to be:
- button
- link
- input
- menu
- dialog
- disclosure
- tab
- table
- custom composite

If the role is unclear, the component is already a problem.

### 2. Check semantic correctness
- prefer native elements
- use ARIA only when needed
- do not use divs as fake controls
- make headings and landmarks reflect purpose

### 3. Check names and descriptions
- ensure every interactive element has an accessible name
- make labels visible or programmatically linked
- keep helper text and errors attached to the right control

### 4. Check keyboard behavior
- tab order should match visual order
- actions should work without a pointer
- focus should move predictably
- dialogs should return focus where expected

### 5. Check state announcement
- loading, disabled, error, success, and selection states should be readable
- do not rely only on color or animation

### 6. Check contrast and visibility risk
- text should be readable
- focus states should be obvious
- interactive affordances should be visible

## Common component smells

- clickable divs
- icon-only buttons with no name
- inputs without labels
- state shown only by color
- controls hidden behind hover
- modals that do not manage focus
- custom widgets that reimplement native behavior poorly

## Human check

If a person would need to experiment to understand the component, accessibility is probably too weak.
