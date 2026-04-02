---
name: clean-code-architecture-foundation
description: Provide the shared philosophy, decision rules, and quality bar behind clean-code and clean-architecture work. Use when the task is about common principles, tradeoffs, boundary decisions, refactor-versus-redesign judgment, architecture quality standards, or coordinating routing, refactoring, and requirements-driven implementation under one consistent approach.
---

# Clean Code Architecture Foundation

## Overview

Use this skill as the common backbone for all clean-code and clean-architecture work. It defines the principles that should stay stable even when the task changes between routing, refactoring, and new implementation.

This skill is not the primary execution workflow for most coding tasks. Use it to align judgment, resolve conflicts, and keep output quality consistent across related skills.

## Core Use

Use this skill when you need to:

- explain the common philosophy behind clean code and clean architecture
- resolve whether a decision improves structure or only adds ceremony
- choose between refactoring first, requirements analysis first, or a two-phase plan
- enforce a shared quality bar across multiple related tasks
- review whether a result is clean in a meaningful, task-driven sense

## Workflow

### 1. Start from business changeability

- Prefer decisions that make future change safer, cheaper, and easier to reason about.
- Value readability, boundary clarity, and testability because they reduce change cost.
- Reject cleanup or architecture work that does not improve changeability or correctness.
- Treat unnecessary file, class, or layer splitting as structural cost, not as automatic cleanliness.
- Keep tiny interface definitions or trivial scripts in the same file as their owning slice until they gain a real independent reason to exist.

Read `references/foundation-guide.md` for the common philosophy.

### 2. Resolve competing priorities

- When behavior stability conflicts with design ambition, preserve behavior first.
- When requirement ambiguity conflicts with structural cleanup, clarify the requirement first unless the current structure blocks safe delivery.
- When both new behavior and structural cleanup matter, sequence them rather than blending them invisibly.

Read `references/foundation-guide.md` when priorities compete.

### 3. Apply the quality bar

- Judge the result by the smallest useful slice that is easier to understand and safer to change.
- Prefer explicit assumptions, narrow abstractions, and verifiable progress.
- Distinguish necessary architecture from architecture theater.
- Prefer cohesive modules over mechanically splitting files or classes when the project size and change pressure do not justify more structure.
- Prefer one cohesive file over scattering tiny interfaces or scripts across separate files when the reader still benefits more from local reading than from indirection.

Read `references/foundation-guide.md` before finalizing a result.
Read `references/response-contract.md` when you need the shared output format and response discipline across related skills.

## Relationship To Other Skills

- Use `clean-code-architecture-router` to classify the dominant workflow.
- Use `clean-code-diagnose-refactor` to improve existing implementations without intended behavior change.
- Use `clean-architecture-requirements-build` to turn requirements into clean boundaries and code.

## Output Shape

When this skill is used directly, return:

1. Governing principle
2. Priority decision
3. Recommended workflow
4. Quality risks to watch
