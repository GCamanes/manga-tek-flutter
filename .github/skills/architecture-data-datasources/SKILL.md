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
// item_remote.datasource.dart
abstract class ItemRemoteDatasource {
  Future<List<ItemModel>> fetchItems();
}

// item_remote.datasource_impl.dart
class ItemRemoteDatasourceImpl implements ItemRemoteDatasource {
  @override
  Future<List<ItemModel>> fetchItems() async { /* ... */ }
}
```
