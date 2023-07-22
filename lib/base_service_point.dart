import 'package:flutter/material.dart';

import 'native_config_bridge.dart';

@immutable
final class BaseServicePoint {
  const BaseServicePoint._();
  static const String _firebaseUrl =
      'https://fluttertr-ead5c.firebaseio.com/api';

  static String baseUrl(IosAppEnvironment type) {
    switch (type) {
      case IosAppEnvironment.dev:
        return '$_firebaseUrl/dev';
      case IosAppEnvironment.prod:
        return '$_firebaseUrl/prod';
    }
  }
}
