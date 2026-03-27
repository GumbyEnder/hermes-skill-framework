
## Use this reference for

- introspecting a Railway-hosted database
- checking schema or table structure
- investigating slow queries or health issues
- understanding a Postgres/MySQL/Redis/Mongo service at a high level

## Core analysis principles

1. Identify the database type first.
2. Read-only analysis comes before any mutation.
3. Prefer the CLI or official API when available.
4. Keep analysis scoped to the user’s question.
5. Do not propose destructive actions without clear confirmation.

## Typical analysis flow

1. Resolve the database service context.
2. Check service health and available metadata.
3. Inspect schema, tables, or metrics as needed.
4. Summarize the important findings.
5. Recommend the next safe step.

## Example tasks

- Inspect whether a Postgres database is healthy.
- Determine if a service is connected to the intended database.
- Review high-level performance indicators.
- Check whether schema changes match the app’s expectations.

## Verification checklist

- Database type identified
- Correct service context selected
- Read-only analysis completed
- Findings are grounded in observed data
- Next step is safe and specific
