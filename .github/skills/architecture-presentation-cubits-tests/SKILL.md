---
name: architecture-presentation-cubits-tests
description: Rules for unit testing cubits in this app. Use when creating, modifying, or reviewing cubits — tests are required for every cubit.
---

## Rules

- Required for every cubit
- Tools: `bloc_test` with `blocTest<>()`, `mocktail` for mocking use cases
- Mock the use case — never the cubit itself
- Assert emitted state sequence: loading → success or loading → error

## File location

| Scope | Path |
|---|---|
| Feature | `test/<feature>/presentation/cubits/<name>.cubit_test.dart` |
| Core (app-wide) | `test/core/presentation/cubits/<name>.cubit_test.dart` |

## UseCase cubit test

State type is `BaseState<T>` (from `core/presentation/cubits/base.state.dart`).  
Use `predicate<BaseState<T>>(...)` since the subclasses are private.

```dart
// test/item/presentation/cubits/item_list.cubit_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockGetItemsUseCase extends Mock implements GetItemsUseCase {}

void main() {
  late _MockGetItemsUseCase getItems;

  setUp(() => getItems = _MockGetItemsUseCase());

  group('ItemListCubit', () {
    blocTest<ItemListCubit, BaseState<List<ItemEntity>>>(
      'emits loading then success',
      build: () {
        when(() => getItems())
            .thenAnswer((_) async => UseCaseSuccess([]));
        return ItemListCubit(getItems);
      },
      act: (cubit) => cubit.loadItems(),
      expect: () => [
        predicate<BaseState<List<ItemEntity>>>((s) => s.isLoading),
        predicate<BaseState<List<ItemEntity>>>((s) => s.dataOrNull != null),
      ],
    );

    blocTest<ItemListCubit, BaseState<List<ItemEntity>>>(
      'emits loading then error on failure',
      build: () {
        when(() => getItems()).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.unknown)),
        );
        return ItemListCubit(getItems);
      },
      act: (cubit) => cubit.loadItems(),
      expect: () => [
        predicate<BaseState<List<ItemEntity>>>((s) => s.isLoading),
        predicate<BaseState<List<ItemEntity>>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.unknown) ?? false,
        ),
      ],
    );
  });
}
```
