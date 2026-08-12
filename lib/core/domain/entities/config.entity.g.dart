// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.entity.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ConfigEntityCWProxy {
  ConfigEntity flavor(FlavorEnum flavor);

  ConfigEntity appName(String appName);

  ConfigEntity appVersion(String appVersion);

  ConfigEntity isProd(bool isProd);

  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigEntity call({
    FlavorEnum flavor,
    String appName,
    String appVersion,
    bool isProd,
  });
}

/// Callable proxy for `copyWith` functionality.
/// Use as `instanceOfConfigEntity.copyWith(...)` or call `instanceOfConfigEntity.copyWith.fieldName(value)` for a single field.
class _$ConfigEntityCWProxyImpl implements _$ConfigEntityCWProxy {
  const _$ConfigEntityCWProxyImpl(this._value);

  final ConfigEntity _value;

  @override
  ConfigEntity flavor(FlavorEnum flavor) => call(flavor: flavor);

  @override
  ConfigEntity appName(String appName) => call(appName: appName);

  @override
  ConfigEntity appVersion(String appVersion) => call(appVersion: appVersion);

  @override
  ConfigEntity isProd(bool isProd) => call(isProd: isProd);

  @override
  /// Creates a new instance with the provided field values.
  /// Passing `null` to a nullable field nullifies it, while `null` for a non-nullable field is ignored. To update a single field use `ConfigEntity(...).copyWith.fieldName(value)`.
  ///
  /// Example:
  /// ```dart
  /// ConfigEntity(...).copyWith(id: 12, name: "My name")
  /// ```
  ConfigEntity call({
    Object? flavor = const $CopyWithPlaceholder(),
    Object? appName = const $CopyWithPlaceholder(),
    Object? appVersion = const $CopyWithPlaceholder(),
    Object? isProd = const $CopyWithPlaceholder(),
  }) {
    return ConfigEntity(
      flavor: flavor == const $CopyWithPlaceholder() || flavor == null
          ? _value.flavor
          // ignore: cast_nullable_to_non_nullable
          : flavor as FlavorEnum,
      appName: appName == const $CopyWithPlaceholder() || appName == null
          ? _value.appName
          // ignore: cast_nullable_to_non_nullable
          : appName as String,
      appVersion:
          appVersion == const $CopyWithPlaceholder() || appVersion == null
          ? _value.appVersion
          // ignore: cast_nullable_to_non_nullable
          : appVersion as String,
      isProd: isProd == const $CopyWithPlaceholder() || isProd == null
          ? _value.isProd
          // ignore: cast_nullable_to_non_nullable
          : isProd as bool,
    );
  }
}

extension $ConfigEntityCopyWith on ConfigEntity {
  /// Returns a callable class used to build a new instance with modified fields.
  /// Example: `instanceOfConfigEntity.copyWith(...)` or `instanceOfConfigEntity.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ConfigEntityCWProxy get copyWith => _$ConfigEntityCWProxyImpl(this);
}
