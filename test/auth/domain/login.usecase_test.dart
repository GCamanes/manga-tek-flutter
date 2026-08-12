import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/login.usecase.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late _MockAuthRepository repository;
  late LoginUseCase useCase;

  const user = UserEntity(id: 'uid-1', email: 'test@test.com');
  const param = LoginParam(email: 'test@test.com', password: 'secret');

  setUp(() {
    repository = _MockAuthRepository();
    useCase = LoginUseCase(repository);
  });

  group('LoginUseCase', () {
    test('returns UseCaseSuccess with user on successful login', () async {
      when(() => repository.login(email: param.email, password: param.password))
          .thenAnswer((_) async => user);

      final result = await useCase(param);

      expect(result, isA<UseCaseSuccess<UserEntity>>());
      expect((result as UseCaseSuccess<UserEntity>).data, user);
    });

    test('returns UseCaseFailure with auth type on auth exception', () async {
      when(() => repository.login(email: param.email, password: param.password))
          .thenThrow(AppException(type: ExceptionType.auth));

      final result = await useCase(param);

      expect(result, isA<UseCaseFailure<UserEntity>>());
      expect((result as UseCaseFailure<UserEntity>).exception.type, ExceptionType.auth);
    });

    test('returns UseCaseFailure with unknown type on generic exception', () async {
      when(() => repository.login(email: param.email, password: param.password))
          .thenThrow(Exception('network error'));

      final result = await useCase(param);

      expect(result, isA<UseCaseFailure<UserEntity>>());
      expect((result as UseCaseFailure<UserEntity>).exception.type, ExceptionType.unknown);
    });
  });
}
