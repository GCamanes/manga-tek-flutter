---
name: architecture-data-mappers
description: Rules for mappers in this app. Use when creating or modifying mappers.
---

## Rules

- Name: `<Entity>Mapper` → file: `<entity>.mapper.dart`
- Must implement `MapperTo<E, M>` and/or `MapperFrom<M, E>` from `lib/core/data/mappers/mappers.dart`
- No business logic

| Interface | Method | Direction |
|-----------|--------|-----------|
| `MapperTo<E, M>` | `toEntity(M model)` | model → entity (read) |
| `MapperFrom<M, E>` | `fromEntity(E entity)` | entity → model (write) |

Implement both only when write operations are needed.

## Pattern

```dart
import 'package:mangatek_flutter/core/data/mappers/mappers.dart';

class MangaMapper implements MapperTo<MangaEntity, MangaModel> {
  @override
  MangaEntity toEntity(MangaModel model) => MangaEntity(
        id: model.id,
        title: model.title,
      );
}
```
