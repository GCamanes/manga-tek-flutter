---
name: architecture-presentation-pages
description: Rules for pages in this app. Use when creating or modifying pages.
---

## Rules

- Top-level screen widget rendered by the router — never instantiated directly between pages
- Stateless when possible; use `BlocProvider` / `BlocBuilder` for state
- Instantiate cubits directly in `BlocProvider.create`, injecting use cases via `getIt`
- All text via `context.trad.<key>` — no hardcoded strings
- Navigation via `RouterHelper` — never `context.go()` directly

## Pattern

```dart
class ItemListPage extends StatelessWidget {
  const ItemListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ItemListCubit(getIt<GetItemsUseCase>())..loadItems(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.trad.items)),
        body: BlocBuilder<ItemListCubit, ItemListState>(
          builder: (context, state) => switch (state) {
            ItemListLoading() => const CircularProgressIndicator(),
            ItemListLoaded(:final items) => ItemListView(items),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}
```
