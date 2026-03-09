# Delivery Checklist

Use this checklist before calling the design or implementation complete.

## Requirement quality

- Is the goal stated in one paragraph?
- Are acceptance criteria concrete and testable?
- Is at least one unhappy path defined?

## Boundary quality

- Is the use case named after business intent rather than transport or framework action?
- Are ports owned by the inner layer that needs them?
- Are external schemas translated at the edge?

## Implementation quality

- Does the smallest useful vertical slice actually run or verify?
- Are domain rules free from framework-specific types?
- Are assumptions explicit instead of hidden in branching logic?

## Operational quality

- Are auth, permission, or identity assumptions explicit?
- Is any migration, backfill, or compatibility risk identified?
- Is there a clear plan for observability, error reporting, or rollback if the slice fails?
- Are performance-sensitive paths or external rate limits called out when relevant?

## Reporting quality

- Did the response separate assumptions, implemented behavior, and open decisions?
- Did it state what was verified and what was not?
- Did it avoid claiming architectural completeness when only one slice was built?
