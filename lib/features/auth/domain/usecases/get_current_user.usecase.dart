import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';

@injectable
class GetCurrentUserUseCase extends UseCase<NoParam, UseCaseResult<UserEntity>> {
  GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<UseCaseResult<UserEntity>> call([NoParam? param]) => guard(() async {
    final user = await _repository.getCurrentUser();
    await Future.delayed(const Duration(seconds: 2));
    if (user == null) {
      throw AppException(type: ExceptionType.noUser);
    }
    return user;
  });
}
