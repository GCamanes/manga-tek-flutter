---
name: architecture-presentation
description: Rules for the presentation layer in this app. Use when creating or modifying UI pages, state management cubits, or reusable widgets.
---

## File naming convention

Words in the concept part are joined with `_`. The type keyword is preceded by `.`:

```
<concept_words_with_underscore>.<type_keyword>.dart
```

| Type | Keyword | Example |
|---|---|---|
| Page | `.page` | `manga_list.page.dart`, `manga_detail.page.dart` |
| Cubit | `.cubit` | `manga_list.cubit.dart` |
| State | `.state` | `manga_list.state.dart` |
| Widget | `.widget` | `manga_card.widget.dart`, `app_button.widget.dart` |

---

## Placement rules

| What | `core/` | `features/<name>/` |
|---|---|---|
| Generic/reusable widgets | `core/presentation/widgets/` | — |
| Generic/shared cubits | `core/presentation/cubits/` | — |
| Feature-specific page | — | `features/<name>/presentation/pages/` |
| Feature-specific widget | — | `features/<name>/presentation/widgets/` |
| Feature-specific cubit | — | `features/<name>/presentation/cubits/` |

---

## Cubits

- Cubits manage **UI state** and are the only presentation component that calls use cases.
- Built with `flutter_bloc` (`Cubit<State>`).
- A cubit must **not** call datasources or repositories directly — only use cases.
- Each cubit has a dedicated state class in the same folder.
- Name: `<Feature>Cubit` / `<Feature>State` → files: `<feature>.cubit.dart` / `<feature>.state.dart` (e.g. `manga_list.cubit.dart` / `manga_list.state.dart`)

```dart
// State
abstract class MangaListState {}
class MangaListInitial extends MangaListState {}
class MangaListLoading extends MangaListState {}
class MangaListLoaded extends MangaListState {
  final List<MangaEntity> mangas;
  MangaListLoaded(this.mangas);
}
class MangaListError extends MangaListState {
  final AppException error;
  MangaListError(this.error);
}

// Cubit
class MangaListCubit extends Cubit<MangaListState> {
  final GetMangasUseCase _getMangas;

  MangaListCubit(this._getMangas) : super(MangaListInitial());

  Future<void> loadMangas() async {
    emit(MangaListLoading());
    try {
      final mangas = await _getMangas(NoParams());
      emit(MangaListLoaded(mangas));
    } on AppException catch (e) {
      emit(MangaListError(e));
    }
  }
}
```

### ❌ Forbidden in cubits
- Calling datasources or repositories directly
- Containing business logic (belongs in use cases)
- Navigation (use `RouterHelper` in pages)

---

## Pages

- A page is the **top-level screen** widget rendered by the router.
- Provided by the router (`GoRouter`) — no direct instantiation between pages.
- Pages are **stateless when possible**; use `BlocProvider` / `BlocBuilder` for state.
- All user-facing text must use `context.trad.<key>` (never hardcoded strings).
- Navigation must go through `RouterHelper` (never `context.go()` directly).
- File: `<page>.page.dart` (e.g. `manga_list.page.dart`, `manga_detail.page.dart`)

```dart
class MangaListPage extends StatelessWidget {
  const MangaListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MangaListCubit>()..loadMangas(),
      child: Scaffold(
        appBar: AppBar(title: Text(context.trad.home)),
        body: BlocBuilder<MangaListCubit, MangaListState>(
          builder: (context, state) {
            if (state is MangaListLoading) return const CircularProgressIndicator();
            if (state is MangaListLoaded) return _MangaList(state.mangas);
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
```

---

## Widgets

- A widget is an **atomic, reusable UI component** (button, text field, card, etc.).
- Widgets must **not** depend on cubits or use cases — they receive data and callbacks via constructor.
- Generic widgets (used across features) → `core/presentation/widgets/`
- Feature-specific widgets (only used within one feature) → `features/<name>/presentation/widgets/`
- All text via `context.trad.<key>`.

```dart
class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const AppButton({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
```

### ❌ Forbidden in widgets
- Calling use cases or cubits directly
- Navigation logic
- Hardcoded strings
