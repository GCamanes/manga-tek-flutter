import 'flavor.pigeon.g.dart';
import 'flavor_native.datasource.dart';

class FlavorNativeDatasourceImpl implements FlavorNativeDatasource {
  final FlavorApi _flavorApi;

  const FlavorNativeDatasourceImpl(this._flavorApi);

  @override
  Future<String> getFlavor() => _flavorApi.getFlavor();

  @override
  Future<String> getAppName() => _flavorApi.getAppName();

  @override
  Future<bool> isProd() => _flavorApi.isProd();
}
