import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/presentation/cubits/custom.cubit.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/logout.usecase.dart';

@injectable
class LogoutCubit extends CustomCubit<void> {
  LogoutCubit(this._useCase);

  final LogoutUseCase _useCase;

  Future<void> logout() => execute(_useCase());
}
