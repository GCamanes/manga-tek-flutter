import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';

@injectable
class LogoutUseCase extends UseCase<NoParam, UseCaseResult<void>> {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<UseCaseResult<void>> call([NoParam? param]) =>
      guard(() => _repository.logout());
}
