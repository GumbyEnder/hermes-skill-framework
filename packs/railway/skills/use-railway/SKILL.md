name: use-railway
description: >
  Operate Railway infrastructure: create projects, provision services and
  databases, manage object storage buckets, deploy code, configure environments
  and variables, manage domains, troubleshoot failures, check status and metrics,
  and query Railway docs. Use this skill whenever the user mentions Railway,
  deployments, services, environments, buckets, object storage, build failures,
  or infrastructure operations.
metadata:
  version: 1.0.0
  origin: railwayapp/railway-skills
  license: MIT
---

# Use Railway

## Purpose

This skill helps you operate Railway infrastructure in a provider-agnostic way.
The skill itself is model-neutral: the same instructions should work whether Hermes is backed by Claude, OpenAI, or a local model.

Use this skill to:
- create or connect projects
- provision services, databases, and buckets
- deploy and redeploy code
- manage config, variables, domains, and networking
- inspect status, logs, and metrics
- troubleshoot failures and recover cleanly
- query docs or API data when the CLI is not enough

## Railway resource model

Railway organizes infrastructure in a hierarchy:

- Workspace: billing and team scope.
- Project: a collection of services under one workspace.
- Environment: isolated configuration and deployment history inside a project.
- Service: one deployable unit inside a project.
- Bucket: S3-compatible object storage inside a project.
- Deployment: a point-in-time release of a service in an environment.

## Operating rules

1. Prefer the Railway CLI when available.
2. Use explicit IDs when a Railway URL is provided.
3. Resolve the target project, environment, and service before mutating anything.
4. Use API calls only when the CLI does not expose the operation.
5. After a mutation, verify the result with a read-back command.

## Context resolution

If the user provides a Railway URL, extract IDs first.
If only names are provided, resolve them from the workspace context.
If context is still ambiguous, ask a clarifying question before making changes.

## Common operations

- Create project or service
- Add or update environment variables
- Deploy from the current directory
- Review build or runtime logs
- Add domains and check DNS
- Inspect database status and health
- Create or manage object storage buckets

## Routing guidance

Load the smallest additional reference needed for the task.

- Setup and creation tasks → setup reference
- Deploy and release tasks → deploy reference
- Environment, config, domains, networking → configure reference
- Status, logs, metrics, failures → operate reference
- Database analysis → analyze-db reference
- API/docs lookup → request reference

## Response format

When you finish, report:
1. What you did
2. The result
3. What happens next

Keep the response concise and operational.
