import 'package:flutter_test/flutter_test.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';

class _FakeUseCase extends UseCase<NoParam, String> {
  @override
  Future<String> call(NoParam param) => Future.value('result');
}

class _FailingUseCase extends UseCase<NoParam, String> {
  @override
  Future<String> call(NoParam param) => throw Exception('unexpected error');
}

class _AppExceptionUseCase extends UseCase<NoParam, String> {
  @override
  Future<String> call(NoParam param) =>
      throw AppException(type: ExceptionType.notFound);
}

class _VoidUseCase extends UseCase<NoParam, void> {
  @override
  Future<void> call(NoParam param) => Future.value();
}

void main() {
  group('UseCase.guard()', () {
    test('returns UseCaseSuccess when future completes normally', () async {
      final useCase = _FakeUseCase();
      final result = await useCase.guard(() => useCase(NoParam()));

      expect(result, isA<UseCaseSuccess<String>>());
      expect((result as UseCaseSuccess).data, 'result');
    });

    test('returns UseCaseFailure with unknown type on generic exception', () async {
      final useCase = _FailingUseCase();
      final result = await useCase.guard(() => useCase(NoParam()));

      expect(result, isA<UseCaseFailure<String>>());
      expect((result as UseCaseFailure).exception.type, ExceptionType.unknown);
    });

    test('preserves AppException type when thrown', () async {
      final useCase = _AppExceptionUseCase();
      final result = await useCase.guard(() => useCase(NoParam()));

      expect(result, isA<UseCaseFailure<String>>());
      expect((result as UseCaseFailure).exception.type, ExceptionType.notFound);
    });

    test('works correctly for void use cases', () async {
      final useCase = _VoidUseCase();
      final result = await useCase.guard(() => useCase(NoParam()));

      expect(result, isA<UseCaseSuccess<void>>());
    });
  });

  group('UseCaseResult pattern matching', () {
    test('switch exhaustiveness on sealed class compiles', () {
      final UseCaseResult<String> result = UseCaseSuccess('ok');

      final value = switch (result) {
        UseCaseSuccess(:final data) => data,
        UseCaseFailure(:final exception) => exception.type.name,
      };

      expect(value, 'ok');
    });
  });
}
