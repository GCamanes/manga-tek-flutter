import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';

abstract interface class AuthRepository {
  /// Returns the currently signed-in user, or null if none.
  Future<UserEntity?> getCurrentUser();

  /// Signs in with [email] and [password].
  Future<UserEntity> login({required String email, required String password});

  /// Signs out the current user.
  Future<void> logout();
}
