---
name: architecture-presentation
description: Naming and placement rules for the presentation layer. Use when working on any presentation layer file — pages, cubits, or widgets.
---

## Rules

- Must only depend on the domain layer — never import from `data/`
- Never use hardcoded numeric UI values (padding, radius, heights) — always use `context.constantsTheme`
- Never use hardcoded colors — always use `context.colorTheme`

## Theme extensions (via `BuildContext`)

```dart
final colors = context.colorTheme;       // ColorTheme — colors
final constants = context.constantsTheme; // ConstantsTheme — dimensions
```

## File naming

`<concept_words_with_underscore>.<type_keyword>.dart`

| Type | Keyword | Example |
|------|---------|---------|
| Page | `.page` | `item_list.page.dart` |
| Cubit | `.cubit` | `item_list.cubit.dart` |
| Widget | `.widget` | `item_card.widget.dart` |

---

## Placement

| What | Location |
|------|----------|
| Generic/reusable widgets | `core/presentation/widgets/` |
| Generic/shared cubits | `core/presentation/cubits/` |
| Feature page | `features/<name>/presentation/pages/` |
| Feature widget | `features/<name>/presentation/widgets/` |
| Feature cubit | `features/<name>/presentation/cubits/` |
