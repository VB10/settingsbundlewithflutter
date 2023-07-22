import 'package:pigeon/pigeon.dart';

enum IosAppEnvironment {
  dev,
  prod,
}

class IosAppData {
  final IosAppEnvironment type;

  IosAppData(this.type);
}

@HostApi()
abstract class ConfigHostApi {
  String? userToken();

  IosAppData? appEnvironment();
}
