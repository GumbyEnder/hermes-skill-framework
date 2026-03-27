
## Use this reference for

- creating a new Railway project
- adding a service to an existing project
- provisioning a database
- creating object storage buckets
- linking or resolving a project context
- onboarding a new app into Railway

## Core setup principles

1. Prefer the smallest change that achieves the requested setup.
2. Resolve the correct project, workspace, and environment before mutating anything.
3. If the user gave a Railway URL, use the IDs from the URL instead of guessing.
4. Confirm the result after creation.

## Typical setup flow

1. Identify whether this is a new project or an existing one.
2. Resolve the workspace/project context.
3. Add the required service, database, or bucket.
4. Set initial variables and links.
5. Verify the resource exists and is healthy.

## Example tasks

- Create a fresh project for a new app.
- Add a Postgres database to an existing service.
- Create a bucket and wire it to an upload service.
- Add a backend service to a monorepo project.

## Verification checklist

- Project exists
- Service exists
- Correct environment selected
- Required variables present
- Resource is reachable or provisioned
- No accidental duplicate project was created
