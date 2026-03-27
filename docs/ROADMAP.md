
## Phase 0: Launch hygiene
- Confirm upstream license and attribution
- Create project name, scope, and repo description
- Decide whether the first release is a library, CLI, or both
- Publish a clear README and attribution note

## Phase 1: Manifest specification
- Define the skill manifest format
- Document required and optional fields
- Define versioning and compatibility rules
- Add examples for one simple skill pack

## Phase 2: Loader and validator
- Implement manifest parsing
- Implement schema validation
- Add checks for required tools and dependencies
- Add failure messages that are actionable

## Phase 3: Provider abstraction
- Add provider adapter interface
- Implement at least one local adapter
- Implement at least one hosted adapter
- Add model-agnostic execution normalization

## Phase 4: Pack packaging
- Define how skills are grouped into packs
- Add pack metadata and dependency rules
- Add a registry or index of available packs
- Add a publish/install workflow

## Phase 5: CLI
- Add commands for listing skills
- Add commands for validating packs
- Add commands for running a skill
- Add commands for inspecting resolved provider/tool context

## Phase 6: Example packs
- Convert the ASO-inspired skill set into a generic example pack
- Add a research pack
- Add an analysis pack
- Add a documentation pack

## Phase 7: Public release
- Tag a first alpha release
- Publish installation instructions
- Add contribution guidelines
- Add attribution and license compliance notes

## Release checklist
- README complete
- license present
- attribution documented
- manifest spec stable enough for external use
- one end-to-end example works on at least two providers
