import 'package:flutter/foundation.dart';

const String stagingBaseUrl = '';

const String productionBaseUrl = '';

enum Environment { staging, production }

class AppConfig {
  static Environment get environment {
    return kReleaseMode ? Environment.production : Environment.staging;
  }

  static String get baseUrl {
    return environment == Environment.staging
        ? stagingBaseUrl
        : productionBaseUrl;
  }
}
