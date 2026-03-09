# Clean Code Guidelines

Use these guidelines when deciding whether a refactor actually improves the code or only rearranges it.

## Intent

- Prefer names that expose domain meaning over implementation detail.
- Let a reader predict the role of a function, class, or module from its name alone.
- Avoid comments that explain what obvious code already says. Prefer code that needs less explanation.

## Responsibility

- Give each unit one clear reason to change.
- Split code when validation, decision-making, mapping, persistence, and transport concerns are mixed.
- Keep orchestration thin and business decisions explicit.

## Size and shape

- Treat long functions and large classes as a signal to inspect responsibility, not as a formatting issue.
- Extract logic only when the new unit has a stable name and role.
- Avoid abstraction that exists only to reduce line count.

## Abstraction discipline

- Add abstraction only when it clarifies a stable concept or protects a real boundary.
- Prefer a concrete, well-named function over a generic helper with vague purpose.
- Remove indirection when the abstraction hides more than it explains.

## Side effects

- Keep pure decisions separate from I/O, mutation, and framework calls.
- Make state changes visible in function boundaries when possible.
- Treat hidden mutation and temporal coupling as primary refactor targets.

## Error handling

- Keep domain rule failures explicit and close to the rule that triggers them.
- Translate infrastructure or transport errors at the boundary rather than leaking them into core logic.
- Avoid catch-all error handling that hides which part of the flow actually failed.

## Boundaries

- Keep business rules away from controllers, UI handlers, ORM entities, and transport models.
- Translate external formats at edges instead of leaking them inward.
- Depend on stable domain concepts, not low-level details.

## Tests

- Use tests to freeze behavior before risky refactors.
- Prefer tests that describe behavior and rules, not private method choreography.
- If code is hard to test, inspect whether responsibilities are tangled.

## Comments and duplication

- Remove comments that only compensate for poor naming or tangled structure.
- Keep comments when they capture intent, tradeoffs, or non-obvious constraints.
- Remove duplication only when the shared concept is real and stable.

## Evidence threshold

- Prefer evidence over taste when deciding to refactor.
- Use repeated change pain, defect risk, coupling, or unreadable intent as justification.
- If the code is unusual but still cheap to change, document the concern and move on.
