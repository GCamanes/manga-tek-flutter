---
name: architecture-domain
description: Naming and placement rules for the domain layer. Use when working on any domain layer file — entities, enums, repository interfaces, or use cases.
---

## Core principle

The domain layer must:
- Depend only on pure Dart — no datasource, no external package
- Never import from `data/` or `presentation/`

---

## File naming

`<concept_words_with_underscore>.<type_keyword>.dart`

| Type | Keyword | Example |
|------|---------|---------|
| Entity | `.entity` | `item.entity.dart` |
| Enum | `.enum` | `item_status.enum.dart` |
| Repository (interface) | `.repository` | `item.repository.dart` |
| Use case | `.usecase` | `get_items.usecase.dart` |

---

## Placement

| What | Location |
|------|----------|
| Generic/shared domain code | `core/domain/` |
| Feature-specific domain code | `features/<name>/domain/` |
