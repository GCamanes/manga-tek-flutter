---
name: architecture-presentation-cubits-tests
description: Rules for unit testing cubits in this app. Use when writing or reviewing cubit tests.
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
    blocTest<ItemListCubit, CustomCubitState<List<ItemEntity>>>(
      'emits loading then success',
      build: () {
        when(() => getItems(NoParam()))
            .thenAnswer((_) async => UseCaseSuccess([]));
        return ItemListCubit(getItems);
      },
      act: (cubit) => cubit.loadItems(),
      expect: () => [
        isA<CustomCubitLoadingState<List<ItemEntity>>>(),
        isA<CustomCubitSuccessState<List<ItemEntity>>>(),
      ],
    );

    blocTest<ItemListCubit, CustomCubitState<List<ItemEntity>>>(
      'emits loading then error on failure',
      build: () {
        when(() => getItems(NoParam())).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.unknown)),
        );
        return ItemListCubit(getItems);
      },
      act: (cubit) => cubit.loadItems(),
      expect: () => [
        isA<CustomCubitLoadingState<List<ItemEntity>>>(),
        isA<CustomCubitErrorState<List<ItemEntity>>>(),
      ],
    );
  });
}
```

## StreamUseCase cubit test

```dart
// test/item/presentation/cubits/items_watch.cubit_test.dart
class _MockWatchItemsUseCase extends Mock implements WatchItemsUseCase {}

void main() {
  late _MockWatchItemsUseCase watchItems;

  setUp(() => watchItems = _MockWatchItemsUseCase());

  group('ItemsWatchCubit', () {
    blocTest<ItemsWatchCubit, CustomCubitState<List<ItemEntity>>>(
      'emits loading then success on stream event',
      build: () {
        when(() => watchItems(NoParam()))
            .thenAnswer((_) => Stream.value(UseCaseSuccess([])));
        return ItemsWatchCubit(watchItems);
      },
      act: (cubit) => cubit.startWatching(),
      expect: () => [
        isA<CustomCubitLoadingState<List<ItemEntity>>>(),
        isA<CustomCubitSuccessState<List<ItemEntity>>>(),
      ],
    );

    blocTest<ItemsWatchCubit, CustomCubitState<List<ItemEntity>>>(
      'emits loading then error on stream failure',
      build: () {
        when(() => watchItems(NoParam())).thenAnswer(
          (_) => Stream.value(
            UseCaseFailure(AppException(type: ExceptionType.unknown)),
          ),
        );
        return ItemsWatchCubit(watchItems);
      },
      act: (cubit) => cubit.startWatching(),
      expect: () => [
        isA<CustomCubitLoadingState<List<ItemEntity>>>(),
        isA<CustomCubitErrorState<List<ItemEntity>>>(),
      ],
    );
  });
}
```
