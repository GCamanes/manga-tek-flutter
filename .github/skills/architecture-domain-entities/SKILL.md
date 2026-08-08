---
name: architecture-domain-entities
description: Rules for domain entities in this app. Use when creating or modifying domain entities.
---

## Rules

- Pure Dart class — no JSON, no Firebase, no platform dependencies
- Name: `<Concept>Entity` → file: `<concept>.entity.dart`
- Must extend `Equatable`
- Must be annotated with `@CopyWith()`
- Immutable: `final` fields, `const` constructor
- Run `dart run build_runner build` after changes

## Pattern

```dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'item.entity.g.dart';

@CopyWith()
class ItemEntity extends Equatable {
  final String id;
  final String title;

  const ItemEntity({
    required this.id,
    required this.title,
  });

  @override
  List<Object?> get props => [id, title];
}
```
