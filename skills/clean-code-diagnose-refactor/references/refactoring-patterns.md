# Refactoring Patterns

Choose the lightest transformation that fixes the diagnosed problem.

## Clarify intent

- Extract a function when a code block has a single nameable purpose.
- Inline an abstraction when the indirection hides more than it explains.
- Replace boolean flags with explicit operations when branches represent different workflows.
- Remove flag arguments when the flag hides multiple intentions behind one call.

## Split responsibilities

- Separate pure decision logic from side-effecting execution.
- Move validation, mapping, and persistence glue out of domain services when they dilute core intent.
- Break large modules by axis of change, not by arbitrary size.
- Use split phase when one function mixes parsing, decision-making, and output generation.

## Improve boundaries

- Introduce a port when domain or use-case code depends on an external system.
- Add an adapter when framework or API details leak inward.
- Move business rules inward and keep transport or persistence DTOs at the edge.
- Move function or move field when the behavior lives conceptually closer to another module.

## Make legacy code safer

- Add characterization tests before moving logic with unclear behavior.
- Refactor in slices: extract seam, move logic, then simplify callers.
- Prefer parallel change over flag-day rewrites when multiple callers depend on unstable code.
- Use preparatory refactoring when the next feature will be hard to add on the current shape.

## Practical sequencing

Use this order when the right refactor is not obvious:

1. Freeze behavior with a focused test or observable expectation
2. Rename the worst abstractions so the code becomes discussable
3. Extract pure decisions away from side effects
4. Isolate framework, persistence, or transport details behind seams
5. Merge or split modules only after responsibilities are visible

If steps 1-3 already solve the maintenance problem, stop there.

## High-value catalog choices

Use these as defaults before inventing new abstractions:

1. Rename Variable / Rename Function when intent is unclear
2. Extract Function when one block has a stable role
3. Move Function when logic is closer to another module's data or responsibility
4. Split Phase when one routine mixes transformation stages
5. Separate Query from Modifier when reads and writes are tangled
6. Encapsulate Variable when shared mutable state spreads coupling

## Stop conditions

Stop refactoring when:

- The next change would alter public behavior without explicit approval.
- The abstraction is becoming more general than the current problem requires.
- Verification is no longer fast enough to distinguish safe cleanup from redesign.
