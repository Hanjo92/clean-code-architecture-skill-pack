# Foundation Guide

Use this guide when a clean-code or clean-architecture task needs shared judgment before choosing a workflow or finalizing a result.

## Shared principles

### Changeability over ceremony

- Prefer structure that makes the next change safer and easier.
- Reject abstractions that look architectural but do not reduce coupling or clarify intent.
- Treat clean code and clean architecture as tools for changeability, not aesthetic goals.

### Explicit intent

- Prefer names, boundaries, and contracts that expose business meaning.
- Make assumptions, failure modes, and side effects explicit.
- Avoid hidden rules buried in generic helpers, framework glue, or comments that compensate for unclear code.

### Stable core, volatile edges

- Keep business rules away from transport, persistence, UI, and framework concerns.
- Translate external formats at boundaries instead of leaking them inward.
- Protect the core from details that are likely to change faster than the policy.

### Small, verifiable steps

- Prefer incremental progress with fast verification.
- Separate behavior-preserving refactoring from behavior-changing feature work whenever possible.
- Use the smallest slice that proves the design and reduces risk.

### Task-driven judgment

- Do not refactor because a rule exists; refactor because the code is hard to change or understand.
- Do not add layers because clean architecture says so; add them when they protect a real boundary.
- Stop when the next abstraction is speculative instead of task-driven.

## Decision priority

Use these rules when multiple clean-code or clean-architecture concerns compete.

### Priority order

1. Preserve correctness and observable behavior unless intentional change is requested
2. Clarify the requested behavior before designing broad structure
3. Open the minimum seam needed for safe change
4. Implement the smallest useful slice
5. Generalize only after the slice proves the boundary is real

### Conflict rules

- If the code is messy but the requirement is still unclear, clarify the requirement first.
- If the requirement is clear but the current structure blocks safe delivery, do a preparatory refactor first.
- If the code is ugly but cheap to change, avoid broad cleanup.
- If the architecture looks elegant but the slice is still hard to implement, simplify it.
- If the current behavior or hidden constraints can only be learned from the legacy code, do a discovery pass before broad design decisions.

### Refactor vs redesign

- Choose refactoring when the main value comes from improving the current implementation while preserving behavior.
- Choose redesign when the current structure cannot support the required behavior without changing core assumptions.
- Choose two phases when the feature is valid but the current shape needs a seam before the behavior can land safely.

## Quality bar

Use this checklist to judge whether the result is meaningfully clean.

### Structural quality

- Is the code easier to understand locally?
- Are responsibilities clearer than before?
- Are important boundaries more visible and less coupled?

### Delivery quality

- Did the work produce a usable slice instead of only a diagram or cleanup promise?
- Is the verification proportional to the risk of the change?
- Are assumptions and open decisions stated explicitly?

### Judgment quality

- Did the solution avoid architecture theater and aesthetic refactoring?
- Did it stop at the smallest effective improvement?
- Is the explanation concrete enough that another engineer could continue from it?
