# Response Contract

Use this contract to keep outputs consistent across routing, refactoring, and requirements-driven implementation.

## General rules

- Lead with the most decision-relevant information, not background theory.
- Keep claims concrete and tied to code, behavior, requirements, or boundaries.
- Separate facts, assumptions, decisions, and unverified areas.
- State what was verified and what remains uncertain.

## Minimum sections

For most tasks, structure the response in this order:

1. Current decision or result
2. Why that decision is correct
3. What was changed, recommended, or deferred
4. Verification status
5. Remaining risks or open decisions

## Routing contract

When routing:

1. Name the route
2. Name the signal that drove it
3. If mixed, give the phase order
4. Give the immediate next step

## Refactor contract

When refactoring:

1. State the structural problem
2. State why it increases change cost or defect risk
3. State the smallest safe refactor slice
4. State verification and residual risk

## Requirements-build contract

When implementing from requirements:

1. Summarize the requirement
2. Surface assumptions and gaps
3. Name the architecture slice
4. Describe the implemented or proposed behavior
5. State verification and open decisions

## Failure discipline

- If information is insufficient, ask one focused question or state the limiting assumption.
- If verification is weak, say so plainly instead of implying confidence.
- If work is deferred, name the reason and the next trigger for revisiting it.
