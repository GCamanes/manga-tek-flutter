---
name: architecture-domain-repositories
description: Rules for repository interfaces in this app. Use when creating or modifying domain repository interfaces.
---

## Rules

- Defines what data operations are available to use cases — not how they are implemented
- Always `abstract class` — no implementation here
- No imports from `data/` or `presentation/`
- Name: `<Feature>Repository` → file: `<feature>.repository.dart`

## Pattern

```dart
abstract class ItemRepository {
  Future<List<ItemEntity>> getItems();
  Future<ItemEntity> getItemById(String id);
}
```
