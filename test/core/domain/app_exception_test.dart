import 'package:flutter_test/flutter_test.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';

void main() {
  group('ExceptionType', () {
    test('contains all expected values', () {
      expect(
        ExceptionType.values.map((e) => e.name),
        containsAll(['auth', 'noConnection', 'notFound', 'timeOut', 'unknown']),
      );
    });
  });

  group('AppException', () {
    test('toString includes type name and stackTrace', () {
      final stackTrace = StackTrace.fromString('trace details');
      final exception = AppException(
        type: ExceptionType.notFound,
        stackTrace: stackTrace,
      );
      expect(exception.toString(), '[notFound] $stackTrace');
    });

    test('toString works with null stackTrace', () {
      final exception = AppException(type: ExceptionType.unknown);
      expect(exception.toString(), '[unknown] null');
    });

    test('implements Exception', () {
      final exception = AppException(type: ExceptionType.auth);
      expect(exception, isA<Exception>());
    });

    for (final type in ExceptionType.values) {
      test('can be created with type \${type.name}', () {
        final exception = AppException(type: type);
        expect(exception.type, type);
      });
    }
  });
}
