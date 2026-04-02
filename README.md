# Clean Code / Clean Architecture Skill Pack

Codex용 클린 코드 / 클린 아키텍처 스킬 팩입니다.  
A Codex skill pack for clean code and clean architecture workflows.

이 레포는 역할이 분리된 4개의 스킬로 구성됩니다.  
This repository contains four related skills, each with a distinct role.

- `clean-code-architecture-foundation`: 공통 원칙, 우선순위, 품질 기준, 응답 계약  
  Shared principles, priorities, quality bar, and response contract
- `clean-code-architecture-router`: 요청을 리팩토링 / 요구사항-구현 / 2단계 흐름으로 분기  
  Routes a request into refactoring, requirements-to-code, or a two-phase workflow
- `clean-code-diagnose-refactor`: 기존 코드 진단과 동작 보존형 리팩토링  
  Diagnosis and behavior-preserving refactoring for existing code
- `clean-architecture-requirements-build`: 요구사항 분석, 경계 설계, 신규 코드 구현  
  Requirement analysis, boundary design, and implementation for new behavior

## Why This Exists

클린 코드와 클린 아키텍처는 단순한 체크리스트가 아니라, 상황에 따라 판단이 필요한 작업 방식입니다.  
Clean code and clean architecture are not simple checklists. They require judgment.

실제 작업에서는 보통 이런 질문이 먼저 나옵니다.  
In real work, these are often the first questions:

- 이건 리팩토링 문제인가, 재설계 문제인가?  
  Is this a refactor problem or a redesign problem?
- 기존 동작을 반드시 유지해야 하는가?  
  Does current behavior need to remain stable?
- 신규 기능을 바로 넣어도 되는가, 아니면 먼저 seam을 열어야 하는가?  
  Should a new feature land immediately, or should a seam be opened first?
- 추가하려는 레이어가 진짜 필요한가, 아니면 ceremony인가?  
  Is a new layer actually protecting a boundary, or is it just ceremony?

이 레포는 그런 결정을 일관되게 내리도록 돕기 위해 만들어졌습니다.  
This repository exists to make those decisions consistently.

## Skill Set

### 1. `clean-code-architecture-foundation`

상위 메타 스킬입니다.  
This is the top-level meta skill.

정의하는 내용:  
It defines:

- 공통 철학: changeability, boundary clarity, explicit intent  
  Shared philosophy: changeability, boundary clarity, explicit intent
- 우선순위 규칙: refactor vs redesign vs two-phase  
  Priority rules: refactor vs redesign vs two-phase
- 품질 기준: architecture theater 방지, smallest useful slice 우선  
  Quality bar: avoid architecture theater, favor the smallest useful slice
- 공통 응답 계약: 관련 스킬들의 출력 형식 통일  
  Shared response contract: keep outputs consistent across related skills

추천 사용 상황:  
Use it when:

- 원칙이 충돌할 때  
  principles conflict
- 설계가 그럴듯해 보여도 판단이 필요할 때  
  a design looks clean but still needs judgment
- 여러 스킬이 같은 기준을 공유해야 할 때  
  multiple related skills need a shared standard

### 2. `clean-code-architecture-router`

요청을 적절한 워크플로우로 분기하는 스킬입니다.  
Routes a request into the right workflow.

가능한 분기:  
Available routes:

- `Refactor route`
- `Requirements route`
- `Two-phase route`
- `Clarification needed`

추천 사용 상황:  
Use it when:

- 요청이 애매할 때  
  the request is ambiguous
- 구조 개선과 신규 기능이 섞여 있을 때  
  structural cleanup and new feature work are mixed together

### 3. `clean-code-diagnose-refactor`

기존 코드 진단과 안전한 리팩토링에 집중한 스킬입니다.  
Focused on existing code diagnosis and safe refactoring.

핵심 특징:  
Key traits:

- 코드 스멜을 단순 나열하지 않고 우선순위화  
  prioritizes structural problems instead of listing smells
- Martin Fowler 스타일의 behavior-preserving refactoring 기준 반영  
  uses Martin Fowler style behavior-preserving refactoring rules
- safety net이 약한 상황을 위한 fallback 규칙 포함  
  includes fallback rules for weak or missing safety nets
- broad rewrite, speculative cleanup, aesthetic refactor 방지  
  guards against broad rewrites, speculative cleanup, and aesthetic refactors

추천 사용 상황:  
Use it for:

- 레거시 코드 리뷰  
  legacy code review
- 책임 분리  
  responsibility splitting
- 의존성 정리  
  dependency untangling
- 유지보수성과 테스트성 개선  
  maintainability and testability improvements
- "동작은 유지하고 구조만 개선" 요청  
  "keep the behavior the same and improve the structure"

### 4. `clean-architecture-requirements-build`

요구사항을 clean architecture 경계와 실제 코드로 바꾸는 스킬입니다.  
Turns requirements into clean boundaries and real code.

핵심 특징:  
Key traits:

- requirement summary와 acceptance criteria 우선  
  starts with requirement summary and acceptance criteria
- entities / use cases / ports / adapters 분리  
  separates entities, use cases, ports, and adapters
- smallest useful vertical slice 우선  
  favors the smallest useful vertical slice
- 운영 제약(auth, migration, observability, rollback, performance) 체크 포함  
  includes operational checks for auth, migration, observability, rollback, and performance

추천 사용 상황:  
Use it for:

- 신규 기능 설계 및 구현  
  new feature design and implementation
- 요구사항 분석  
  requirement analysis
