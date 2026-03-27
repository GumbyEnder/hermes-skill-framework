
## Use this reference for

- GraphQL API queries and mutations
- docs lookups
- community or reference material
- cases where the CLI does not expose the needed operation

## Core request principles

1. Prefer docs or CLI first.
2. Use API requests only when needed.
3. Keep the request minimal.
4. Validate the returned shape before relying on it.
5. Convert raw API data into a concise operational answer.

## Typical request flow

1. Determine what the user wants to know or change.
2. Choose the smallest API or docs query that answers it.
3. Run the query.
4. Extract the useful fields.
5. Summarize the result plainly.

## Example tasks

- Query project metadata.
- Fetch environment information.
- Look up docs for a config feature.
- Inspect available deployments or resources.

## Verification checklist

- Query matched the user’s actual question
- Response data is readable and complete enough
- No unnecessary mutation happened
- The answer is concise and actionable
