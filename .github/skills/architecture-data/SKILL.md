---
name: architecture-data
description: Naming and placement rules for the data layer. Use when working on any data layer file — models, mappers, datasources, or repository implementations.
---

## File naming

`<concept_words_with_underscore>.<type_keyword>.dart`

| Type | Keyword | Example |
|------|---------|---------|
| Model | `.model` | `item.model.dart` |
| Mapper | `.mapper` | `item.mapper.dart` |
| Datasource (abstract) | `.datasource` | `item_remote.datasource.dart` |
| Datasource (impl) | `.datasource_impl` | `item_remote.datasource_impl.dart` |
| Repository (impl) | `.repository_impl` | `item.repository_impl.dart` |

---

## Placement

| What | Location |
|------|----------|
| Generic/reusable data code | `core/data/` |
| Feature-specific data code | `features/<name>/data/` |

Sub-structure: `datasources/`, `repositories_impl/`, `models/`, `mappers/`.
