
## Use this reference when

- you need a practical testing checklist for a frontend flow
- you want to reduce flaky Playwright tests
- you need to explain why a UI pattern is a bad test target

## Testing principles

### 1. Prefer stable selectors
- use `data-testid` or equivalent durable attributes
- do not select by CSS class names if those classes are generated or unstable
- make the selector tell you what user action it represents

### 2. Use real controls
- buttons should be buttons
- links should be links
- inputs should be inputs
- selects should be selects

### 3. Wait for state, not time
- wait for visible text, disabled state changes, network completion, or navigation
- do not use arbitrary sleep calls unless there is no better signal

### 4. Make asynchronous flows obvious
- show loading text
- disable repeat actions
- provide readable success or error messages

### 5. Keep navigation explicit
- pagination is easier to test than infinite scroll
- URL state makes reruns and debugging easier
- avoid nested popups and unnecessary context switching

### 6. Assert what a user sees
- check visible text
- check route changes
- check control state
- check accessible names where relevant

## Common flaky patterns

- relying on hover to reveal the action
- using nth-child selectors for important controls
- clicking a control before it is actually ready
- asserting internal state only, with no visible user outcome
- testing a UI that has no stable selector hooks

## Example good patterns

- `page.getByRole('button', { name: 'Save' })`
- `page.getByTestId('checkout-submit')`
- `await expect(page.getByText('Saved')).toBeVisible()`
- `await expect(page).toHaveURL(/\?page=2/)
`

## Human rule

If the UI is hard to test manually, it will usually be harder to test automatically.
