import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/core/presentation/cubits/base.state.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/logout.usecase.dart';
import 'package:mangatek_flutter/features/auth/presentation/cubits/logout.cubit.dart';

class _MockLogoutUseCase extends Mock implements LogoutUseCase {}

void main() {
  late _MockLogoutUseCase useCase;

  setUp(() => useCase = _MockLogoutUseCase());

  group('LogoutCubit', () {
    blocTest<LogoutCubit, BaseState<void>>(
      'emits loading then success on logout',
      build: () {
        when(() => useCase()).thenAnswer((_) async => const UseCaseSuccess(null));
        return LogoutCubit(useCase);
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        predicate<BaseState<void>>((s) => s.isLoading),
        predicate<BaseState<void>>((s) => s.when(
              onInitial: () => false,
              onLoading: () => false,
              onSuccess: (_) => true,
              onError: (_) => false,
            )),
      ],
    );

    blocTest<LogoutCubit, BaseState<void>>(
      'emits loading then error on failure',
      build: () {
        when(() => useCase()).thenAnswer(
          (_) async => UseCaseFailure(AppException(type: ExceptionType.unknown)),
        );
        return LogoutCubit(useCase);
      },
      act: (cubit) => cubit.logout(),
      expect: () => [
        predicate<BaseState<void>>((s) => s.isLoading),
        predicate<BaseState<void>>(
          (s) => s.maybe(onError: (e) => e.type == ExceptionType.unknown) ?? false,
        ),
      ],
    );
  });
}
