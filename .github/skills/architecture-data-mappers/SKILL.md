---
name: architecture-data-mappers
description: Rules for mappers in this app. Use when creating or modifying mappers.
---

## Rules

- Name: `<Entity>Mapper` → file: `<entity>.mapper.dart`
- Must implement `MapperTo<E, M>` and/or `MapperFrom<M, E>` from `lib/core/data/mappers/mappers.dart`
- No business logic
- Not injectable — call inline with `const`, no variable needed: `const UserMapper().toEntity(model)`

| Interface | Method | Direction |
|-----------|--------|-----------|
| `MapperTo<E, M>` | `toEntity(M model)` | model → entity (read) |
| `MapperFrom<M, E>` | `fromEntity(E entity)` | entity → model (write) |

Implement both only when write operations are needed.

## Pattern

```dart
import 'package:mangatek_flutter/core/data/mappers/mappers.dart';

class ItemMapper implements MapperTo<ItemEntity, ItemModel> {
  const ItemMapper();

  @override
  ItemEntity toEntity(ItemModel model) => ItemEntity(
        id: model.id,
        title: model.title,
      );
}
```

Repository usage — call inline, no field or variable:

```dart
return const UserMapper().toEntity(model);
```
