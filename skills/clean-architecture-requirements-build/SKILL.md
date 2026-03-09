---
name: clean-architecture-requirements-build
description: Turn feature requests and product requirements into clean-architecture-aligned design and implementation by clarifying acceptance criteria, modeling domain concepts and use cases, defining ports and adapters, and writing new code with business rules isolated from frameworks. Use when the request is about requirement analysis, feature breakdown, domain modeling, use-case design, port and adapter design, acceptance criteria, API or service design, application flow design, or implementing new behavior from a spec rather than cleaning up legacy code. Typical triggers include requests such as "analyze this requirement", "break this feature into use cases", "design ports and adapters", and "implement this spec cleanly". Do not use as the primary skill when the main job is diagnosing and refactoring an already-working legacy implementation.
---

# Clean Architecture Requirements Build

## Overview

Translate a requirement into explicit behavior, architecture boundaries, and production code. Reduce ambiguity before coding, then implement from stable use-case contracts outward.

Prefer explicit assumptions and small vertical slices over premature framework-heavy scaffolding.

Use `clean-code-architecture-foundation` when you need shared principles for choosing boundaries, sequencing work, or rejecting architecture theater.

Read `references/clean-architecture-guidelines.md` when you need first-principles guidance on the dependency rule, use-case boundaries, ports, adapters, and framework isolation.
Read `references/architecture-anti-patterns.md` when a proposed design looks clean on paper but may be over-layered, framework-led, or hard to deliver.
Read `references/delivery-checklist.md` when you need a compact quality gate before finalizing the design or code.
Read `references/operational-readiness-playbook.md` when the slice involves rollout, migration, compatibility, authorization, observability, or production failure handling.
Read `../clean-code-architecture-foundation/references/response-contract.md` when you need the shared output format.

## Request Fit

Use this skill for requests like:

- "Analyze this requirement, define the boundaries, and write the code."
- "Break this feature into use cases and implement it with clean architecture."
- "Design the ports and adapters for this workflow before implementation."
- "I need new behavior from this spec, not just a cleanup of the current code."
- "Clarify the acceptance criteria and then implement the smallest working slice."
- "Turn this product request into domain rules, contracts, and code."

Do not use this skill as the primary skill for requests like:

- "This controller is messy. Refactor it without changing behavior."
- "Find the code smell in this module and improve maintainability."
- "Review this existing code and reduce coupling."
- "Keep behavior the same and only clean up the structure."

## Quick Routing

Prefer this skill when most of the user's value comes from turning an idea or spec into a clean implementation path.

- The user starts with a requirement, workflow, story, or API contract.
- The hard part is clarifying behavior and slicing the design.
- New code, new boundary contracts, or new business rules are expected.

Switch to `clean-code-diagnose-refactor` when:

- The user mainly wants review or cleanup of an already-existing implementation.
- The requested work can be completed by restructuring current code without product-scope expansion.
- The most important question is "what is wrong with this code?" rather than "what should we build?"

## Workflow

### 1. Distill the requirement

- Extract goals, actors, inputs, outputs, constraints, and failure cases.
- Convert vague requests into testable acceptance criteria.
- State assumptions clearly when requirements are incomplete.
- Produce a compact requirement summary before coding so the user can see what will actually be built.
- Surface operational constraints early: authentication, authorization, migration impact, rollout, observability, performance, and failure recovery.
- If release constraints dominate the risk, treat them as first-class requirements rather than implementation notes.

Read `references/requirements-template.md` when the request is underspecified.

### 2. Model the architecture slice

- Identify entities, value objects, use cases, ports, adapters, and boundary DTOs.
- Decide what belongs to domain policy versus orchestration versus infrastructure.
- Keep dependencies pointing inward. Let outer layers implement interfaces required by inner layers.
- Use `references/clean-architecture-guidelines.md` to check whether the slice is truly driven by business rules rather than framework convenience.
- Use `references/architecture-anti-patterns.md` to reject layers or abstractions that do not protect a real boundary.

Read `references/architecture-mapping.md` when mapping requirements to layers.

### 3. Choose the implementation seam

- Start from the use case or domain rule that carries the business value.
- Define input and output contracts before wiring transport or persistence.
- Implement only the slice required for the requested behavior, not a speculative platform.
- Favor one vertical slice that can be verified end to end over broad scaffolding with little executable value.
- Use `references/operational-readiness-playbook.md` when choosing the slice depends on rollout safety, migration sequencing, compatibility windows, or observability coverage.

### 4. Write code with clean boundaries

- Keep business rules free from framework types and transport details.
- Use adapters for databases, APIs, queues, files, and UI concerns.
- Translate between external schemas and internal models at boundaries.
- Prefer simple composition over inheritance-heavy design.
- If requirements remain ambiguous, encode the decision as an explicit assumption or TODO at the edge, not as fuzzy domain logic.
- Keep release controls such as feature flags, migration toggles, and compatibility adapters at the edge rather than leaking them into core policy.

### 5. Verify against the requirement

- Test the use case behavior first.
- Add boundary-level tests where integration risk is real.
- Check that acceptance criteria, error paths, and invariants are covered.
- Verify operational readiness where relevant: auth behavior, compatibility assumptions, migration/backfill safety, observability hooks, and rollback posture.
- Use `references/delivery-checklist.md` before concluding that the architecture is complete.

### 6. Report the result

- Summarize assumptions, architectural decisions, implemented behavior, and verification status.
- Call out missing requirement details that still need a product or domain decision.
- Distinguish clearly between code written for the current slice and deferred architecture.

## Output Shape

When the task includes analysis plus implementation, structure the response in this order:

1. Requirement summary
2. Assumptions and gaps
3. Architecture slice
4. Implementation plan or code change
5. Verification status
6. Open decisions

If the user provides only a rough idea, return a tightened requirement and acceptance criteria before expanding into architecture.
