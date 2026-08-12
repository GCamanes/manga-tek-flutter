import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/presentation/cubits/custom.cubit.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/usecases/get_current_user.usecase.dart';

@injectable
class GetCurrentUserCubit extends CustomCubit<UserEntity> {
  GetCurrentUserCubit(this._useCase);

  final GetCurrentUserUseCase _useCase;

  Future<void> getCurrentUser() => execute(_useCase());
}
