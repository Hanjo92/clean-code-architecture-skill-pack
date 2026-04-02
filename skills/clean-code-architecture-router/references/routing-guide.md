# Routing Guide

Use this guide to classify requests quickly, reduce false routes, and anchor the decision in the safest immediate next step.

## Evidence buckets

Pull signals from these buckets before deciding:

- current-code pain
- behavior-preservation constraints
- requirements or spec signals
- structure-blocks-feature signals
- missing or contradictory signals

## Route signals

### Route to diagnose-refactor

Strong signals:

- The user talks about current code pain: messy code, hard changes, tight coupling, unreadable logic, or difficult tests
- The current behavior should stay stable
- The user wants review, diagnosis, cleanup, or safer structure
- The user says things like "keep behavior the same", "just clean the structure", or "find the smell first"

Weak signals:

- The user mentions architecture quality, but only in the context of improving the current codebase
- A future feature is mentioned, but no implementation is requested yet

### Route to requirements-build

Strong signals:

- The user starts from a feature idea, requirement, spec, story, or API contract
- New behavior, new endpoints, or new business rules are expected
- The user asks for use cases, domain modeling, ports and adapters, acceptance criteria, or implementation from specs
- The user says things like "analyze this requirement", "design this feature", or "implement this spec"

Weak signals:

- The user mentions cleanup only as a preference while asking for a new feature
- The user wants architecture guidance, but starts from a spec, story, or API contract

### Route to two phases

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

## Misclassification checklist

Run this checklist before asking a clarification question. Stop once one answer clearly determines the safest immediate next step.

### Step 1: Find the immediate job

Ask:

- Is the user asking us to inspect existing code first?
- Is the user asking us to implement new behavior from a requirement or spec?
- Is the user explicitly saying that feature work is blocked by current structure?

If the answer is clear:

- inspect existing code first -> `Refactor route`
- implement new behavior from a requirement or spec -> `Requirements route`
- feature work blocked by current structure -> `Two-phase route`

### Step 2: Ignore misleading words

Do not over-weight a route because the prompt contains one loaded word.

Examples:

- The word `refactor` does not force `Refactor route` if the request starts from a feature spec.
- The word `architecture` does not force `Requirements route` if the next job is reviewing existing code.
- The phrase `keep behavior the same elsewhere` does not cancel the fact that a new feature is being added.

### Step 3: Check for behavior-preservation priority

Route to `Refactor route` when the user explicitly prioritizes:

- keep behavior the same
- review or diagnose first
- clean up existing structure without new product behavior
- reduce coupling, split responsibilities, or improve readability in current code

Do not override this with weaker future-facing language like "we may add a feature later."

### Step 4: Check for spec-first priority

Route to `Requirements route` when the user explicitly prioritizes:

- requirement analysis
- acceptance criteria
- use cases
- API or contract-driven work
- implementation from a feature story or spec

Do not override this with secondary requests like "and mention any smells if relevant."

### Step 5: Check for blocker-first priority

Route to `Two-phase route` when both are true:

- a new feature or capability is required now
- the prompt says current structure blocks safe delivery

Strong blocker phrases include:

- too tangled to extend safely
- need a seam first
- adding this now will make the design worse
- isolate the legacy rules before adding the feature

### Step 6: Decide whether clarification is truly needed

Use `Clarification needed` only when all of these are true:

- no strong signal determines the next action
- different routes would lead to materially different first steps
- one short question would likely resolve the ambiguity

Do not ask clarification when the answer would only change execution detail inside the same route.

## Common traps

### Trap: confusing future intent with current task

Prompt pattern:
"Review this now because we may add a feature later."

Correct route:
`Refactor route`

Why:
The immediate job is diagnosis.

### Trap: confusing feature delivery with cleanup preference

Prompt pattern:
"Build this feature cleanly and mention any smells."

Correct route:
`Requirements route`

Why:
The immediate job is still new behavior delivery.

### Trap: confusing blocker cleanup with cleanup as the end goal

Prompt pattern:
"Add this feature, but first untangle the module so we can do it safely."

Correct route:
`Two-phase route`

Why:
Cleanup is necessary, but not the final outcome.

### Trap: overusing clarification

Prompt pattern:
The prompt contains one strong signal plus a few weak conflicting hints.

Correct action:
Choose the route based on the strong signal.

Why:
Clarification should not replace a sound tie-breaker.

## Representative examples

### Refactor route

Prompt:
"Why is this code so hard to change? Diagnose the structure first."
Reason:
Current implementation pain is primary. The user wants diagnosis before new design.

Prompt:
"Keep the behavior the same and just separate responsibilities."
Reason:
Behavior preservation plus structural cleanup means refactor first.

Prompt:
"This function is too long and hard to test. Clean up the worst smells first."
Reason:
This is maintainability work on existing behavior.

Prompt:
"This controller contains too much business logic. Move it safely."
Reason:
The main job is relocating and clarifying current logic, not designing new features.

Prompt:
"Review this area now. We may add a feature later, but first tell me why it is brittle."
Reason:
The future feature is secondary. The immediate work is diagnosis of current code.

### Requirements route

Prompt:
"Analyze this requirement, define the use cases, and implement it cleanly."
Reason:
The request starts from requirements and asks for boundary design plus new code.

Prompt:
"Design a new API from this spec using clean architecture."
Reason:
Spec-first and new behavior indicate requirements-build.

Prompt:
"Write acceptance criteria for this feature and then implement the smallest working slice."
Reason:
The dominant risk is building the wrong behavior, not cleaning up legacy code.

Prompt:
"Build this new workflow cleanly. If the current code smells matter, call them out briefly."
Reason:
The immediate job is still new implementation. Smell commentary is secondary.

### Two-phase route

Prompt:
"We need a new feature, but the current code is too tangled to extend safely."
Reason:
The feature depends on untangling the current structure first.

Prompt:
"We need to clean up the payment flow and add refunds right away."
Reason:
Cleanup and new behavior are both first-class concerns. Split the work into phases.

Prompt:
"There is a spec, but adding it on top of the current structure will make things worse."
Reason:
Start with a preparatory refactor to open a seam, then implement the feature.

Prompt:
"Add this capability, but first isolate the legacy rules so we stop stacking changes on the god module."
Reason:
The user explicitly couples new behavior with the need for a preparatory seam.

### Clarification needed

Prompt:
"Make the architecture cleaner."
Reason:
The request names a quality goal but does not reveal whether the next action is diagnosis or new implementation.

Prompt:
"Help me improve this area."
Reason:
There is not enough signal to know whether to inspect current code or design a new slice.

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
