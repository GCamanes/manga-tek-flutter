---
name: navigation
description: Rules and patterns for go_router navigation in this app. Use when adding routes, navigation helpers, or modifying the router.
---

## Files — `lib/core/navigation/`

| File | Role |
|---|---|
| `app.routes.dart` | Route name and path string constants |
| `app.router.dart` | `GoRouter` instance with all `GoRoute` declarations |
| `router.helper.dart` | Static helper methods used by pages to navigate |

---

## Adding a route (all 3 files required)

**`app.routes.dart`**
```dart
static const exampleName = 'example';
static const example = '/example';
// with path param:
static const mangaName = 'manga';
static const manga = '/manga/:id';
```

**`app.router.dart`**
```dart
GoRoute(
  name: AppRoutes.exampleName,
  path: AppRoutes.example,
  builder: (context, state) => const ExamplePage(),
),
```

**`router.helper.dart`**
```dart
static void goToExample(BuildContext context) =>
    context.goNamed(AppRoutes.exampleName);

static void pushToManga(BuildContext context, String id) =>
    context.pushNamed(AppRoutes.mangaName, pathParameters: {'id': id});
```

---

## Navigation rules

Pages must never call navigation directly:

```dart
// ✅ correct
RouterHelper.goToExample(context);

// ❌ forbidden
context.go('/example');
context.goNamed('example');
```

---

## Navigation type

| Method | Stack behavior | Helper prefix |
|---|---|---|
| `context.goNamed(...)` | Replaces full stack | `goTo` |
| `context.pushNamed(...)` | Pushes on stack (back returns) | `pushTo` |
