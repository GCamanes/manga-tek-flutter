---
name: architecture-presentation
description: Naming and placement rules for the presentation layer. Use when working on any presentation layer file — pages, cubits, states, or widgets.
---

## File naming

`<concept_words_with_underscore>.<type_keyword>.dart`

| Type | Keyword | Example |
|------|---------|---------|
| Page | `.page` | `item_list.page.dart` |
| Cubit | `.cubit` | `item_list.cubit.dart` |
| State | `.state` | `item_list.state.dart` |
| Widget | `.widget` | `item_card.widget.dart` |

---

## Placement

| What | Location |
|------|----------|
| Generic/reusable widgets | `core/presentation/widgets/` |
| Generic/shared cubits | `core/presentation/cubits/` |
| Feature page | `features/<name>/presentation/pages/` |
| Feature widget | `features/<name>/presentation/widgets/` |
| Feature cubit + state | `features/<name>/presentation/cubits/` |
