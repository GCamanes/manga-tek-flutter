---
name: architecture-domain-usecases-tests
description: Rules for unit testing use cases in this app. Use when creating, modifying, or reviewing use cases — tests are required for every use case.
---

## Rules

- Required for every use case
- Tools: `mocktail` for mocking, `flutter_test` for assertions
- Mock the repository interface — never the use case itself
- Assert on `UseCaseSuccess` / `UseCaseFailure` sealed variants
- For `StreamUseCase`: use `emits` / `emitsError` on the returned stream

## File location

| Scope | Path |
|---|---|
| Feature | `test/<feature>/domain/<action>.usecase_test.dart` |
| Core (app-wide) | `test/core/domain/<action>.usecase_test.dart` |

## UseCase test

```dart
// test/item/domain/get_items.usecase_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late _MockItemRepository repository;
  late GetItemsUseCase useCase;

  setUp(() {
    repository = _MockItemRepository();
    useCase = GetItemsUseCase(repository);
  });

  group('GetItemsUseCase', () {
    test('returns UseCaseSuccess on success', () async {
      when(() => repository.getItems()).thenAnswer((_) async => []);

      final result = await useCase(NoParam());

      expect(result, isA<UseCaseSuccess<List<ItemEntity>>>());
    });

    test('returns UseCaseFailure on exception', () async {
      when(() => repository.getItems())
          .thenThrow(AppException(type: ExceptionType.unknown));

      final result = await useCase(NoParam());

      expect(result, isA<UseCaseFailure<List<ItemEntity>>>());
    });
  });
}
```

## StreamUseCase test

```dart
// test/item/domain/watch_items.usecase_test.dart
class _MockItemRepository extends Mock implements ItemRepository {}

void main() {
  late _MockItemRepository repository;
  late WatchItemsUseCase useCase;

  setUp(() {
    repository = _MockItemRepository();
    useCase = WatchItemsUseCase(repository);
  });

  group('WatchItemsUseCase', () {
    test('emits UseCaseSuccess on stream event', () {
      when(() => repository.watchItems())
          .thenAnswer((_) => Stream.value([]));

      expect(useCase(NoParam()), emits(isA<UseCaseSuccess<List<ItemEntity>>>()));
    });

    test('emits UseCaseFailure on stream error', () {
      when(() => repository.watchItems())
          .thenAnswer((_) => Stream.error(AppException(type: ExceptionType.unknown)));

      expect(useCase(NoParam()), emits(isA<UseCaseFailure<List<ItemEntity>>>()));
    });
  });
}
```
