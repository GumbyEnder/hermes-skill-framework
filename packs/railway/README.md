
This is the first model-agnostic skill pack added to Hermes Skill Framework.

Source inspiration:
- https://github.com/railwayapp/railway-skills

License status:
- Upstream Railway Skills is MIT licensed.
- Any copied or substantially reused portions must retain the original copyright and license notice.

## Evaluation

The upstream `use-railway` skill is already close to model-agnostic because it is built around:
- Railway CLI commands
- explicit context resolution
- structured routing by intent
- optional GraphQL/API fallback

What makes it less portable in its original form is not the Railway workflow itself, but the packaging and ecosystem-specific framing.

## What was improved for Hermes

This pack is rewritten to:
- remove Claude/plugin marketplace dependency from the skill content
- keep the skill focused on intent routing and execution strategy
- make the instructions usable by any Hermes provider backend
- preserve Railway as the target domain while abstracting away model assumptions

## Included skill

- `skills/use-railway/SKILL.md`

## Notes

This pack should be treated as a clean Hermes-native adaptation of the Railway workflow, not a one-to-one copy of the upstream project structure.