- 포트/어댑터 구조 설계  
  port and adapter design
- API / service boundary 설계  
  API or service boundary design

## Recommended Flow

추천 흐름은 다음과 같습니다.  
Recommended usage:

1. 요청이 애매하면 `clean-code-architecture-router`로 먼저 분기  
   If the request is ambiguous, start with `clean-code-architecture-router`
2. 판단 기준이 흔들리면 `clean-code-architecture-foundation` 참조  
   If judgment is unclear, refer to `clean-code-architecture-foundation`
3. 기존 코드 개선이면 `clean-code-diagnose-refactor` 사용  
   If the work is improving existing code, use `clean-code-diagnose-refactor`
4. 요구사항/명세 기반 구현이면 `clean-architecture-requirements-build` 사용  
   If the work starts from a requirement or spec, use `clean-architecture-requirements-build`

혼합 요청의 경우:  
For mixed requests:

1. preparatory refactor로 안전한 seam 확보  
   perform a preparatory refactor to open a safe seam
2. 그 위에 신규 behavior 구현  
   implement the new behavior on top of that clearer boundary

## Structure Policy

이 레포는 파일 수를 줄이는 것 자체를 목표로 하지도, 라인 수만 보고 기계적으로 쪼개는 것도 목표로 하지 않습니다.
This repository does not optimize for low file count, and it does not split documents mechanically by line count.

- 스킬 폴더 단위 분리는 역할 경계가 명확할 때만 유지합니다.
  Keep skill-level folder separation only when the responsibility boundary is clear.
- `references/`는 “한 번에 같이 읽는 판단 흐름”을 기준으로 묶고, 작은 문서를 과도하게 늘리지 않습니다.
  Group `references/` by the decision flow that is usually read together, and avoid multiplying tiny documents.
- 새 파일, 타입, 레이어는 외형보다 실제 변경 비용을 낮출 때만 추가합니다.
  Add a new file, type, or layer only when it lowers real change cost rather than improving appearances alone.

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

각 스킬은 아래 구조를 따릅니다.  
Each skill follows this structure.

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

`skills/` 아래 각 폴더를 `$CODEX_HOME/skills` 또는 Codex가 읽는 skills 디렉터리로 복사하면 됩니다.  
Copy each folder under `skills/` into `$CODEX_HOME/skills` or whatever skills directory your Codex environment uses.

예시 / Example:

```powershell
Copy-Item -Recurse .\skills\* "$env:USERPROFILE\.codex\skills\"
```

### Option 2. Use a skill installer workflow

별도 skill installer를 사용 중이라면 이 레포를 그대로 설치 소스로 사용할 수 있습니다.  
If your Codex environment already uses a skill installer, this repository can be used directly as an install source.

## Validation

이 레포의 스킬은 `quick_validate.py` 기준으로 검증 가능한 형태로 작성되어 있습니다.  
The skills in this repository are written to pass `quick_validate.py`.

예시 / Example:

```powershell
$env:PYTHONUTF8='1'
python "C:\Users\user\.codex\skills\.system\skill-creator\scripts\quick_validate.py" ".\skills\clean-code-diagnose-refactor"
```

같은 방식으로 다른 스킬 폴더도 검증할 수 있습니다.  
Repeat the same pattern for the other skill folders.

## Assets

각 `agents/openai.yaml`에는 UI 메타데이터가 포함되어 있습니다.  
Each `agents/openai.yaml` includes UI metadata.

- `display_name`
- `short_description`
- `default_prompt`
- `icon_small`
- `icon_large`
- `brand_color`

SVG와 PNG 자산을 모두 포함합니다.  
Both SVG and PNG assets are included.

PNG 재생성 명령 / To regenerate the PNG assets:

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\generate-clean-skill-pngs.ps1
```

## Design Principles Behind This Pack

이 스킬 팩은 다음 원칙을 중심으로 설계되었습니다.  
This pack is built around these ideas:

- 클린 코드는 미학이 아니라 changeability를 위한 것이다  
  clean code is about changeability, not aesthetics
- 클린 아키텍처는 레이어 수보다 dependency direction이 중요하다  
  clean architecture is about dependency direction, not layer count
- smell은 판결이 아니라 조사 신호다  
  smells are investigation signals, not verdicts
- broad rewrite보다 preparatory refactor + small slice가 우선이다  
  preparatory refactoring plus a small slice beats a broad rewrite
- architecture theater보다 deliverable slice가 더 중요하다  
  a deliverable slice matters more than architecture theater
- 기술 조언뿐 아니라 응답 형식의 일관성도 중요하다  
  response structure matters, not just technical advice

## Notes

- 리팩토링 지침은 Martin Fowler의 개념과 catalog적 사고를 참고해 보강했습니다.  
  Refactoring guidance is strengthened with Martin Fowler inspired concepts and catalog thinking.
- 요구사항 스킬은 over-architecting을 막기 위해 anti-pattern과 delivery guidance를 포함합니다.  
  The requirements skill includes anti-pattern and delivery guidance to avoid over-architecting.
- 라우터는 분기를 억지로 하지 않고, 꼭 필요할 때만 `Clarification needed`를 사용합니다.  
  The router uses `Clarification needed` only when one focused question materially changes the route.

## License

이 프로젝트는 MIT License를 따릅니다.  
This project is licensed under the MIT License.

전체 텍스트는 [LICENSE](./LICENSE)에서 확인할 수 있습니다.  
See [LICENSE](./LICENSE) for the full text.
