# Routing Signals

Use these signals to classify the request quickly.

## Evidence buckets

Pull signals from these buckets before deciding:

- current-code pain
- behavior-preservation constraints
- requirements or spec signals
- structure-blocks-feature signals
- missing or contradictory signals

## Route to diagnose-refactor

Strong signals:

- The user talks about current code pain: messy code, hard changes, tight coupling, unreadable logic, or difficult tests
- The current behavior should stay stable
- The user wants review, diagnosis, cleanup, or safer structure
- The user says things like "keep behavior the same", "just clean the structure", or "find the smell first"

Weak signals:

- The user mentions architecture quality, but only in the context of improving the current codebase
- A future feature is mentioned, but no implementation is requested yet

## Route to requirements-build

Strong signals:

- The user starts from a feature idea, requirement, spec, story, or API contract
- New behavior, new endpoints, or new business rules are expected
- The user asks for use cases, domain modeling, ports and adapters, acceptance criteria, or implementation from specs
- The user says things like "analyze this requirement", "design this feature", or "implement this spec"

Weak signals:

- The user mentions cleanup only as a preference while asking for a new feature
- The user wants architecture guidance, but starts from a spec, story, or API contract

## Route to two phases

Strong signals:

- The user wants a new feature but says the current code is too tangled to extend safely
- The request mixes structural cleanup and new feature implementation with equal importance
- A direct feature implementation would likely entrench the current design problems
- The safest next step is a preparatory refactor that opens a seam for the feature

Weak signals:

- The user asks for a new feature and a review of the current code in the same request
- The user wants cleanup first because feature work is imminent, not because cleanup is the end goal

Recommended phase order:

1. Stabilize or extract the minimum seam needed for safe change
2. Implement the new behavior on top of the clearer boundary

## Hard tie-breakers

- `keep behavior stable` beats `new design` and routes to refactor first
- `spec first` beats `cleanup vibes` and routes to requirements first
- `new feature + current structure blocks it` routes to two phases
- `diagnose first` beats vague future feature discussion and routes to refactor
- `implement now` beats generic architecture concerns and routes to requirements

## Clarification threshold

Use `Clarification needed` only when all of these are true:

- no strong signal safely determines the next step
- the request is broad enough that different routes would change the immediate action
- one focused question is likely to resolve the ambiguity

Do not ask clarification if the answer would only refine execution detail inside the same route.

## Decision sentence templates

- `Refactor route: the primary risk is unsafe change in current code, so diagnose and stabilize the implementation first.`
- `Requirements route: the primary risk is building the wrong behavior, so clarify the spec and define boundaries first.`
- `Two-phase route: the feature depends on untangling the current structure, so open a seam first and then implement the new behavior.`
- `Clarification needed: the request names architecture quality but not the next job, so one narrow question is needed before choosing a workflow.`

## Tie-breaker

When still unsure, ask:

- What must remain behaviorally stable right now?
- Is the bigger risk misunderstood requirements or unsafe legacy change?
- Would the next high-value step be diagnosis or use-case design?

Ask at most one focused question. If the answer still will not change the next step, choose the safest route instead of prolonging classification.
