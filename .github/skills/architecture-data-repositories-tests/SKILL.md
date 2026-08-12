---
name: architecture-data-repositories-tests
description: Rules for unit testing repository implementations in this app. Use when creating, modifying, or reviewing repository implementations — tests are required for every repository impl.
---

## Rules

- Required for every repository implementation
- Tools: `mocktail` for mocking
- Mock the datasource interface — never the repository itself
- Assert entity returned on success and `AppException` thrown on failure
- For stream methods: use `emits` / `emitsError`

## File location

| Scope | Path |
|---|---|
| Feature | `test/<feature>/data/<feature>.repository_impl_test.dart` |
| Core (app-wide) | `test/core/data/<feature>.repository_impl_test.dart` |

## Future method test

```dart
// test/item/data/item.repository_impl_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockItemRemoteDatasource extends Mock implements ItemRemoteDatasource {}

void main() {
  late _MockItemRemoteDatasource datasource;
  late ItemRepositoryImpl repository;

  setUp(() {
    datasource = _MockItemRemoteDatasource();
    repository = ItemRepositoryImpl(datasource);
  });

  group('ItemRepositoryImpl.getItems', () {
    test('returns mapped entities on success', () async {
      when(() => datasource.fetchItems()).thenAnswer((_) async => [ItemModel(...)]);

      final result = await repository.getItems();

      expect(result, isA<List<ItemEntity>>());
    });

    test('throws AppException on datasource failure', () async {
      when(() => datasource.fetchItems()).thenThrow(Exception('network error'));

      expect(() => repository.getItems(), throwsA(isA<AppException>()));
    });
  });
}
```

## Stream method test

```dart
  group('ItemRepositoryImpl.watchItems', () {
    test('emits mapped entities on success', () {
      when(() => datasource.watchItems())
          .thenAnswer((_) => Stream.value([ItemModel(...)]));

      expect(repository.watchItems(), emits(isA<List<ItemEntity>>()));
    });

    test('emits AppException on stream error', () {
      when(() => datasource.watchItems())
          .thenAnswer((_) => Stream.error(Exception('error')));

      expect(repository.watchItems(), emitsError(isA<AppException>()));
    });
  });
```
