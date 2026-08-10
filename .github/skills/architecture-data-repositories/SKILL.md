---
name: architecture-data-repositories
description: Rules for repository implementations in this app. Use when creating or modifying repository implementations.
---

## Rules

- Implements the domain repository interface
- Must use `RepositoryMixin` — never write try/catch manually
- Responsibilities: call datasource(s) → map models to entities → let `guard`/`guardOnStream` handle error mapping
- No business logic (belongs in use cases)
- Name: `<Feature>RepositoryImpl` → file: `<feature>.repository_impl.dart`
- Placed in `repositories_impl/`

## Pattern — Future

```dart
class ItemRepositoryImpl with RepositoryMixin implements ItemRepository {
  final ItemRemoteDatasource _datasource;
  const ItemRepositoryImpl(this._datasource);

  @override
  Future<List<ItemEntity>> getItems() =>
      guard(() async {
        final models = await _datasource.fetchItems();
        return models.map(ItemMapper.toEntity).toList();
      });
}
```

## Pattern — Stream

```dart
class ItemRepositoryImpl with RepositoryMixin implements ItemRepository {
  final ItemRemoteDatasource _datasource;
  const ItemRepositoryImpl(this._datasource);

  @override
  Stream<List<ItemEntity>> watchItems() =>
      guardOnStream(
        _datasource.watchItems().map((models) => models.map(ItemMapper.toEntity).toList()),
      );
}
```
