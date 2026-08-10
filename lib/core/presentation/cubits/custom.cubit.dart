import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/core/presentation/cubits/base.state.dart';

abstract class CustomCubit<T> extends Cubit<BaseState<T>> {
  CustomCubit() : super(const BaseState.initial());

  StreamSubscription<UseCaseResult<T>>? _streamSubscription;

  /// Guards every emit against emitting on a closed cubit.
  @override
  void emit(BaseState<T> state) {
    if (!isClosed) super.emit(state);
  }

  /// Runs a one-shot use case result, emitting loading then success or error.
  Future<void> execute(Future<UseCaseResult<T>> call) async {
    emit(const BaseState.loading());
    switch (await call) {
      case UseCaseSuccess(:final data):
        emit(BaseState.success(data));
      case UseCaseFailure(:final exception):
        emit(BaseState.error(exception));
    }
  }

  /// Listens to a stream use case, emitting loading then successive success or
  /// error states. Cancels any previously active subscription first.
  Future<void> watch(Stream<UseCaseResult<T>> stream) async {
    emit(const BaseState.loading());
    await _streamSubscription?.cancel();
    _streamSubscription = stream.listen(
      (result) => switch (result) {
        UseCaseSuccess(:final data) => emit(BaseState.success(data)),
        UseCaseFailure(:final exception) => emit(BaseState.error(exception)),
      },
      onError: (Object error, StackTrace stackTrace) => emit(
        BaseState.error(
          error is AppException
              ? error
              : AppException(
                  type: ExceptionType.unknown,
                  stackTrace: stackTrace,
                ),
        ),
      ),
    );
  }

  /// Resets the cubit to its initial state and cancels any active subscription.
  Future<void> reset() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    emit(const BaseState.initial());
  }

  @override
  Future<void> close() async {
    await _streamSubscription?.cancel();
    return super.close();
  }
}
