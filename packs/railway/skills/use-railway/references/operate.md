
## Use this reference for

- checking service health
- reading logs
- understanding failures
- observing metrics and status
- recovering from a bad deploy
- confirming whether the runtime is behaving correctly

## Core operating principles

1. Start with the simplest status check.
2. Read recent logs before changing anything.
3. Identify whether the failure is build-time, deploy-time, or runtime.
4. Fix one likely cause at a time.
5. Verify recovery after each change.

## Typical operate flow

1. Check service status.
2. Pull recent logs.
3. Inspect health indicators and metrics.
4. Determine the failure domain.
5. Apply the smallest fix.
6. Recheck logs and status.

## Example tasks

- Diagnose a failed deployment.
- Check why a service is returning 500s.
- Verify a database is healthy.
- Confirm logs stopped showing the previous error.
- Determine whether a problem is config-related or code-related.

## Verification checklist

- Service is running
- Logs no longer show the original error
- Metrics are stable
- Health checks pass
- User-visible behavior matches expectations
