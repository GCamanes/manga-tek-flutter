---
name: architecture-domain
description: Rules for the domain layer in this app. Use when creating or modifying domain entities, use cases, enums, or repository interfaces.
---

## File naming convention

Words in the concept part are joined with `_`. The type keyword is preceded by `.`:

```
<concept_words_with_underscore>.<type_keyword>.dart
```

| Type | Keyword | Example |
|---|---|---|
| Entity | `.entity` | `manga.entity.dart`, `manga_chapter.entity.dart` |
| Enum | `.enum` | `manga_status.enum.dart` |
| Repository (interface) | `.repository` | `manga.repository.dart` |
| Use case | `.usecase` | `get_mangas.usecase.dart`, `get_manga_by_id.usecase.dart` |

---

## Core principle

The domain layer is the **heart of the app**. It must:
- Depend only on pure Dart/Flutter — **no datasource, no framework, no external package dependencies**
- Never import anything from `data/` or `presentation/`
- Be independently testable

---

## Placement rules

| What | `core/` | `features/<name>/` |
|---|---|---|
| Generic/shared domain code | `core/domain/` | — |
| Feature-specific domain code | — | `features/<name>/domain/` |

---

## Entities

- An entity is a **pure Dart class** representing a domain concept.
- No JSON parsing, no Firebase types, no platform dependencies.
- Name: `<Concept>Entity` → file: `<concept>.entity.dart` (e.g. `manga.entity.dart`, `manga_chapter.entity.dart`)
- Must extend `Equatable` for value equality.
- Must be annotated with `@CopyWith()` for generated `copyWith`.
- Prefer immutable classes (`final` fields, `const` constructors).
- Run `dart run build_runner build` after adding or modifying entities.

```dart
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part '<concept>.entity.g.dart';

@CopyWith()
class MangaEntity extends Equatable {
  final String id;
  final String title;
  final MangaStatusEnum status;

  const MangaEntity({
    required this.id,
    required this.title,
    required this.status,
  });

  @override
  List<Object?> get props => [id, title, status];
}
```

Usage:
```dart
final updated = manga.copyWith(title: 'New Title');
final areEqual = manga1 == manga2; // uses Equatable value equality
```

---

## Enums

- Enums represent domain concepts used in entities or use cases.
- File: `<concept>.enum.dart` (e.g. `manga_status.enum.dart`)

```dart
enum MangaStatusEnum { ongoing, completed, hiatus }
```

---

## Repository interfaces

- A repository interface defines **what data operations are available** to use cases — not how they are implemented.
- Always `abstract class` — no implementation here.
- Name: `<Feature>Repository` → file: `<feature>.repository.dart` (e.g. `manga.repository.dart`)

```dart
abstract class MangaRepository {
  Future<List<MangaEntity>> getMangas();
  Future<MangaEntity> getMangaById(String id);
}
```

### ❌ Forbidden
- Concrete implementations (belong in `data/repositories/`)
- Any import from `data/` or `presentation/`

---

## Use cases

- A use case implements **one specific business action**.
- Must extend the `UseCase` interface (already defined in `core/domain/usecases/usecase.interface.dart`).
- Must only depend on **repository interfaces** — never on concrete implementations or datasources.
- Name: `<Action>UseCase` → file: `<action>.usecase.dart` (e.g. `get_mangas.usecase.dart`, `get_manga_by_id.usecase.dart`)

```dart
class GetMangasUseCase implements UseCase<List<MangaEntity>, NoParams> {
  final MangaRepository _repository;
  const GetMangasUseCase(this._repository);

  @override
  Future<List<MangaEntity>> call(NoParams params) => _repository.getMangas();
}
```

### ❌ Forbidden in use cases
- Calling datasources directly
- Importing anything from `data/` or `presentation/`
- Containing more than one business action per class

---

## SOLID principles

| Principle | Application |
|---|---|
| **S**ingle Responsibility | Each entity, use case, and repository interface has one reason to change |
| **O**pen/Closed | Extend via new use cases / repository methods — don't modify existing ones |
| **L**iskov Substitution | Repository impls must be fully substitutable for their interface |
| **I**nterface Segregation | Keep repository interfaces small and focused per feature |
| **D**ependency Inversion | Use cases depend on repository *interfaces*, not *implementations* |
