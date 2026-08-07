import 'package:flutter/material.dart';

import '../data/datasources/flavor/flavor.pigeon.g.dart';
import '../domain/entities/config.entity.dart';
import '../domain/enum/flavor.enum.dart';

abstract class ConfigHolderBase {
  @protected
  ConfigEntity currentConfig = const ConfigEntity();
}

class ConfigHolder extends ConfigHolderBase {
  factory ConfigHolder() => _instance;

  ConfigHolder._default();

  static final ConfigHolder _instance = ConfigHolder._default();

  static Future<void> initialize() async {
    final FlavorApi flavorApi = FlavorApi();
    _instance.currentConfig = ConfigEntity(
      flavor: FlavorEnum.fromString(await flavorApi.getFlavor()),
      appName: await flavorApi.getAppName(),
      isProd: await flavorApi.isProd(),
    );
  }

  static FlavorEnum get flavor => _instance.currentConfig.flavor;
  static bool get isProd => _instance.currentConfig.isProd;
  static String get appName => _instance.currentConfig.appName;
}
