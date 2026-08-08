---
name: architecture-domain-usecases
description: Rules for use cases in this app. Use when creating or modifying use cases.
---

## Rules

- Implements one specific business action
- Must **extend** `UseCase<P, O>` from `core/domain/usecases/usecase.interface.dart`
  - `P` = params type (use `NoParam` when no params needed)
  - `O` = `UseCaseResult<DataType>`
- `call()` must return the result of `guard()`; the lambda inside can call any number of repos as long as its return type matches `O`
- Must only depend on repository interfaces — never concrete implementations or datasources
- Name: `<Action>UseCase` → file: `<action>.usecase.dart`

## Pattern

```dart
class GetItemsUseCase extends UseCase<NoParam, UseCaseResult<List<ItemEntity>>> {
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

## ❌ Forbidden

| Rule |
|------|
| Calling datasources directly |
| Importing from `data/` or `presentation/` |
| More than one business action per class |
| Returning repo result directly without `guard` |
