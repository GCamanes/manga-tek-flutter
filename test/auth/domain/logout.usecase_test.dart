import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/logout.usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late LogoutUseCase useCase;

  setUp(() {
    repository = _MockAuthRepository();
    useCase = LogoutUseCase(repository);
  });

  group('LogoutUseCase', () {
    test('returns UseCaseSuccess on successful logout', () async {
      when(() => repository.logout()).thenAnswer((_) async {});

      final result = await useCase();

      expect(result, isA<UseCaseSuccess<void>>());
    });

    test('returns UseCaseFailure on repository exception', () async {
      when(() => repository.logout())
          .thenThrow(AppException(type: ExceptionType.unknown));

      final result = await useCase();

      expect(result, isA<UseCaseFailure<void>>());
    });
  });
}
