---
name: architecture-data-models
description: Rules for data models in this app. Use when creating or modifying data models.
---

## Rules

- Only exist in the data layer — never leak to domain or presentation
- Represent raw data from an external source (API, Firestore, DB)
- Name: `<Entity>Model` → file: `<entity>.model.dart`
- Must use `@JsonSerializable()` — run `dart run build_runner build` after changes

## Pattern

```dart
import 'package:json_annotation/json_annotation.dart';

part 'item.model.g.dart';

@JsonSerializable()
class ItemModel {
  final String id;
  final String title;

  const ItemModel({required this.id, required this.title});

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
}
```

Snake_case JSON key:
```dart
@JsonKey(name: 'cover_image')
final String coverImage;
```
