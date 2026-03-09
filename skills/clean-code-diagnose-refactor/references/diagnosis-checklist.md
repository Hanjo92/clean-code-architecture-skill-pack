# Diagnosis Checklist

Use this checklist to turn a vague "clean this up" request into concrete findings.

If the user asks in Korean with phrases like "구조가 이상하다", "냄새난다", "책임이 섞였다", "수정이 무섭다", or "테스트하기 어렵다", treat those as signals to run this checklist before proposing changes.

## Intent and readability

- Does each type or function have a single obvious reason to change?
- Do names explain domain meaning rather than implementation detail?
- Can a reader predict side effects from the signature and surrounding context?
- Are there branches, flags, or conditionals hiding multiple workflows in one unit?

## Dependency direction

- Do domain rules depend on frameworks, storage, transport, or UI details?
- Are inward layers importing outward layers directly?
- Are interfaces owned by the side that consumes them?
- Is orchestration mixed with domain decision-making?

## Cohesion and coupling

- Are classes or modules both deciding and doing?
- Do unrelated responsibilities change together?
- Is shared state forcing distant parts of the code to coordinate implicitly?
- Is duplication accidental, or does it reveal a missing concept?

## Data and control flow

- Where does data enter, get transformed, and leave the system?
- Are side effects isolated behind clear seams?
- Are errors translated at boundaries or leaked across layers?
- Are there hidden temporal couplings such as "call A before B" rules?

## Testability and safety

- Is there fast feedback for the code being changed?
- Can characterization tests pin current behavior before refactoring?
- Are tests asserting behavior rather than private implementation details?
- Is the code difficult to test because responsibilities are tangled?
- If tests are weak, what seam, log point, or observable contract can be pinned down first?

## Mixed-task triage

- Is the request actually a bug fix plus cleanup rather than pure refactoring?
- Which change must alter behavior, and which changes must preserve it?
- Can the bug fix land first with minimal churn before structural cleanup resumes?
- Would combining the fix and refactor make rollback or diagnosis harder?

## Refactor priority

Favor issues in this order:

1. Boundary violations that spread framework or I/O concerns into business rules
2. Multi-responsibility units that block safe changes
3. Hidden side effects and implicit state coupling
4. Naming and readability issues that obscure intent
5. Cosmetic cleanup with little effect on future change cost

## Fowler-style smell handling

- Treat a smell as a clue to investigate, not automatic proof that a refactor is needed.
- Prefer smells that explain future change cost: long functions, large classes, divergent change, shotgun surgery, hidden side effects, and data clumps.
- If the smell is real but the payoff is low, document it and move on.
- If the smell is real but the behavior is still poorly understood, defer cleanup until a seam or expectation is pinned down.

## Report wording

Phrase findings in a way that leads directly to an action:

- Bad: "This code is not clean."
- Better: "This service mixes validation, domain decisions, and persistence, so changing one rule forces edits across three responsibilities."
- Better: "This controller owns business rules that should move inward before any new feature is added."
