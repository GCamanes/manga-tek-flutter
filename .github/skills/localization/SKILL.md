---
name: localization
description: Rules for adding and managing localized strings in this app. Use when adding new UI strings, modifying ARB files, running flutter gen-l10n, or working with translations.
---

## Stack

| File | Role |
|---|---|
| `assets/locales/en.arb` | English strings (template) |
| `assets/locales/fr.arb` | French strings |
| `lib/generated/i18n/app_localizations.dart` | Generated — never edit manually |
| `lib/core/extensions/build_context.extensions.dart` | `context.trad` shortcut |

---

## Accessing strings in code

Always use the `BuildContext` extension — never call `AppLocalizations` directly or hardcode strings:

```dart
// ✅ Correct
Text(context.trad.login)

// ❌ Forbidden — direct AppLocalizations call
Text(AppLocalizations.of(context)!.login)

// ❌ Forbidden — hardcoded string
Text('Login')
```

The `.trad` getter is defined in `lib/core/extensions/build_context.extensions.dart`:
```dart
extension BuildContextExtension on BuildContext {
  AppLocalizations get trad => AppLocalizations.of(this)!;
}
```

---

## Adding a new string

Follow all four steps every time:

### 1. Add to `assets/locales/en.arb`
```json
{
  "myNewKey": "My new string",
  "@myNewKey": { "description": "Description of when this string is used" }
}
```

### 2. Add to `assets/locales/fr.arb`
```json
{
  "myNewKey": "Ma nouvelle chaîne"
}
```

### 3. Regenerate
```bash
flutter gen-l10n
```

### 4. Use in code
```dart
context.trad.myNewKey
```

---

## Key naming convention

- Use **camelCase** keys (Dart identifier convention).
- Group related keys with a common prefix:

| Category | Prefix | Example |
|---|---|---|
| Actions | none | `login`, `logout`, `save` |
| Errors | `error` | `errorNetwork`, `errorCredentials` |
| Labels | none | `email`, `password`, `home` |

---

## ARB file rules

- `en.arb` is the **template** — it must always be the most complete file and include `@key` metadata entries.
- `fr.arb` does **not** need `@key` metadata entries — only the translations.
- Write strings with actual UTF-8 characters (é, è, à, …) — never `\uXXXX` escape sequences.
- All strings are plain text — no HTML, no platform-specific markup.

---

## Supported locales

| Code | Language |
|---|---|
| `en` | English |
| `fr` | French |

To add a new locale: create `assets/locales/<code>.arb`, then run `flutter gen-l10n`.
