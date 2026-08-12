import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';

mixin RepositoryMixin {
  /// Runs [call] and maps any thrown exception to [AppException].
  Future<T> guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } catch (error, stackTrace) {
      throw _mapError(error, stackTrace);
    }
  }

  /// Wraps [stream] and maps any error event to an [AppException].
  Stream<T> guardOnStream<T>(Stream<T> stream) async* {
    try {
      await for (final value in stream) {
        yield value;
      }
    } catch (error, stackTrace) {
      throw _mapError(error, stackTrace);
    }
  }

  AppException _mapError(dynamic error, StackTrace stackTrace) {
    if (error is AppException) return error;
    if (error is FirebaseAuthException) {
      return AppException(type: ExceptionType.auth, stackTrace: stackTrace);
    }
    return AppException(type: ExceptionType.unknown, stackTrace: stackTrace);
  }
}
