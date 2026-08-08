---
name: architecture-data-repositories
description: Rules for repository implementations in this app. Use when creating or modifying repository implementations.
---

## Rules

- Implements the domain repository interface
- Responsibilities: call datasource(s) → map models to entities → catch and map exceptions to `AppException`
- Name: `<Feature>RepositoryImpl` → file: `<feature>.repository_impl.dart`
- Placed in `repositories_impl/`

## Pattern

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

## ❌ Forbidden

| Rule |
|------|
| Business logic (belongs in use cases) |
| Returning raw models (always map to entities) |
| Throwing raw platform exceptions (always map to `AppException`) |
