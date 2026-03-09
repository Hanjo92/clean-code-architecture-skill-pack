# Legacy Refactor Playbook

Use this playbook when the code is fragile, tests are weak, and the safest next step is not obvious.

## When to read this

Read this reference when:

- the user wants cleanup in legacy code with weak or missing tests
- a bug fix and refactor are mixed in one task
- the current module is hard to split without first opening a seam
- direct cleanup would cross too many modules or hidden behaviors

## Core rule

Prefer the next move that increases confidence over the move that looks most elegant.

In legacy code, the first win is often not a cleaner design. It is a better boundary for observation, verification, or controlled change.

## Safe sequence for weak-safety-net code

1. Identify the externally visible behavior or contract that must not drift
2. Add the smallest possible characterization test, probe, log, or reproducible check
3. Open one seam that isolates side effects, branching logic, or dependency direction
4. Apply one small refactor that improves local changeability
5. Re-check behavior
6. Stop if confidence does not rise with each step

## Mixed bug-fix and refactor tasks

When the task includes both a bug and messy structure:

1. Name the incorrect behavior separately from the structural problem
2. Fix the bug with the smallest behavior-changing edit you can justify
3. Verify the bug fix
4. Decide whether the safety net is now strong enough for a follow-up refactor
5. If not, stop at the fix plus diagnosis

Do not hide a risky cleanup inside the bug fix just because the code is already open.

## Seam-first moves

Use seam creation before larger movement when:

- business rules and I/O are interleaved
- the same function both decides and performs side effects
- dependencies point the wrong direction
- hidden state makes behavior hard to predict

Good seam-first moves include:

- extract pure decision logic from side-effectful orchestration
- wrap external dependencies behind a narrow interface owned by the caller
- split read logic from mutation logic
- isolate format conversion or transport mapping from domain rules

## Characterization options when tests are missing

If conventional tests are not available yet, pin behavior down with the lightest safe mechanism:

- focused characterization tests around public behavior
- snapshot or golden-file checks where outputs are stable enough to trust
- temporary logging around critical branches
- narrow harnesses that exercise one entry point with known inputs

Remove temporary probes once a better safety net exists, unless they provide lasting operational value.

## Branch by abstraction guidance

Use branch by abstraction when:

- the old and new implementations must coexist for a while
- callers cannot migrate all at once
- replacing the dependency directly would cause broad churn

Do not use it for small local refactors. It is for controlled migration under real coupling.

## Diagnosis-only stop points

Stop at diagnosis or seam creation when:

- behavior is still too poorly understood to move safely
- the safety net is too weak for cross-module edits
- the user did not authorize the level of interface churn required
- the next refactor would be primarily aesthetic

In that case, return:

1. the structural risk
2. the next safest seam
3. the missing verification needed before further cleanup

## Review pass

Before continuing, confirm:

- I can name what behavior must remain stable
- I can distinguish bug-fix edits from refactoring edits
- I know which seam reduces the next unit of risk
- The next change is small enough that verification could catch drift

If any answer is no, reduce scope before continuing.
