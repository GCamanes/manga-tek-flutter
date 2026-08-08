---
name: localization
description: Rules for adding and managing localized strings in this app. Use when adding new UI strings, modifying ARB files, running flutter gen-l10n, or working with translations.
---

## Files

| File | Role |
|---|---|
| `assets/locales/en.arb` | English strings — template, must be most complete |
| `assets/locales/fr.arb` | French strings — no `@key` metadata needed |
| `lib/generated/i18n/app_localizations.dart` | Generated — **never edit** |
| `lib/core/extensions/build_context.extensions.dart` | `context.trad` shortcut |

---

## Accessing strings

```dart
// ✅ correct
Text(context.trad.login)

// ❌ forbidden — direct call
Text(AppLocalizations.of(context)!.login)

// ❌ forbidden — hardcoded
Text('Login')
```

---

## Adding a string (checklist)

| Step | File | Action |
|------|------|--------|
| 1 | `en.arb` | `"myKey": "My string", "@myKey": { "description": "..." }` |
| 2 | `fr.arb` | `"myKey": "Ma chaîne"` |
| 3 | terminal | `flutter gen-l10n` |
| 4 | code | `context.trad.myKey` |

---

## Key naming

- camelCase keys (Dart identifier convention)

| Category | Prefix | Example |
|---|---|---|
| Actions | none | `login`, `save` |
| Errors | `error` | `errorNetwork` |
| Labels | none | `email`, `home` |

---

## ARB rules

- Strings use actual UTF-8 characters (é, è, à) — no `\uXXXX` escapes
- No HTML or platform markup in string values

---

## Supported locales

| Code | Language |
|---|---|
| `en` | English |
| `fr` | French |

To add a locale: create `assets/locales/<code>.arb`, run `flutter gen-l10n`.
