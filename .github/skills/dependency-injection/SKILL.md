---
name: dependency-injection
description: Rules for dependency injection using get_it and injectable in this app. Use when adding, modifying, or registering injectable classes, creating DI modules, or configuring the service locator.
---

## Stack

| Package | Role |
|---|---|
| `get_it` | Service locator — `getIt<T>()` |
| `injectable` | Annotation-driven codegen for registrations |
| `injectable_generator` | Build runner generator (dev dependency) |

---

## Setup file — `lib/core/di/injection.dart`

```dart
final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
```

Call `await configureDependencies()` before `runApp()` in `main.dart`.

---

## Annotations

| Annotation | Lifetime | Use for |
|---|---|---|
| `@injectable` | New instance per injection | Use cases |
| `@lazySingleton` | Single instance, lazy | Datasources |
| `@LazySingleton(as: T)` | Single instance, binds interface | Repository impls |
| `@singleton` | Single instance, eager | Early-init services |

```dart
@injectable
class GetMangasUseCase implements UseCase<List<MangaEntity>, NoParams> { ... }

@LazySingleton(as: MangaRepository)
class MangaRepositoryImpl implements MangaRepository { ... }

@lazySingleton
class MangaRemoteDatasourceImpl implements MangaRemoteDatasource { ... }
```

---

## External dependencies (modules)

Place in `lib/core/di/modules/`. Use `@module` for objects that can't be annotated:

```dart
@module
abstract class AppModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
```

---

## Regenerating

```bash
dart run build_runner build --delete-conflicting-outputs
```

Generated file: `lib/core/di/injection.config.dart` — **never edit manually**.
