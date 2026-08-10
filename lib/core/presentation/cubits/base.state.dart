import 'package:mangatek_flutter/core/domain/app.exception.dart';

sealed class BaseState<T> {
  const BaseState();

  const factory BaseState.initial() = _BaseInitial<T>;

  const factory BaseState.loading() = _BaseLoading<T>;

  factory BaseState.success(T data) => _BaseSuccess<T>(data, DateTime.now());

  factory BaseState.error(AppException error) => _BaseError<T>(error, DateTime.now());

  bool get isInitial => this is _BaseInitial<T>;

  bool get isLoading => this is _BaseLoading<T>;

  T? get dataOrNull => switch (this) {
    _BaseSuccess(:final data) => data,
    _ => null,
  };

  R when<R>({
    required R Function() onInitial,
    required R Function() onLoading,
    required R Function(T data) onSuccess,
    required R Function(AppException error) onError,
  }) => switch (this) {
    _BaseInitial() => onInitial(),
    _BaseLoading() => onLoading(),
    _BaseSuccess(:final data) => onSuccess(data),
    _BaseError(:final error) => onError(error),
  };

  R? maybe<R>({
    R Function()? onInitial,
    R Function()? onLoading,
    R Function(T data)? onSuccess,
    R Function(AppException error)? onError,
  }) => switch (this) {
    _BaseInitial() => onInitial?.call(),
    _BaseLoading() => onLoading?.call(),
    _BaseSuccess(:final data) => onSuccess?.call(data),
    _BaseError(:final error) => onError?.call(error),
  };
}

final class _BaseInitial<T> extends BaseState<T> {
  const _BaseInitial();
}

final class _BaseLoading<T> extends BaseState<T> {
  const _BaseLoading();
}

final class _BaseSuccess<T> extends BaseState<T> {
  const _BaseSuccess(this.data, this.timestamp);

  final T data;
  final DateTime timestamp;
}

final class _BaseError<T> extends BaseState<T> {
  const _BaseError(this.error, this.timestamp);

  final AppException error;
  final DateTime timestamp;
}
