import 'dart:async';

import 'package:mangatek_flutter/core/domain/app.exception.dart';

mixin RepositoryMixin {
  /// Runs [call] and maps any thrown exception to [AppException].
  Future<T> guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (error, stackTrace) {
      throw _handleError(error, stackTrace);
    }
  }

  /// Wraps [stream] and maps any error event to an [AppException].
  Stream<T> guardOnStream<T>(Stream<T> stream) async* {
    try {
      await for (final value in stream) {
        yield value;
      }
    } catch (error, stackTrace) {
      throw _handleError(error, stackTrace);
    }
  }

  AppException _handleError(dynamic error, StackTrace stackTrace) {
    // TODO: map datasource-specific exceptions (e.g. FirebaseException) to AppException types
    return AppException(type: ExceptionType.unknown, stackTrace: stackTrace);
  }
}
