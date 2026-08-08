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

part 'manga.model.g.dart';

@JsonSerializable()
class MangaModel {
  final String id;
  final String title;

  const MangaModel({required this.id, required this.title});

  factory MangaModel.fromJson(Map<String, dynamic> json) =>
      _$MangaModelFromJson(json);

  Map<String, dynamic> toJson() => _$MangaModelToJson(this);
}
```

Snake_case JSON key:
```dart
@JsonKey(name: 'cover_image')
final String coverImage;
```
