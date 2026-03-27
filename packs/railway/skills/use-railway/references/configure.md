
## Use this reference for

- environment variables
- configuration changes
- domains and networking
- service ports
- environment-specific settings
- bucket credentials or connection strings

## Core configuration principles

1. Make the target environment explicit.
2. Keep production changes small and deliberate.
3. Prefer variable changes over invasive rewrites.
4. Verify the effect of every config change.
5. Treat networking and domain changes as production-impacting.

## Typical configuration flow

1. Resolve the project, environment, and service.
2. Identify the exact key or setting to change.
3. Apply the configuration change.
4. Verify the service picked up the change.
5. Confirm external behavior if networking or domains changed.

## Example tasks

- Set DATABASE_URL for a service.
- Add S3 credentials for a bucket.
- Update a service port.
- Add a custom domain.
- Configure environment-specific variables.

## Verification checklist

- Correct key/value stored
- Correct environment selected
- Service restarted or reloaded if needed
- Domain or port behaves as expected
- No accidental overwrite of unrelated config
