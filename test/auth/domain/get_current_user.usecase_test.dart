import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/get_current_user.usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late GetCurrentUserUseCase useCase;

  const user = UserEntity(id: 'uid-1', email: 'test@test.com');

  setUp(() {
    repository = _MockAuthRepository();
    useCase = GetCurrentUserUseCase(repository);
  });

  group('GetCurrentUserUseCase', () {
    test('returns UseCaseSuccess with user when repository returns a user', () async {
      when(() => repository.getCurrentUser()).thenAnswer((_) async => user);

      final result = await useCase();

      expect(result, isA<UseCaseSuccess<UserEntity>>());
      expect((result as UseCaseSuccess<UserEntity>).data, user);
    });

    test('returns UseCaseFailure with noUser when repository returns null', () async {
      when(() => repository.getCurrentUser()).thenAnswer((_) async => null);

      final result = await useCase();

      expect(result, isA<UseCaseFailure<UserEntity>>());
      expect((result as UseCaseFailure<UserEntity>).exception.type, ExceptionType.noUser);
    });

    test('returns UseCaseFailure on repository exception', () async {
      when(() => repository.getCurrentUser())
          .thenThrow(AppException(type: ExceptionType.unknown));

      final result = await useCase();

      expect(result, isA<UseCaseFailure<UserEntity>>());
    });
  });
}
