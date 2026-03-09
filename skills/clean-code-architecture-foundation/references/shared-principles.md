# Shared Principles

Use these principles across routing, refactoring, and requirements-driven design.

## Changeability over ceremony

- Prefer structure that makes the next change safer and easier.
- Reject abstractions that look architectural but do not reduce coupling or clarify intent.
- Treat clean code and clean architecture as tools for changeability, not aesthetic goals.

## Explicit intent

- Prefer names, boundaries, and contracts that expose business meaning.
- Make assumptions, failure modes, and side effects explicit.
- Avoid hidden rules buried in generic helpers, framework glue, or comments that compensate for unclear code.

## Stable core, volatile edges

- Keep business rules away from transport, persistence, UI, and framework concerns.
- Translate external formats at boundaries instead of leaking them inward.
- Protect the core from details that are likely to change faster than the policy.

## Small, verifiable steps

- Prefer incremental progress with fast verification.
- Separate behavior-preserving refactoring from behavior-changing feature work whenever possible.
- Use the smallest slice that proves the design and reduces risk.

## Task-driven judgment

- Do not refactor because a rule exists; refactor because the code is hard to change or understand.
- Do not add layers because clean architecture says so; add them when they protect a real boundary.
- Stop when the next abstraction is speculative instead of task-driven.
