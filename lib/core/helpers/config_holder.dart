import '../data/datasources/flavor/flavor_native.datasource.dart';

class ConfigHolder {
  ConfigHolder._();

  static ConfigHolder? _instance;

  static ConfigHolder get instance {
    assert(_instance != null, 'ConfigHolder must be initialized before use. Call ConfigHolder.initialize() first.');
    return _instance!;
  }

  late final String flavor;
  late final String appName;
  late final bool isProd;

  static Future<void> initialize(FlavorNativeDatasource datasource) async {
    final holder = ConfigHolder._();
    holder.flavor = await datasource.getFlavor();
    holder.appName = await datasource.getAppName();
    holder.isProd = await datasource.isProd();
    _instance = holder;
  }
}
