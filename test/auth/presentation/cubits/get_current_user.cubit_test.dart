import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/core/presentation/cubits/base.state.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/get_current_user.usecase.dart';
import 'package:mangatek_flutter/features/auth/presentation/cubits/get_current_user.cubit.dart';

class _MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late _MockGetCurrentUserUseCase useCase;

  const user = UserEntity(id: 'uid-1', email: 'test@test.com');

  setUp(() => useCase = _MockGetCurrentUserUseCase());

  group('GetCurrentUserCubit', () {
    blocTest<GetCurrentUserCubit, BaseState<UserEntity>>(
      'emits loading then success when user exists',
      build: () {
        when(() => useCase()).thenAnswer((_) async => const UseCaseSuccess(user));
        return GetCurrentUserCubit(useCase);
      },
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>((s) => s.dataOrNull == user),
      ],
    );

    blocTest<GetCurrentUserCubit, BaseState<UserEntity>>(
      'emits loading then error with noUser when no user is signed in',
      build: () {
        when(() => useCase()).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.noUser)),
        );
        return GetCurrentUserCubit(useCase);
      },
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.noUser) ?? false,
        ),
      ],
    );

    blocTest<GetCurrentUserCubit, BaseState<UserEntity>>(
      'emits loading then error on unknown exception',
      build: () {
        when(() => useCase()).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.unknown)),
        );
        return GetCurrentUserCubit(useCase);
      },
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        predicate<BaseState<UserEntity>>((s) => s.isLoading),
        predicate<BaseState<UserEntity>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.unknown) ?? false,
        ),
      ],
    );
  });
}
