---
name: architecture-data-datasources
description: Rules for datasources in this app. Use when creating or modifying datasources.
---

## Rules

- Direct interface to an external system (API, Firebase, SharedPreferences, SQLite)
- Always define an **abstract interface** + concrete **implementation** in separate files
- Names: `<Feature>RemoteDatasource` / `<Feature>LocalDatasource`

## Pattern

```dart
// manga_remote.datasource.dart
abstract class MangaRemoteDatasource {
  Future<List<MangaModel>> fetchMangas();
}

// manga_remote.datasource_impl.dart
class MangaRemoteDatasourceImpl implements MangaRemoteDatasource {
  @override
  Future<List<MangaModel>> fetchMangas() async { /* ... */ }
}
```
