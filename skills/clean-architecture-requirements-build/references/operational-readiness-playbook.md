# Operational Readiness Playbook

Use this playbook when a clean architecture slice also needs to be safe to release and support in production.

## When to read this

Read this reference when the feature touches:

- authentication, authorization, or tenant scoping
- schema changes, data migration, or backfill
- API compatibility or version transition
- asynchronous jobs, retries, or external integrations
- rollout controls, feature flags, or phased enablement
- monitoring, auditability, support visibility, or rollback planning

## Core rule

Treat production safety as part of the requirement, not as a late implementation detail.

A clean boundary is not enough if the slice cannot be rolled out, observed, or contained safely.

## Operational questions to answer early

Before committing to a design, answer:

1. Who is allowed to trigger this behavior?
2. What existing callers, data, or workflows must remain compatible?
3. Does any data need migration, backfill, or dual-read/dual-write handling?
4. How will we know the slice is healthy after release?
5. What is the containment or rollback move if the behavior is wrong?

If these answers materially affect the design, surface them before coding.

## Rollout-first slicing

Prefer slices that are releasable in controlled steps.

Good rollout-first patterns:

- add a read path before switching the write path
- ship a compatibility adapter before removing the old contract
- place feature flags at the edge, not inside domain policy
- add observability before broad enablement

Avoid slices that require all callers, all data, and all environments to change at once unless the user explicitly accepts that blast radius.

## Migration and compatibility discipline

When data or contracts are changing:

- separate steady-state design from transition mechanics
- state whether the system needs backward compatibility, forward compatibility, or both
- decide whether migration is synchronous, phased, or background
- identify the temporary adapters or compatibility shims needed during transition

Do not bury migration assumptions inside use-case logic.

## Auth and permission checks

Make these explicit:

- authentication source
- authorization rule owner
- tenant or account boundary
- audit or trace events for sensitive actions

Keep transport-specific auth plumbing in adapters, but keep business authorization rules visible in the application or domain layer.

## Observability minimums

For meaningful production slices, define:

- success and failure signals
- logs, metrics, or traces that reveal health
- identifiers needed for support or incident triage
- user-visible and operator-visible error paths

If the feature cannot be observed, do not call it operationally ready.

## External dependency handling

When calling databases, queues, APIs, or file systems:

- define timeout and retry posture explicitly
- identify idempotency expectations where retries are possible
- separate downstream failures from domain rejections
- specify degraded-mode behavior if the dependency is unavailable

These concerns belong in adapters or orchestration, not inside pure domain rules.

## Rollback and containment

Before release, know the first containment move:

- disable a flag
- route traffic away from the new path
- stop a background consumer
- revert a compatibility adapter
- pause migration or backfill

If rollback is expensive or impossible, state that constraint clearly before implementation is called complete.

## Review pass

Before finalizing the slice, confirm:

- The use case is clear
- The release path is clear
- The compatibility story is clear
- The observability story is clear
- The first containment move is clear

If any are unclear, the slice is architecturally incomplete for production use even if the code structure looks clean.
