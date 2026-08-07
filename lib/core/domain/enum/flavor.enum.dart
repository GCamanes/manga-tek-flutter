enum FlavorEnum {
  dev,
  prod;

  static FlavorEnum fromString(String str) => switch (str) {
        'dev' => FlavorEnum.dev,
        'prod' => FlavorEnum.prod,
        _ => throw UnimplementedError('$str is not a valid flavor'),
      };
}
