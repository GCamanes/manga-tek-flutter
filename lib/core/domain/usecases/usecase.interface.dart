import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';

class NoParam {}

sealed class UseCaseResult<O> {
  const UseCaseResult();
}

final class UseCaseSuccess<O> extends UseCaseResult<O> {
  const UseCaseSuccess(this.data);

  final O data;
}

final class UseCaseFailure<O> extends UseCaseResult<O> {
  const UseCaseFailure(this.exception);

  final AppException exception;
}

abstract class UseCase<P, O> {
  FutureOr<O> call(P param);

  @mustCallSuper
  Future<UseCaseResult<Out>> guard<Out>(Future<Out> Function() future) async {
    try {
      return UseCaseSuccess(await future());
    } catch (error, stacktrace) {
      return UseCaseFailure(_handleError(error, stacktrace));
    }
  }
}

abstract class StreamUseCase<P, O> {
  Stream<O> call(P param);

  @mustCallSuper
  Stream<Out> guardOnStream<Out>(Stream<Out> stream) =>
      stream.handleError((dynamic err, StackTrace stacktrace) => throw _handleError(err, stacktrace));
}

AppException _handleError(dynamic error, StackTrace stacktrace) {
  if (error is AppException) {
    return error;
  }
  return AppException(type: ExceptionType.unknown, stackTrace: stacktrace);
}
