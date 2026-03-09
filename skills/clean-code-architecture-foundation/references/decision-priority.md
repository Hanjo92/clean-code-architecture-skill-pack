# Decision Priority

Use these rules when multiple clean-code or clean-architecture concerns compete.

## Priority order

1. Preserve correctness and observable behavior unless intentional change is requested
2. Clarify the requested behavior before designing broad structure
3. Open the minimum seam needed for safe change
4. Implement the smallest useful slice
5. Generalize only after the slice proves the boundary is real

## Conflict rules

- If the code is messy but the requirement is still unclear, clarify the requirement first.
- If the requirement is clear but the current structure blocks safe delivery, do a preparatory refactor first.
- If the code is ugly but cheap to change, avoid broad cleanup.
- If the architecture looks elegant but the slice is still hard to implement, simplify it.
- If the current behavior or hidden constraints can only be learned from the legacy code, do a discovery pass before broad design decisions.

## Refactor vs redesign

- Choose refactoring when the main value comes from improving the current implementation while preserving behavior.
- Choose redesign when the current structure cannot support the required behavior without changing core assumptions.
- Choose two phases when the feature is valid but the current shape needs a seam before the behavior can land safely.
