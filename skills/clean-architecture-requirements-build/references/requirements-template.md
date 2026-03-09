# Requirements Template

Use this template when the user provides a rough feature idea instead of an actionable spec.

Common Korean shorthand often maps to missing requirement detail:

- "정리해줘" often means define scope and acceptance criteria.
- "설계해줘" often means identify use cases, boundaries, and contracts.
- "구현해줘" often still requires assumptions about failure cases and external dependencies.

## Behavior

- Who triggers the behavior?
- What must happen?
- What must never happen?
- What counts as success?

## Inputs and outputs

- What data enters the use case?
- What data must be returned, emitted, or persisted?
- Which inputs are mandatory, optional, or derived?

## Rules and constraints

- What domain rules or invariants must hold?
- What authorization, validation, timing, or consistency constraints exist?
- What external systems participate?

## Operational constraints

- What deployment or rollout constraints exist?
- Is data migration, backfill, or compatibility work required?
- What monitoring, audit, or support visibility is needed after release?
- Are latency, throughput, or rate-limit constraints relevant?

## Failure modes

- Which failures are expected and recoverable?
- Which failures should be surfaced to the caller?
- What should happen on partial failure?

## Acceptance criteria

- Write concrete examples in "given / when / then" form.
- Include at least one unhappy path.
- Separate product decisions from technical assumptions.

## Compact output

When the user wants speed, compress the template into:

1. Goal
2. Inputs and outputs
3. Rules
4. Failure cases
5. Acceptance criteria
