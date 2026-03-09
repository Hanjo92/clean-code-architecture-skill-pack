# Routing Misclassification Checklist

Use this checklist to reduce false routes when prompts mix cleanup language, feature language, and vague architecture concerns.

## How to use

- Run this checklist before asking a clarification question.
- Stop once one answer clearly determines the safest immediate next step.
- Use `references/routing-evaluation-fixtures.md` after the checklist when you want analogy-based confirmation.

## Step 1: Find the immediate job

Ask:

- Is the user asking us to inspect existing code first?
- Is the user asking us to implement new behavior from a requirement or spec?
- Is the user explicitly saying that feature work is blocked by current structure?

If the answer is clear:

- inspect existing code first -> `Refactor route`
- implement new behavior from a requirement or spec -> `Requirements route`
- feature work blocked by current structure -> `Two-phase route`

## Step 2: Ignore misleading words

Do not over-weight a route because the prompt contains one loaded word.

Examples:

- The word `refactor` does not force `Refactor route` if the request starts from a feature spec.
- The word `architecture` does not force `Requirements route` if the next job is reviewing existing code.
- The phrase `keep behavior the same elsewhere` does not cancel the fact that a new feature is being added.

## Step 3: Check for behavior-preservation priority

Route to `Refactor route` when the user explicitly prioritizes:

- keep behavior the same
- review or diagnose first
- clean up existing structure without new product behavior
- reduce coupling, split responsibilities, or improve readability in current code

Do not override this with weaker future-facing language like "we may add a feature later."

## Step 4: Check for spec-first priority

Route to `Requirements route` when the user explicitly prioritizes:

- requirement analysis
- acceptance criteria
- use cases
- API or contract-driven work
- implementation from a feature story or spec

Do not override this with secondary requests like "and mention any smells if relevant."

## Step 5: Check for blocker-first priority

Route to `Two-phase route` when both are true:

- a new feature or capability is required now
- the prompt says current structure blocks safe delivery

Strong blocker phrases include:

- too tangled to extend safely
- need a seam first
- adding this now will make the design worse
- isolate the legacy rules before adding the feature

## Step 6: Decide whether clarification is truly needed

Use `Clarification needed` only when all of these are true:

- no strong signal determines the next action
- different routes would lead to materially different first steps
- one short question would likely resolve the ambiguity

Do not ask clarification when the answer would only change execution detail inside the same route.

## Common misclassification traps

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

## Review pass

Before finalizing the route, confirm:

- I can name the strongest one or two signals.
- I can explain why the other route was not chosen.
- My chosen route determines a clear immediate next step.
- If I asked a question, the answer would genuinely change that next step.

If any of these fail, re-check `references/routing-signals.md` and `references/routing-evaluation-fixtures.md`.
