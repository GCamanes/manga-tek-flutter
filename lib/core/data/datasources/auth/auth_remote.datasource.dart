import 'package:firebase_auth/firebase_auth.dart';

abstract interface class AuthRemoteDatasource {
  /// Returns the currently signed-in Firebase user, or null if none.
  Future<User?> getCurrentUser();

  /// Signs in with [email] and [password] and returns the Firebase user.
  Future<User> login({required String email, required String password});

  /// Signs out the current user.
  Future<void> logout();
}
