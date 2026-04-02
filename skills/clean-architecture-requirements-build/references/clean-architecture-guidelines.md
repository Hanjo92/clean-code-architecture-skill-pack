# Clean Architecture Guidelines

Use these guidelines to keep feature design and implementation aligned with clean architecture rather than framework-first convenience.

## Dependency rule

- Let dependencies point inward toward business rules.
- Do not let domain policy depend on controllers, frameworks, databases, HTTP models, or UI concerns.
- Place interfaces where the inner layer needs them, not where the external tool prefers them.

## Domain and use cases

- Put invariants, core concepts, and domain decisions in the domain layer.
- Put application-specific workflow coordination in use cases.
- Keep use cases explicit about input, output, and failure paths.
- Let use cases express business intent in language that survives framework replacement.

## Ports and adapters

- Define ports around business needs, not around vendor SDK shapes.
- Keep adapters responsible for translation, not business policy.
- Convert transport and persistence models at the edge.
- If an external API shape dominates the design, stop and re-center the port on the use case.

## Framework isolation

- Treat frameworks as delivery mechanisms, not the center of the design.
- Avoid framework-specific types in domain and use-case code.
- Keep dependency injection, routing, persistence wiring, and serialization outside core policy.

## Vertical slicing

- Implement one business slice end to end before generalizing the platform.
- Prefer a small working path over a wide scaffold with unclear value.
- Add layers only when they protect a real boundary or reduce coupling.
- Keep the current slice in the smallest cohesive set of files and types that still exposes the boundary clearly; do not fan out one simple workflow into many thin abstractions by default.
- If the current codebase is too tangled for a safe slice, route through a preparatory refactor first instead of forcing clean architecture on top of chaos.

## Failure handling

- Model expected failures in use-case contracts.
- Keep retry, timeout, transport, and persistence concerns in adapters or application services.
- Do not hide missing product decisions inside generic error handling.
- Make degraded-mode, fallback, and compatibility behavior explicit at boundaries when production conditions require them.

## Delivery discipline

- Write down assumptions before encoding them deeply into the model.
- Keep acceptance criteria close to the use case.
- Re-check whether each new abstraction serves business clarity or only architectural aesthetics.
- Distinguish architecture needed for the requested slice from architecture that only looks complete on diagrams.
- Keep rollout controls, migration sequencing, and observability plans outside core policy unless they are genuine domain rules.
