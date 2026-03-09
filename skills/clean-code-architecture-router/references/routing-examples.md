# Routing Examples

Use these representative prompts as a fast route-check before overthinking classification.

## Refactor route

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

## Requirements route

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

## Two-phase route

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

## Clarification needed

Prompt:
"Make the architecture cleaner."
Reason:
The request names a quality goal but does not reveal whether the next action is diagnosis or new implementation.

Prompt:
"Help me improve this area."
Reason:
There is not enough signal to know whether to inspect current code or design a new slice.

## Usage note

If a prompt matches one of these examples closely, use the same route unless the user explicitly overrides the priority by saying that behavior preservation or requirement interpretation is the first concern.
