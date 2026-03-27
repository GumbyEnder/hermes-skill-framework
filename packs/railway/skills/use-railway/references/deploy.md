
## Use this reference for

- deploying code from the current directory
- redeploying an existing service
- adjusting build settings
- handling monorepo deploys
- troubleshooting failed builds before a retry

## Core deploy principles

1. Confirm the target service and environment.
2. Prefer the Railway CLI for deploys.
3. Use explicit IDs when possible.
4. Inspect build logs if the deploy fails.
5. Verify the new deployment after it lands.

## Typical deploy flow

1. Check the current Railway context.
2. Confirm the correct service root or repo path.
3. Trigger deployment.
4. Wait for build completion.
5. Read logs if needed.
6. Verify runtime health.

## Example tasks

- Deploy a web app from the current directory.
- Redeploy after fixing an environment variable.
- Change a Docker build setting and retry.
- Deploy a service from a subdirectory in a monorepo.

## Verification checklist

- Build completed successfully
- Deployment status is healthy
- Runtime logs look normal
- Domain or service URL responds correctly
- No unexpected service was redeployed
