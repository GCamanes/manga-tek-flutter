import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/core/presentation/cubits/base.state.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/login.usecase.dart';
import 'package:mangatek_flutter/features/auth/presentation/cubits/login.cubit.dart';

class _MockLoginUseCase extends Mock implements LoginUseCase {}

void main() {
  late _MockLoginUseCase useCase;

  const user = UserEntity(id: 'uid-1', email: 'test@test.com');
  const param = LoginParam(email: 'test@test.com', password: 'secret');

  setUp(() {
    useCase = _MockLoginUseCase();
    registerFallbackValue(param);
  });

  group('LoginCubit', () {
    blocTest<LoginCubit, BaseState<UserEntity>>(
      'emits loading then success on valid credentials',
      build: () {
        when(() => useCase(param)).thenAnswer((_) async => const UseCaseSuccess(user));
        return LoginCubit(useCase);
      },
      act: (cubit) => cubit.login(email: param.email, password: param.password),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>((s) => s.dataOrNull == user),
      ],
    );

    blocTest<LoginCubit, BaseState<UserEntity>>(
      'emits loading then error with auth type on wrong credentials',
      build: () {
        when(() => useCase(any())).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.auth)),
        );
        return LoginCubit(useCase);
      },
      act: (cubit) => cubit.login(email: param.email, password: 'wrong'),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.auth) ?? false,
        ),
      ],
    );

    blocTest<LoginCubit, BaseState<UserEntity>>(
      'emits loading then error with unknown type on generic failure',
      build: () {
        when(() => useCase(any())).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.unknown)),
        );
        return LoginCubit(useCase);
      },
      act: (cubit) => cubit.login(email: param.email, password: param.password),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.unknown) ?? false,
        ),
      ],
    );
  });
}
