---
name: architecture-domain-enums
description: Rules for domain enums in this app. Use when creating or modifying domain enums.
---

## Rules

- Represent domain concepts used in entities or use cases
- Name: `<Concept>Enum` → file: `<concept>.enum.dart`

## Pattern

```dart
enum ItemStatusEnum { on, off }
```
