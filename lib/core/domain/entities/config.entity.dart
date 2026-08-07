import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

import '../enum/flavor.enum.dart';

part 'config.entity.g.dart';

@CopyWith()
class ConfigEntity extends Equatable {
  final FlavorEnum flavor;
  final String appName;
  final bool isProd;

  const ConfigEntity({this.flavor = FlavorEnum.dev, this.appName = '', this.isProd = false});

  @override
  List<Object?> get props => [flavor, appName, isProd];
}
