# Architecture Anti-Patterns

Use this reference to reject designs that imitate clean architecture terminology without protecting real boundaries.

## Common traps

- Layers that mirror framework folders rather than business boundaries
- Repositories, services, and DTOs created for every entity by default
- Small workflows exploded into many thin files, classes, or interfaces before any real boundary pressure exists
- Tiny ports, interface definitions, or scripts split into separate files even though they only serve one local slice
- Use cases that are so generic they hide actual business intent
- Domain models contaminated with transport, ORM, or framework annotations
- Adapters that contain business policy because the port was defined too loosely
- A central "utils" package that bypasses architectural boundaries

## Review questions

- Which business rule becomes easier to change because of this layer?
- Which dependency direction is protected by this port?
- If the framework changed tomorrow, what code would stay intact?
- Is this abstraction required by the current slice or only by imagined future scope?

## Stop signs

- The diagram looks complete, but the smallest slice still cannot be implemented.
- Most interfaces exist before any concrete behavior needs them.
- The architecture introduces more mapping than meaningful policy separation.
