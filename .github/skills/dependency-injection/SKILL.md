---
name: dependency-injection
description: Rules for dependency injection using get_it and injectable in this app. Use when adding, modifying, or registering injectable classes, creating DI modules, or configuring the service locator.
---

## Stack

| Package | Role |
|---|---|
| `get_it` | Service locator — access registered instances via `getIt<T>()` |
| `injectable` | Annotation-driven code generation for `get_it` registrations |
| `injectable_generator` | Build runner generator (dev dependency) |

---

## Setup file

The `GetIt` instance and the generated `configureDependencies()` function live in:
```
lib/core/di/injection.dart
```

```dart
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart'; // generated

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => getIt.init();
```

Call `await configureDependencies()` before `runApp()` in `main.dart`.

---

## Annotations

Use the correct annotation based on the desired lifetime:

| Annotation | Lifetime | Use for |
|---|---|---|
| `@injectable` | New instance per injection | Use cases, cubits |
| `@lazySingleton` | Single instance, created on first access | Repositories, datasources |
| `@singleton` | Single instance, created at startup | Services that must initialize early |

### Use cases → `@injectable`
```dart
@injectable
class GetMangasUseCase implements UseCase<List<MangaEntity>, NoParams> {
  final MangaRepository _repository;
  const GetMangasUseCase(this._repository);
  // ...
}
```

### Repository implementation → `@LazySingleton` (binds interface)
```dart
@LazySingleton(as: MangaRepository)
class MangaRepositoryImpl implements MangaRepository {
  // ...
}
```

### Datasource implementation → `@lazySingleton`
```dart
@lazySingleton
class MangaRemoteDatasourceImpl implements MangaRemoteDatasource {
  // ...
}
```

### Cubit → `@injectable`
```dart
@injectable
class MangaListCubit extends Cubit<MangaListState> {
  final GetMangasUseCase _getMangas;
  MangaListCubit(this._getMangas) : super(MangaListInitial());
  // ...
}
```

---

## External dependencies (modules)

External objects that cannot be annotated (e.g. `FirebaseFirestore`, `SharedPreferences`) must be registered via a `@module` class:

```dart
@module
abstract class AppModule {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
```

Place modules in `lib/core/di/modules/`.

---

## Accessing instances

In pages, provide cubits via `BlocProvider` using `getIt`:
```dart
BlocProvider(
  create: (_) => getIt<MangaListCubit>(),
  child: const MangaListPage(),
)
```

Never call `getIt<T>()` inside widgets — only in `BlocProvider.create` or equivalent top-level providers.

---

## Regenerating after changes

Whenever you add, remove, or change an `@injectable` annotation, regenerate:

```bash
dart run build_runner build --delete-conflicting-outputs
```

The generated file is `lib/core/di/injection.config.dart` — **never edit it manually**.
