---
name: clean-code-diagnose-refactor
description: Diagnose and improve existing code through a clean-code and clean-architecture lens by identifying code smells, boundary violations, naming problems, oversized functions or classes, tangled dependencies, hidden side effects, and missing safety nets, then applying safe refactoring. Use when the request is about legacy code review, code quality diagnosis, structural cleanup, refactoring, dependency untangling, responsibility splitting, complexity reduction, readability improvement, testability improvement, maintainability improvement, or cleaning up existing behavior without intentionally adding new product features. Typical triggers include requests such as "why is this code so hard to change?", "separate responsibilities", "this function is too long", "the dependencies are tangled", and "keep the behavior the same and only improve the structure". Do not use as the primary skill when the main job is implementing a new feature from a requirement.
---

# Clean Code Diagnose Refactor

## Overview

Inspect existing code, explain the highest-value design and readability problems, and apply the smallest refactor that improves structure without changing intended behavior.

Prefer narrow, verifiable changes over rewrites. Treat unclear behavior as a discovery problem first, not a refactoring opportunity.

Use `clean-code-architecture-foundation` when you need shared principles for deciding whether a refactor meaningfully improves changeability.

Read `references/clean-code-guidelines.md` when you need first-principles guidance on naming, responsibility, side effects, boundaries, and comments.
Read `references/fowler-refactoring-guidelines.md` when you need Martin Fowler-style guidance on smells, small steps, behavior preservation, preparatory refactoring, and catalog-driven refactor choices.
Read `references/refactor-anti-patterns.md` when a cleanup plan seems larger than the diagnosed problem.
Read `references/legacy-refactor-playbook.md` when the code has weak tests, mixed bugfix-plus-refactor pressure, or needs seam-first progress through legacy constraints.
Read `../clean-code-architecture-foundation/references/response-contract.md` when you need the shared output format.

## Request Fit

Use this skill for requests like:

- "This service is too hard to change. Find the biggest design problem and refactor it."
- "Review this legacy module and tell me where responsibilities are mixed."
- "The function works, but it is too long and tightly coupled. Clean it up safely."
- "I do not want new features. I want the existing code to be easier to read, test, and extend."
- "Keep the behavior the same and only improve the structure."
- "Identify the worst maintainability issue first, then fix that slice."

Do not use this skill as the primary skill for requests like:

- "Here is a new requirement. Design and implement it cleanly."
- "Model this feature with use cases, ports, and adapters."
- "Turn this spec into new application code."
- "Design a new API from this feature description."

## Quick Routing

Prefer this skill when most of the user's value comes from improving an existing implementation.

- Existing code already works, but the structure is painful.
- The user mentions smells, maintainability, coupling, readability, or test difficulty.
- The user wants diagnosis first and code changes second.
- The user explicitly wants behavior preserved.

Switch to `clean-architecture-requirements-build` when:

- The main uncertainty is requirement interpretation, not legacy structure.
- The user is asking for a new capability, workflow, endpoint, or domain slice.
- The refactor would effectively become a redesign for new product behavior.

## Workflow

### 1. Anchor the task

- Determine whether the user wants diagnosis only, a targeted refactor, or a broader cleanup.
- Identify the behavior that must remain stable, the files in scope, and the acceptable amount of churn.
- If the request is mostly about implementing new behavior from a feature spec, switch to `clean-architecture-requirements-build`.
- If the task mixes a bug fix with structural cleanup, separate the behavior-changing slice from the behavior-preserving slice before planning edits.

### 2. Build context before judging structure

- Read the smallest set of files that reveals entry points, data flow, dependencies, and tests.
- Separate domain logic, orchestration logic, I/O, and framework code before proposing changes.
- Look for existing conventions and preserve them unless they are the source of the problem.

### 3. Diagnose concretely

- Name specific issues, not vague style complaints.
- Tie each issue to one of these failure modes: unclear intent, multiple responsibilities, unstable dependencies, hidden side effects, leaky abstractions, poor naming, or missing safety nets.
- Prioritize issues that block changeability or create defect risk.
- Prefer a ranked diagnosis over a long smell inventory. Start with the one structural issue that most reduces future change cost.

Read `references/diagnosis-checklist.md` when you need a systematic review pass.

### 4. Choose the smallest effective refactor

- Start with behavior-preserving transformations.
- Stage risky legacy work behind characterization tests when feasible.
- Keep public contracts stable unless the user explicitly accepts interface changes.
- Prefer extracting seams, isolating side effects, and clarifying responsibilities before introducing new abstractions.
- Use `references/clean-code-guidelines.md` to check whether the proposed abstraction actually improves readability and changeability.
- Use `references/fowler-refactoring-guidelines.md` to decide whether the next move should be a preparatory refactor, a catalog refactoring, or a stop.
- Use `references/refactor-anti-patterns.md` to reject broad, aesthetic, or speculative cleanup.
- Use `references/legacy-refactor-playbook.md` when the safest move is seam creation, characterization scaffolding, branch by abstraction, or a diagnosis-only stop.

Read `references/refactoring-patterns.md` when selecting a transformation strategy.

### 5. Implement with discipline

- Keep changes cohesive and local.
- Remove duplication only when the shared abstraction has a clear name and stable meaning.
- Move business rules away from controllers, UI handlers, infrastructure classes, and persistence glue.
- Do not add patterns ceremonially. Every new layer must reduce coupling or clarify ownership.
- Keep bug-fix edits and refactoring edits conceptually separate when reporting results, even if they land in one task.
- Stop if the cleanup is drifting into new feature design, broad renaming without structural gain, or speculative architecture.

### 6. Verify and report

- Run the narrowest meaningful verification available: focused tests, lint, build, or static checks.
- State what was verified and what remains unverified.
- Summarize the refactor in terms of improved boundaries, readability, and change safety.
- Distinguish clearly between behavior-preserving refactoring and intentional behavior change.

## No Safety Net Mode

If meaningful verification is unavailable or too weak:

- Prefer diagnosis, seam creation, logging, or characterization scaffolding over broad structural movement.
- Avoid touching public contracts, behavior-heavy conditionals, or cross-module rewrites unless the user explicitly accepts the risk.
- Treat uncertain legacy behavior as something to observe and pin down, not something to simplify by assumption.
- If a bug must be fixed, make the smallest behavior change first, then consider a follow-up refactor only if the risk profile improves.
- Report the work as risk reduction, not full refactoring completion.

## Output Shape

When the task includes explanation, structure the response in this order:

1. Current problem
2. Why it matters
3. Refactor applied or recommended
4. Verification status
5. Residual risks or next refactors

When the user asks for diagnosis only, still provide the next safest refactor slice instead of ending with abstract critique.
