---
name: clean-code-architecture-router
description: Route ambiguous or mixed clean-code and clean-architecture requests to the right workflow. Use when the user mentions clean code, clean architecture, structural improvement, design quality, refactoring, requirement analysis, ports and adapters, maintainability, or architecture, but it is not yet clear whether the main job is diagnosing existing code, implementing new behavior from requirements, or splitting the task into both phases. Typical triggers include requests such as "is this a refactor or a redesign?", "we need a new feature but the current code is a mess", and "which workflow should we use first?"
---

# Clean Code Architecture Router

## Overview

Classify the user's dominant intent before doing deep work. Route the task to `clean-code-diagnose-refactor`, `clean-architecture-requirements-build`, or a two-phase plan when the request mixes both.

Do not solve the whole problem before routing. First decide whether the primary value comes from cleanup, new implementation, or both.

Use `clean-code-architecture-foundation` when you need the shared decision rules behind the route choice.

Read `references/routing-signals.md` when the intent is mixed, ambiguous, or spread across cleanup and new feature work.
Read `references/routing-examples.md` when the wording is close to real user prompts and you need a fast analogy-based route choice.
Read `../clean-code-architecture-foundation/references/response-contract.md` when you need the shared output format.

## Request Fit

Use this skill for requests like:

- "Decide whether this is a refactor problem or a redesign problem."
- "We need a new feature, but the current code is too tangled."
- "Choose the right workflow before doing the work."
- "Tell me whether to stabilize the code first or design the new slice first."

Do not use this skill as the primary skill for requests like:

- "Refactor this function." when the task is clearly cleanup of current code
- "Implement this spec." when the task is clearly requirements-to-code

## Routing Workflow

### 1. Identify the primary value

- Route to `clean-code-diagnose-refactor` when the user mainly wants diagnosis, cleanup, coupling reduction, readability improvement, or safer change on existing behavior.
- Route to `clean-architecture-requirements-build` when the user mainly wants requirement analysis, boundary design, use-case slicing, or new code from a spec.
- Route to a two-phase plan when both are necessary and neither can be safely ignored.

### 2. Apply hard routing rules

- If the user explicitly says "keep behavior the same", "only improve the structure", or "review or diagnose first", choose `Refactor route`.
- If the user explicitly says "requirement", "spec", "new feature", "use case", "ports and adapters", or "acceptance criteria", choose `Requirements route`.
- If the user says both "new feature" and "the current structure is too tangled to extend safely", choose `Two-phase route`.
- If a request would require behavior-preserving cleanup before feature work, do not force a single route. Split it.

### 3. Choose one of three outputs

- `Refactor route`: existing code quality is the primary concern, so proceed with a diagnosis-first workflow.
- `Requirements route`: clarifying and implementing new behavior is the primary concern, so proceed with an architecture-first workflow.
- `Two-phase route`: split the task into `stabilize current code` and `implement new behavior`, in that order unless product urgency dictates otherwise.
- `Clarification needed`: ask one narrow question when the request is too underspecified to choose safely.

### 4. State the routing reason explicitly

- Name the signals that drove the choice.
- Mention what work is intentionally deferred to the second phase or another skill.
- Keep the routing explanation short and operational.
- If the wording is close to a known example in `references/routing-examples.md`, reuse that route unless stronger contrary evidence appears in the request.

### 5. Use decisive language

- Say `Refactor route` when the dominant risk is unsafe change in current code.
- Say `Requirements route` when the dominant risk is building the wrong behavior.
- Say `Two-phase route` when adding the feature directly would cement a bad structure.
- Say `Clarification needed` only when one focused question would materially change the route.
- Avoid vague summaries such as "it depends" unless you truly lack enough signal to choose a next step.

## Output Shape

Return:

1. Chosen route
2. Why this route fits
3. If mixed, the phase order
4. Immediate next step

If the route is `Clarification needed`, return:

1. `Clarification needed`
2. Why the current signals are insufficient
3. One short question
