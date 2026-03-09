# Fowler Refactoring Guidelines

Use this reference for behavior-preserving refactoring decisions inspired by Martin Fowler's refactoring catalog and essays.

## Core definition

- Refactoring changes the internal structure without changing observable behavior.
- Separate refactoring from feature work conceptually, even when both happen in the same task.
- Keep steps small enough that verification can tell you exactly where behavior diverged.

## Two hats

- Wear the `refactoring hat` when improving structure while preserving behavior.
- Wear the `feature hat` when changing behavior for a new requirement.
- Wear the `bug-fix hat` when correcting behavior that is currently wrong, even if the code is messy.
- Do not blur the two when reporting results. Say which changes preserve behavior and which intentionally change it.

## Smells are signals

- Treat smells as heuristics that point to likely design trouble.
- Favor smells that predict high future cost: long function, large class, divergent change, shotgun surgery, data clumps, and temporary-field-style statefulness.
- Do not refactor only because a smell name matches. Refactor when the smell blocks comprehension or safe change.

## Small-step mechanics

- Establish a safety net first with tests or an externally visible expectation.
- Prefer one catalog move at a time over multi-purpose rewrites.
- Re-run verification after small clusters of related changes.
- When a bug fix is required, land the smallest correct behavior change before resuming structural cleanup.

If a safety net is missing, fall back to smaller preparatory moves: isolate a seam, add observability, or stop at diagnosis.

## Economic justification

- Refactor to make future change cheaper, safer, or clearer.
- If you are unlikely to recoup the change cost soon, keep the note and move on.
- Prefer task-driven cleanup over taste-driven restructuring.

## Preparatory refactoring

- If a feature is hard to add because the code shape resists it, first open a seam with a preparatory refactor.
- The goal is not beauty. The goal is to make the next behavior change cheap and low-risk.
- Stop once the seam exists and the new behavior can land cleanly.

## Catalog-oriented choices

Reach for these before inventing new patterns:

1. Extract Function for a named slice of logic
2. Move Function when the behavior belongs with different data
3. Split Phase when different transformation stages are tangled
4. Separate Query from Modifier when observation and mutation are mixed
5. Remove Flag Argument when one call hides multiple workflows
6. Encapsulate Variable when mutable state leaks across modules

## Legacy discipline

- Prefer preparatory refactoring plus incremental feature delivery over broad rewrites.
- Use parallel change when callers and implementations need to coexist during migration.
- Use branch by abstraction for larger migrations when old and new implementations must coexist behind the same boundary.
- Keep public contracts stable unless the task explicitly includes contract changes.
- If tests are weak, prefer seam creation, characterization probes, and extraction of side effects before moving domain logic.

## Stop conditions

- Stop when the next change is speculative rather than task-driven.
- Stop when the code is easier to change and the current feature can land cleanly.
- Stop when more abstraction would hide intent instead of clarifying it.
- Stop when the next structural move would exceed the confidence provided by the available safety net.
