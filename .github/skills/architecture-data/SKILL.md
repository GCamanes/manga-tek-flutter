---
name: architecture-data
description: Naming and placement rules for the data layer. Use when working on any data layer file — models, mappers, datasources, or repository implementations.
---

## File naming

`<concept_words_with_underscore>.<type_keyword>.dart`

| Type | Keyword | Example |
|------|---------|---------|
| Model | `.model` | `manga.model.dart` |
| Mapper | `.mapper` | `manga.mapper.dart` |
| Datasource (abstract) | `.datasource` | `manga_remote.datasource.dart` |
| Datasource (impl) | `.datasource_impl` | `manga_remote.datasource_impl.dart` |
| Repository (impl) | `.repository_impl` | `manga.repository_impl.dart` |

---

## Placement

| What | Location |
|------|----------|
| Generic/reusable data code | `core/data/` |
| Feature-specific data code | `features/<name>/data/` |

Sub-structure: `datasources/`, `repositories_impl/`, `models/`, `mappers/`.
