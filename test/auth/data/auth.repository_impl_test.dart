import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mangatek_flutter/core/data/datasources/auth/auth_remote.datasource.dart';
import 'package:mangatek_flutter/core/domain/app.exception.dart';
import 'package:mangatek_flutter/features/auth/data/repositories_impl/auth.repository_impl.dart';
import 'package:mangatek_flutter/features/auth/domain/entities/user.entity.dart';

class _MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

class _MockFirebaseUser extends Mock implements User {}

void main() {
  late _MockAuthRemoteDatasource datasource;
  late AuthRepositoryImpl repository;
  late _MockFirebaseUser firebaseUser;

  setUp(() {
    datasource = _MockAuthRemoteDatasource();
    repository = AuthRepositoryImpl(datasource);
    firebaseUser = _MockFirebaseUser();
    when(() => firebaseUser.uid).thenReturn('uid-1');
    when(() => firebaseUser.email).thenReturn('test@test.com');
  });

  group('AuthRepositoryImpl.getCurrentUser', () {
    test('returns mapped UserEntity when datasource returns a user', () async {
      when(() => datasource.getCurrentUser()).thenAnswer((_) async => firebaseUser);

      final result = await repository.getCurrentUser();

      expect(result, const UserEntity(id: 'uid-1', email: 'test@test.com'));
    });

    test('returns null when datasource returns null', () async {
      when(() => datasource.getCurrentUser()).thenAnswer((_) async => null);

      final result = await repository.getCurrentUser();

      expect(result, isNull);
    });

    test('throws AppException with auth type on FirebaseAuthException', () async {
      when(() => datasource.getCurrentUser())
          .thenThrow(FirebaseAuthException(code: 'user-not-found'));

      expect(
        () => repository.getCurrentUser(),
        throwsA(isA<AppException>().having((e) => e.type, 'type', ExceptionType.auth)),
      );
    });

    test('throws AppException with unknown type on generic exception', () async {
      when(() => datasource.getCurrentUser()).thenThrow(Exception('network'));

      expect(
        () => repository.getCurrentUser(),
        throwsA(isA<AppException>().having((e) => e.type, 'type', ExceptionType.unknown)),
      );
    });
  });

  group('AuthRepositoryImpl.login', () {
    test('returns mapped UserEntity on successful login', () async {
      when(() => datasource.login(email: 'test@test.com', password: 'secret'))
          .thenAnswer((_) async => firebaseUser);

      final result = await repository.login(email: 'test@test.com', password: 'secret');

      expect(result, const UserEntity(id: 'uid-1', email: 'test@test.com'));
    });

    test('throws AppException with auth type on FirebaseAuthException', () async {
      when(() => datasource.login(email: any(named: 'email'), password: any(named: 'password')))
          .thenThrow(FirebaseAuthException(code: 'wrong-password'));

      expect(
        () => repository.login(email: 'test@test.com', password: 'wrong'),
        throwsA(isA<AppException>().having((e) => e.type, 'type', ExceptionType.auth)),
      );
    });

    test('throws AppException with unknown type on generic exception', () async {
      when(() => datasource.login(email: any(named: 'email'), password: any(named: 'password')))
          .thenThrow(Exception('network'));

      expect(
        () => repository.login(email: 'test@test.com', password: 'secret'),
        throwsA(isA<AppException>().having((e) => e.type, 'type', ExceptionType.unknown)),
      );
    });
  });

  group('AuthRepositoryImpl.logout', () {
    test('completes without error', () async {
      when(() => datasource.logout()).thenAnswer((_) async {});

      await expectLater(repository.logout(), completes);
    });

    test('throws AppException on datasource failure', () async {
      when(() => datasource.logout()).thenThrow(Exception('error'));

      expect(
        () => repository.logout(),
        throwsA(isA<AppException>()),
      );
    });
  });
}
