import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/presentation/cubits/custom.cubit.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/login.usecase.dart';

@injectable
class LoginCubit extends CustomCubit<UserEntity> {
  LoginCubit(this._useCase);

  final LoginUseCase _useCase;

  Future<void> login({required String email, required String password}) =>
      execute(_useCase(LoginParam(email: email, password: password)));
}
