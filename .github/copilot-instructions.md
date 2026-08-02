# Copilot Instructions — mangatek_flutter

## Language

**All code must be written in English.** This includes:

- Variable names, method names, class names, and parameter names
- Comments and documentation (inline comments, doc comments)
- String literals and error messages
- Commit messages and PR descriptions
- Any text written as part of the codebase

Do not use French or any other language anywhere in the code.

## Git Rules

### ❌ Forbidden

- **Never run `git commit`**, in any form (including `git commit --amend`, `git commit --fixup`, etc.)
- **Never run `git push`**, in any form (including `git push --force`, `git push origin`, etc.)

### ✅ Allowed

- `git add` is allowed to **stage** newly created files or modifications.

## Localization

All user-facing strings must be accessed via the `BuildContext` extension defined in `lib/core/extensions/build_context.extensions.dart`:

```dart
context.trad.<key>
```

The `.trad` getter wraps `AppLocalizations.of(context)!` for convenience.

### ✅ Correct

```dart
Text(context.trad.login)
```

### ❌ Forbidden

```dart
Text('Login')                             // hardcoded string
Text(AppLocalizations.of(context)!.login) // use context.trad instead
```

### Adding new strings

1. Add the key/value to **both** `assets/locales/en.arb` and `assets/locales/fr.arb`
2. Run `fvm flutter gen-l10n` to regenerate `lib/generated/i18n/`
3. Use the new key via `context.trad.<key>`

