# Architecture Mapping

Map each requirement artifact to a clean-architecture element.

If the user asks in Korean with phrases like "요구사항 정리", "유스케이스 뽑아줘", "도메인 모델링", "포트/어댑터", or "클린 아키텍처로 구현", treat that as a signal to use this mapping before writing framework-facing code.

## Domain

- Put business rules, invariants, and core concepts in entities or domain services.
- Use value objects for validated concepts with behavior and constraints.
- Keep the domain independent from frameworks, databases, HTTP, and UI.

## Use case

- Put application-specific workflows in use-case interactors or application services.
- Let use cases coordinate ports, enforce policies, and return response models.
- Keep transaction boundaries and orchestration here, not in controllers or repositories.

## Ports

- Define ports from the perspective of the inner layer that needs them.
- Keep port interfaces narrow and use-case oriented.
- Model input and output data as boundary types, not framework request objects.

## Adapters

- Implement ports in repositories, gateways, presenters, controllers, or handlers.
- Translate between external schemas and internal models here.
- Keep serialization, ORM, HTTP, and messaging details at this edge.

## Delivery guidance

Favor this sequence:

1. Acceptance criteria
2. Use-case contract
3. Domain rules
4. Port interfaces
5. Adapter wiring
6. Integration verification

## Minimal artifacts

For most feature requests, produce these artifacts before or during implementation:

1. One-paragraph requirement summary
2. Acceptance criteria with at least one unhappy path
3. Named use case
4. Input/output contract
5. Port list with ownership
6. Smallest end-to-end code slice
