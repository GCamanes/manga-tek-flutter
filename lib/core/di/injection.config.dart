// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mangatek_flutter/core/data/datasources/auth/auth_remote.datasource.dart'
    as _i337;
import 'package:mangatek_flutter/core/data/datasources/auth/auth_remote.datasource_impl.dart'
    as _i598;
import 'package:mangatek_flutter/core/di/modules/firebase.module.dart' as _i23;
import 'package:mangatek_flutter/features/auth/data/repositories_impl/auth.repository_impl.dart'
    as _i423;
import 'package:mangatek_flutter/features/auth/domain/repositories/auth.repository.dart'
    as _i84;
import 'package:mangatek_flutter/features/auth/domain/usecases/get_current_user.usecase.dart'
    as _i9;
import 'package:mangatek_flutter/features/auth/domain/usecases/login.usecase.dart'
    as _i864;
import 'package:mangatek_flutter/features/auth/domain/usecases/logout.usecase.dart'
    as _i308;
import 'package:mangatek_flutter/features/auth/presentation/cubits/get_current_user.cubit.dart'
    as _i1014;
import 'package:mangatek_flutter/features/auth/presentation/cubits/login.cubit.dart'
    as _i223;
import 'package:mangatek_flutter/features/auth/presentation/cubits/logout.cubit.dart'
    as _i602;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final firebaseModule = _$FirebaseModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => firebaseModule.firebaseAuth);
    gh.lazySingleton<_i337.AuthRemoteDatasource>(
      () => _i598.AuthRemoteDatasourceImpl(gh<_i59.FirebaseAuth>()),
    );
    gh.lazySingleton<_i84.AuthRepository>(
      () => _i423.AuthRepositoryImpl(gh<_i337.AuthRemoteDatasource>()),
    );
    gh.factory<_i9.GetCurrentUserUseCase>(
      () => _i9.GetCurrentUserUseCase(gh<_i84.AuthRepository>()),
    );
    gh.factory<_i864.LoginUseCase>(
      () => _i864.LoginUseCase(gh<_i84.AuthRepository>()),
    );
    gh.factory<_i308.LogoutUseCase>(
      () => _i308.LogoutUseCase(gh<_i84.AuthRepository>()),
    );
    gh.factory<_i223.LoginCubit>(
      () => _i223.LoginCubit(gh<_i864.LoginUseCase>()),
    );
    gh.factory<_i602.LogoutCubit>(
      () => _i602.LogoutCubit(gh<_i308.LogoutUseCase>()),
    );
    gh.factory<_i1014.GetCurrentUserCubit>(
      () => _i1014.GetCurrentUserCubit(gh<_i9.GetCurrentUserUseCase>()),
    );
    return this;
  }
}

class _$FirebaseModule extends _i23.FirebaseModule {}
