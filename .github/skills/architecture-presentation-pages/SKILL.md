---
name: architecture-presentation-pages
description: Rules for pages in this app. Use when creating or modifying pages.
---

## Rules

- Top-level screen widget rendered by the router — never instantiated directly between pages
- Stateless when possible; use `BlocProvider` / `BlocBuilder` for state
- Instantiate cubits directly in `BlocProvider.create`, injecting use cases via `getIt`
- The page's own `build` context is **above** `BlocProvider` — use `context.read<MyCubit>()` only inside `BlocBuilder`'s builder or descendant widget callbacks, never in the outer build scope
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
        body: BlocBuilder<ItemListCubit, BaseState<List<ItemEntity>>>(
          builder: (context, state) => state.when(
            onInitial: () => const SizedBox.shrink(),
            onLoading: () => const CircularProgressIndicator(),
            onSuccess: (items) => ItemListView(items),
            onError: (error) => ErrorView(error),
          ),
        ),
      ),
    );
  }
}
```
