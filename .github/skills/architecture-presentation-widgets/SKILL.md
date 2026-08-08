---
name: architecture-presentation-widgets
description: Rules for reusable widgets in this app. Use when creating or modifying widgets.
---

## Rules

- Atomic, reusable UI component — receives data and callbacks via constructor
- Must **not** depend on cubits or use cases
- Must **not** contain navigation logic
- All text via `context.trad.<key>` — no hardcoded strings
- Generic (cross-feature) → `core/presentation/widgets/`
- Feature-specific → `features/<name>/presentation/widgets/`

## Pattern

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
