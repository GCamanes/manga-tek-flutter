import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/core/data/datasources/flavor/flavor.pigeon.g.dart',
    kotlinOut: 'android/app/src/main/kotlin/com/groupany/mangatek_flutter/pigeon/PigeonFlavor.g.kt',
    kotlinOptions: KotlinOptions(package: 'com.groupany.mangatek_flutter.pigeon'),
    swiftOut: 'ios/Runner/Pigeons/PigeonFlavor.g.swift',
    swiftOptions: SwiftOptions(),
    dartPackageName: 'pigeon_flavor_package',
  ),
)
@HostApi()
abstract class FlavorApi {
  String getFlavor();

  String getAppName();

  bool isProd();
}
