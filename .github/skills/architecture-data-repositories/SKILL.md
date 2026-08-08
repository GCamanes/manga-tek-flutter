---
name: architecture-data-repositories
description: Rules for repository implementations in this app. Use when creating or modifying repository implementations.
---

## Rules

- Implements the domain repository interface
- Responsibilities: call datasource(s) → map models to entities → catch and map exceptions to `AppException`
- No business logic (belongs in use cases)
- Name: `<Feature>RepositoryImpl` → file: `<feature>.repository_impl.dart`
- Placed in `repositories_impl/`

## Pattern

```dart
class ItemRepositoryImpl implements ItemRepository {
  final ItemRemoteDatasource _datasource;
  const ItemRepositoryImpl(this._datasource);

  @override
  Future<List<ItemEntity>> getItems() async {
    try {
      final models = await _datasource.fetchItems();
      return models.map(ItemMapper.toEntity).toList();
    } on FirebaseException catch (e) {
      throw AppException.fromFirebase(e);
    } catch (_) {
      throw const AppException.unknown();
    }
  }
}
```
