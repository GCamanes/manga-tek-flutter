---
name: architecture-domain-usecases
description: Rules for use cases in this app. Use when creating or modifying use cases.
---

## Rules

- Implements one specific business action
- Two base classes in `core/domain/usecases/usecase.interface.dart`:

| Class | Return type | Use for |
|-------|------------|---------|
| `UseCase<P, O>` | `Future<UseCaseResult<O>>` via `guard()` | One-shot async operations |
| `StreamUseCase<P, O>` | `Stream<UseCaseResult<O>>` via `guardOnStream()` | Reactive / real-time data |

- `P` = params type (use `NoParam` when no params needed), `O` = data type
- Must only depend on repository interfaces
- Must **always** wrap the return value with `guard()` or `guardOnStream()` — never return a repo result directly
- Name: `<Action>UseCase` → file: `<action>.usecase.dart`

## UseCase pattern

```dart
class GetItemsUseCase extends UseCase<NoParam, List<ItemEntity>> {
  final ItemRepository _repository;
  const GetItemsUseCase(this._repository);

  @override
  Future<UseCaseResult<List<ItemEntity>>> call(NoParam param) =>
      guard(() async {
        // any repo calls here — return must match O
        ...
        return _repository.getItems();
      });
}
```

## StreamUseCase pattern

```dart
class WatchItemsUseCase extends StreamUseCase<NoParam, List<ItemEntity>> {
  final ItemRepository _repository;
  const WatchItemsUseCase(this._repository);

  @override
  Stream<UseCaseResult<List<ItemEntity>>> call(NoParam param) =>
      guardOnStream(_repository.watchItems());
}
```
