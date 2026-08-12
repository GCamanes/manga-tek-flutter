import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:mangatek_flutter/core/data/datasources/auth/auth_remote.datasource.dart';

@LazySingleton(as: AuthRemoteDatasource)
class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  const AuthRemoteDatasourceImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;

  @override
  Future<User> login({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  @override
  Future<void> logout() => _firebaseAuth.signOut();
}
