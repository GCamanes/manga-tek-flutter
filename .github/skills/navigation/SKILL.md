---
name: navigation
description: Rules and patterns for go_router navigation in this app. Use when adding routes, navigation helpers, or modifying the router.
---

## Architecture

Navigation is centralized in `lib/core/navigation/` across three files:

| File | Role |
|---|---|
| `app.routes.dart` | Route name and path string constants |
| `app.router.dart` | `GoRouter` instance with all `GoRoute` declarations |
| `router.helper.dart` | Static helper methods used by pages to navigate |

---

## Rules

### 1. Every new route requires changes in all three files

**`app.routes.dart`** — add both a name constant and a path constant:
```dart
static const exampleName = 'example';
static const example = '/example';
```

For routes with path parameters:
```dart
static const mangaName = 'manga';
static const manga = '/manga/:id';
```

**`app.router.dart`** — add a `GoRoute` with `name:` set:
```dart
GoRoute(
  name: AppRoutes.exampleName,
  path: AppRoutes.example,
  builder: (context, state) => const ExamplePage(),
),
```

**`router.helper.dart`** — add a static method:
```dart
static void goToExample(BuildContext context) =>
    context.goNamed(AppRoutes.exampleName);
```

For parameterized routes:
```dart
static void goToManga(BuildContext context, String id) =>
    context.goNamed(AppRoutes.mangaName, pathParameters: {'id': id});
```

---

### 2. Pages must never call navigation directly

#### ✅ Correct
```dart
RouterHelper.goToExample(context);
```

#### ❌ Forbidden
```dart
context.go('/example');              // direct path — forbidden
context.goNamed('example');          // direct named call — forbidden
GoRouter.of(context).go('/example'); // forbidden
```

---

### 3. Always use named routes

Use `context.goNamed()` inside `RouterHelper` — never `context.go()`. Named routes are path-change-safe and work cleanly with path parameters.

---

### 4. Navigation type

Use the appropriate `GoRouter` method inside `RouterHelper` depending on the desired stack behavior:

| Method | Stack behavior | Helper naming |
|---|---|---|
| `context.goNamed(...)` | Replaces the full navigation stack | `goTo<Page>` |
| `context.pushNamed(...)` | Pushes on top of the current stack (back button returns) | `pushTo<Page>` |

**Rule:** When a route must be pushed **without clearing the navigation stack**, use `context.pushNamed()` inside `RouterHelper`. Name the method with the `pushTo` prefix to make the intent explicit at every call site.

#### Example — push without clearing stack
```dart
// router.helper.dart
static void pushToMangaDetail(BuildContext context, String id) =>
    context.pushNamed(AppRoutes.mangaDetailName, pathParameters: {'id': id});
```

```dart
// In a page
RouterHelper.pushToMangaDetail(context, manga.id); // back button returns to previous page
```

#### Example — replace stack
```dart
// router.helper.dart
static void goToHome(BuildContext context) =>
    context.goNamed(AppRoutes.homeName); // no back button — stack is cleared
```

The `goTo` / `pushTo` naming convention makes the stack behavior visible without needing to check the router implementation.
