class ConstantsStrings {
  final appName = 'Simple Currency';
  final appSlug = 'simple-currency';

  String get baseUrl {
    String base;

    // Use const bool.fromEnvironment to check build mode
    const bool isProduction = bool.fromEnvironment('dart.vm.product');

    if (isProduction) {
      base = 'https://myprodserver.com/api';
    } else {
      base = 'http://localhost:3001/api';
    }
    return base;
  }
}
