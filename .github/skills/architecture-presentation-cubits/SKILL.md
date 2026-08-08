---
name: architecture-presentation-cubits
description: Rules for cubits and states in this app. Use when creating or modifying cubits or state classes.
---

## Rules

- Manages UI state — the only presentation component that calls use cases
- Must **not** call datasources or repositories directly
- Must **not** contain navigation — use `RouterHelper` in pages
- Each cubit has a dedicated state file in the same folder
- Handle use case results with `switch` on `UseCaseResult`

## Pattern

```dart
// item_list.state.dart
sealed class ItemListState {}
class ItemListInitial extends ItemListState {}
class ItemListLoading extends ItemListState {}
class ItemListLoaded extends ItemListState {
  final List<ItemEntity> items;
  ItemListLoaded(this.items);
}
class ItemListError extends ItemListState {
  final AppException error;
  ItemListError(this.error);
}

// item_list.cubit.dart
class ItemListCubit extends Cubit<ItemListState> {
  final GetItemsUseCase _getItems;

  ItemListCubit(this._getItems) : super(ItemListInitial());

  Future<void> loadItems() async {
    emit(ItemListLoading());
    switch (await _getItems(NoParam())) {
      case UseCaseSuccess(:final data):
        emit(ItemListLoaded(data));
      case UseCaseFailure(:final exception):
        emit(ItemListError(exception));
    }
  }
}
```
