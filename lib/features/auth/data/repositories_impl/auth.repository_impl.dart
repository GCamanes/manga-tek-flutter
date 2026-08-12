import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/data/datasources/auth/auth_remote.datasource.dart';
import 'package:mangatek_flutter/core/data/repository.mixin.dart';
import 'package:mangatek_flutter/features/auth/data/mappers/user.mapper.dart';
import 'package:mangatek_flutter/features/auth/data/models/user.model.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl with RepositoryMixin implements AuthRepository {
  AuthRepositoryImpl(this._datasource);

  final AuthRemoteDatasource _datasource;

  @override
  Future<UserEntity?> getCurrentUser() => guard(() async {
        final user = await _datasource.getCurrentUser();
        if (user == null) return null;
        return const UserMapper().toEntity(UserModel.fromFirebaseUser(user));
      });

  @override
  Future<UserEntity> login({
    required String email,
    required String password,
  }) =>
      guard(() async {
        final user = await _datasource.login(email: email, password: password);
        return const UserMapper().toEntity(UserModel.fromFirebaseUser(user));
      });

  @override
  Future<void> logout() => guard(() => _datasource.logout());
}
