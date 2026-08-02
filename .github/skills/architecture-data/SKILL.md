---
name: architecture-data
description: Rules for the data layer in this app. Use when working on datasources, API integration, models, mappers, or repository implementations.
---

## File naming convention

Words in the concept part are joined with `_`. The type keyword is preceded by `.`:

```
<concept_words_with_underscore>.<type_keyword>.dart
```

| Type | Keyword | Example |
|---|---|---|
| Model | `.model` | `manga.model.dart` |
| Mapper | `.mapper` | `manga.mapper.dart` |
| Datasource (abstract) | `.datasource` | `manga_remote.datasource.dart` |
| Datasource (impl) | `.datasource_impl` | `manga_remote.datasource_impl.dart` |
| Repository (impl) | `.repository_impl` | `manga.repository_impl.dart` |

---

## Placement rules

| What | `core/` | `features/<name>/` |
|---|---|---|
| Generic/reusable data code | `core/data/` | — |
| Feature-specific data code | — | `features/<name>/data/` |

Sub-structure: `datasources/`, `repositories_impl/`, `models/`, `mappers/`.

---

## Models

- Models **only exist in the data layer** — they must never leak into domain or presentation.
- A model represents the raw shape of data from an external source (API response, Firestore document, local DB row).
- Name: `<Entity>Model` → file: `<entity>.model.dart` (e.g. `manga.model.dart`)
- Must use `@JsonSerializable()` for generated `fromJson` / `toJson`.
- Run `dart run build_runner build` after adding or modifying models.

```dart
import 'package:json_annotation/json_annotation.dart';

part '<entity>.model.g.dart';

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

For snake_case JSON keys mapped to camelCase fields:
```dart
@JsonSerializable()
class MangaModel {
  @JsonKey(name: 'cover_image')
  final String coverImage;
  // ...
}
```

---

## Mappers

- A mapper converts a **model → entity** (one direction only).
- Name: `<Entity>Mapper` → file: `<entity>.mapper.dart` (e.g. `manga.mapper.dart`)
- Must be a class with a single static `toEntity()` method.
- Must not contain business logic.

```dart
class MangaMapper {
  static MangaEntity toEntity(MangaModel model) => MangaEntity(
        id: model.id,
        title: model.title,
      );
}
```

---

## Datasources

- A datasource is the **direct interface to an external system** (Firebase, REST API, SharedPreferences, SQLite, etc.).
- Always define an **abstract interface** + a concrete **implementation** in separate files.
- Name: `<Feature>RemoteDatasource` / `<Feature>LocalDatasource`
- Files: `<feature>_remote.datasource.dart` / `<feature>_local.datasource.dart`
- Implementation files: `<feature>_remote.datasource_impl.dart` / `<feature>_local.datasource_impl.dart`

```dart
// Abstract interface — manga_remote.datasource.dart
abstract class MangaRemoteDatasource {
  Future<List<MangaModel>> fetchMangas();
}

// Implementation — manga_remote.datasource_impl.dart
class MangaRemoteDatasourceImpl implements MangaRemoteDatasource {
  @override
  Future<List<MangaModel>> fetchMangas() async { /* ... */ }
}
```

---

## Repository implementations

- The repository implementation **lives in the data layer** and implements the domain repository interface.
- It is responsible for:
  1. Calling the appropriate datasource(s)
  2. Mapping models → entities via the mapper
  3. Catching raw exceptions and mapping them to `AppException`
- Name: `<Feature>RepositoryImpl` → file: `<feature>.repository_impl.dart` (e.g. `manga.repository_impl.dart`)
- Placed in `repositories_impl/`
- Must **not** contain business logic — that belongs in use cases.

```dart
class MangaRepositoryImpl implements MangaRepository {
  final MangaRemoteDatasource _datasource;
  const MangaRepositoryImpl(this._datasource);

  @override
  Future<List<MangaEntity>> getMangas() async {
    try {
      final models = await _datasource.fetchMangas();
      return models.map(MangaMapper.toEntity).toList();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    } catch (_) {
      throw const AppException.unknown();
    }
  }
}
```

### ❌ Forbidden in repository implementations
- Business logic (belongs in use cases)
- Returning raw models to callers (always map to entities first)
- Throwing raw platform exceptions (always map to `AppException`)
