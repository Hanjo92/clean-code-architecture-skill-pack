# Routing Evaluation Fixtures

Use this set to improve router accuracy against representative prompts, especially for borderline or mixed cases.

## How to use

- Read the prompt only once before choosing a route.
- Identify the strongest signal, not every possible signal.
- Prefer the route that determines the safest immediate next step.
- Use `Clarification needed` only when a single short answer would genuinely change the route.
- Run `routing-misclassification-checklist.md` first when a prompt feels borderline or deceptively mixed.

## Refactor route fixtures

Prompt:
"This module works, but every small change breaks something. Diagnose the structure before touching behavior."
Expected route:
`Refactor route`
Why:
The user explicitly prioritizes diagnosis and behavior stability.

Prompt:
"Separate responsibilities in this service and keep the API behavior the same."
Expected route:
`Refactor route`
Why:
Behavior preservation plus responsibility splitting is a refactor-first signal.

Prompt:
"This controller is full of business logic. Move it somewhere cleaner without changing outputs."
Expected route:
`Refactor route`
Why:
The work is about relocating existing logic safely, not designing new product behavior.

Prompt:
"Review this legacy code and tell me the most dangerous maintainability issue first."
Expected route:
`Refactor route`
Why:
The request is diagnosis-led and anchored in current code risk.

Prompt:
"This function is too long, hard to test, and has hidden side effects. Clean up the worst part first."
Expected route:
`Refactor route`
Why:
The dominant job is structural cleanup of current behavior.

## Requirements route fixtures

Prompt:
"Analyze this requirement, define the use cases, and implement the smallest clean slice."
Expected route:
`Requirements route`
Why:
The request begins with requirements and asks for new implementation.

Prompt:
"Design a clean architecture for this new feature with ports, adapters, and acceptance criteria."
Expected route:
`Requirements route`
Why:
Spec-first boundary design and new behavior dominate.

Prompt:
"Here is an API spec. Build the first working endpoint and call out assumptions."
Expected route:
`Requirements route`
Why:
The immediate next step is implementing behavior from a spec, not diagnosing legacy code.

Prompt:
"Turn this product story into use cases and actual code."
Expected route:
`Requirements route`
Why:
The primary uncertainty is requirement interpretation.

Prompt:
"Write acceptance criteria for bulk export, then implement it cleanly."
Expected route:
`Requirements route`
Why:
Acceptance criteria plus implementation is requirements-first work.

## Two-phase route fixtures

Prompt:
"We need to add refunds, but the payment flow is too tangled to extend safely."
Expected route:
`Two-phase route`
Why:
The feature is real, but the current structure blocks safe delivery.

Prompt:
"There is a clear spec, but adding it now will make the current module even worse. Split the work."
Expected route:
`Two-phase route`
Why:
The user explicitly asks for phased work because the structure is a blocker.

Prompt:
"Add role-based permissions to this service. The current dependency graph is too messy to do it safely."
Expected route:
`Two-phase route`
Why:
The request mixes a new capability with an explicit need to untangle the current code first.

Prompt:
"We need this new workflow this sprint, but first create the seam that keeps the legacy rules isolated."
Expected route:
`Two-phase route`
Why:
The minimum safe path is preparatory refactoring followed by feature delivery.

Prompt:
"Implement the new onboarding flow, but do not keep stacking features on top of this god service."
Expected route:
`Two-phase route`
Why:
Feature work is required, yet direct implementation would deepen a structural problem.

## Clarification needed fixtures

Prompt:
"Make this cleaner."
Expected route:
`Clarification needed`
Why:
There is no code scope, no requirement, and no stated first risk.
Question:
"Is the main job to clean existing behavior or build a new feature?"

Prompt:
"Help me improve this architecture."
Expected route:
`Clarification needed`
Why:
The prompt names architecture quality, but not whether the next step is diagnosis or new implementation.
Question:
"Are we improving existing code or designing from a new requirement?"

Prompt:
"I want this area to be easier to work with."
Expected route:
`Clarification needed`
Why:
The goal is broad and does not reveal whether the next action is review, refactor, or feature design.
Question:
"Do you want diagnosis of the current code first, or implementation of a new requirement?"

## Trap cases

Prompt:
"Refactor this feature spec into clean architecture."
Expected route:
`Requirements route`
Why:
The word `refactor` is misleading here. The request starts from a spec, so requirement analysis still dominates.

Prompt:
"Add this endpoint and keep behavior the same elsewhere."
Expected route:
`Requirements route`
Why:
The request still adds new behavior. The behavior-preservation phrase only limits regression scope.

Prompt:
"Review the current design because we might need a new feature soon."
Expected route:
`Refactor route`
Why:
The immediate next step is diagnosis, not implementation.

Prompt:
"Implement this new use case, but explain the existing code smells if they matter."
Expected route:
`Requirements route`
Why:
Smell discussion is secondary. The immediate value comes from new behavior.
