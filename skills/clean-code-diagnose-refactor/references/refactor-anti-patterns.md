# Refactor Anti-Patterns

Use this reference to reject cleanup work that looks sophisticated but does not improve changeability.

## Common traps

- Broad rewrite with no safety net
- Large renaming passes with little structural benefit
- New layers added only for aesthetics
- Mechanical file or class splitting that turns one local edit into multi-file navigation without clarifying ownership
- One-method interfaces or trivial scripts split into their own files even though they only exist to serve one local flow
- Generic utility extraction that weakens domain language
- Mixing feature changes into a behavior-preserving refactor without clear separation
- Replacing concrete duplication with an abstraction that has no stable name

## Review questions

- Does this change reduce future edit cost, or only move code around?
- Can the user verify that behavior stayed stable?
- Is the new abstraction easier to explain than the old duplication?
- Would a smaller catalog refactoring achieve the same result?

## Stop signs

- The explanation of the new structure is longer than the problem it solves.
- The refactor increases the number of concepts without reducing coupling.
- The team would need a diagram to understand code that previously required only local reading.
