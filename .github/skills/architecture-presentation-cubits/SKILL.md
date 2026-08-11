---
name: architecture-presentation-cubits
description: Rules for cubits in this app. Use when creating or modifying cubits.
---

## Rules

- Manages UI state — the only presentation component that calls use cases
- Must extend `CustomCubit<T>` — never extend `Cubit` directly
- Must depend on use cases only — no datasources, repositories, or navigation
- One cubit = one use case: call `execute()` for `UseCase`, `watch()` for `StreamUseCase`

## Pattern — UseCase (one-shot)

```dart
// item_list.cubit.dart
class ItemListCubit extends CustomCubit<List<ItemEntity>> {
  final GetItemsUseCase _getItems;

  ItemListCubit(this._getItems);

  Future<void> loadItems() => execute(_getItems(NoParam()));
}
```

## Pattern — StreamUseCase (reactive)

```dart
// items_watch.cubit.dart
class ItemsWatchCubit extends CustomCubit<List<ItemEntity>> {
  final WatchItemsUseCase _watchItems;

  ItemsWatchCubit(this._watchItems);

  Future<void> startWatching() => watch(_watchItems(NoParam()));
}
```
