abstract class FlavorNativeDatasource {
  Future<String> getFlavor();

  Future<String> getAppName();

  Future<bool> isProd();
}
