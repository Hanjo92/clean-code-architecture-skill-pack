# Clean Code / Clean Architecture Skill Pack

A Codex skill pack for clean code and clean architecture workflows.

This repository contains four related skills, each with a distinct role:

- `clean-code-architecture-foundation`: shared principles, priorities, quality bar, and response contract
- `clean-code-architecture-router`: routes a request into refactoring, requirements-to-code, or a two-phase workflow
- `clean-code-diagnose-refactor`: diagnosis and behavior-preserving refactoring for existing code
- `clean-architecture-requirements-build`: requirement analysis, boundary design, and implementation for new behavior

## Why This Exists

Clean code and clean architecture are not single-step checklists.

In real work, the harder questions usually come first:

- Is this a refactor problem or a redesign problem?
- Does current behavior need to remain stable?
- Should a new feature land immediately, or should a seam be opened first?
- Is a new layer actually protecting a boundary, or is it just ceremony?

This repository exists to make those decisions consistently.

## Skill Set

### 1. `clean-code-architecture-foundation`

The top-level meta skill.

It defines:

- shared philosophy: changeability, boundary clarity, explicit intent
- priority rules: refactor vs redesign vs two-phase
- quality bar: avoid architecture theater, favor the smallest useful slice
- shared response contract: keep outputs consistent across related skills

Use it when:

- principles conflict
- a design looks clean but needs judgment
- multiple related skills need a shared standard

### 2. `clean-code-architecture-router`

Routes a request into the right workflow.

Available routes:

- `Refactor route`
- `Requirements route`
- `Two-phase route`
- `Clarification needed`

Use it when:

- the request is ambiguous
- structural cleanup and new feature work are mixed together

### 3. `clean-code-diagnose-refactor`

Focused on existing code diagnosis and safe refactoring.

Key traits:

- prioritizes structural problems instead of listing smells
- uses Martin Fowler style behavior-preserving refactoring rules
- includes fallback rules for weak or missing safety nets
- guards against broad rewrites, speculative cleanup, and aesthetic refactors

Use it for:

- legacy code review
- responsibility splitting
- dependency untangling
- maintainability and testability improvements
- "keep the behavior the same and improve the structure"

### 4. `clean-architecture-requirements-build`

Turns requirements into clean boundaries and real code.

Key traits:

- starts with requirement summary and acceptance criteria
- separates entities, use cases, ports, and adapters
- favors the smallest useful vertical slice
- includes operational checks for auth, migration, observability, rollback, and performance

Use it for:

- new feature design and implementation
- requirement analysis
- port and adapter design
- API or service boundary design

## Recommended Flow

Recommended usage:

1. If the request is ambiguous, start with `clean-code-architecture-router`
2. If judgment is unclear, refer to `clean-code-architecture-foundation`
3. If the work is improving existing code, use `clean-code-diagnose-refactor`
4. If the work starts from a requirement or spec, use `clean-architecture-requirements-build`

For mixed requests:

1. perform a preparatory refactor to open a safe seam
2. implement the new behavior on top of that clearer boundary

## Repository Structure

```text
skills/
  clean-code-architecture-foundation/
  clean-code-architecture-router/
  clean-code-diagnose-refactor/
  clean-architecture-requirements-build/
scripts/
  generate-clean-skill-pngs.ps1
```

Each skill follows this structure:

```text
<skill-name>/
  SKILL.md
  agents/
    openai.yaml
  references/
    *.md
  assets/
    icon.svg
    icon.png
    logo.svg
    logo.png
```

## Installation

### Option 1. Copy into your Codex skills directory

Copy each folder under `skills/` into `$CODEX_HOME/skills` or whatever skills directory your Codex environment uses.

Example:

```powershell
Copy-Item -Recurse .\skills\* "$env:USERPROFILE\.codex\skills\"
```

### Option 2. Use a skill installer workflow

If your Codex environment already uses a skill installer, this repository can be used directly as an install source.

## Validation

The skills in this repository are written to pass `quick_validate.py`.

Example:

```powershell
$env:PYTHONUTF8='1'
python "C:\Users\user\.codex\skills\.system\skill-creator\scripts\quick_validate.py" ".\skills\clean-code-diagnose-refactor"
```

Repeat the same pattern for the other skill folders.

## Assets

Each `agents/openai.yaml` includes UI metadata:

- `display_name`
- `short_description`
- `default_prompt`
- `icon_small`
- `icon_large`
- `brand_color`

Both SVG and PNG assets are included.

To regenerate the PNG assets:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\generate-clean-skill-pngs.ps1
```

## Design Principles Behind This Pack

This pack is built around these ideas:

- clean code is about changeability, not aesthetics
- clean architecture is about dependency direction, not layer count
- smells are investigation signals, not verdicts
- preparatory refactoring plus a small slice beats a broad rewrite
- a deliverable slice matters more than architecture theater
- response structure matters, not just technical advice

## Notes

- Refactoring guidance is strengthened with Martin Fowler inspired concepts and catalog thinking.
- The requirements skill includes anti-pattern and delivery guidance to avoid over-architecting.
- The router uses `Clarification needed` only when one focused question materially changes the route.

## License

This project is licensed under the MIT License.

See [LICENSE](./LICENSE) for the full text.
