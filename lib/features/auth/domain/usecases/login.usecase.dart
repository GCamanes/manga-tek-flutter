import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/domain/usecases/usecase.interface.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';

class LoginParam extends Equatable {
  const LoginParam({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}

@injectable
class LoginUseCase extends UseCase<LoginParam, UseCaseResult<UserEntity>> {
  LoginUseCase(this._repository);

  final AuthRepository _repository;

  @override
  Future<UseCaseResult<UserEntity>> call(LoginParam param) => guard(() async {
    await Future.delayed(const Duration(seconds: 2));
    return _repository.login(email: param.email, password: param.password);
  });
}
