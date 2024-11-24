import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/spot.dart';
import 'package:simple_currency/domain/di/spot_module.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/utils/logger.dart';

/*import 'package:memento/di/spot.dart';
import 'package:memento/di/spot_module.dart';
import 'package:memento/domain/domain_barrel.dart';
import 'package:memento/domain/services/i_notification_service.dart';
import 'package:memento/io/memento_store.dart';
import 'package:memento/store/settings.dart';
import 'package:memento/utils/licenses.dart';
import 'package:memento/utils/logger.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';*/

class Application {
  static bool isInitialized = false;
  static late final FluroRouter router;
  static late final SharedPreferences prefs;

  static Future<void> initialize() async {
    // Force portrait mode
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Adjust logging output as needed while developing
    Logger.globalLevel = LogLevel.verbose;
    Logger.globalPrefix = Constants.strings.appSlug;
    Logger.globalUsePrint = true;

    // Annoyingly, this needs to come first, since many levels between
    // here & the splash screen already subscribe to the store, which
    // uses SP to determine if we should use/override dark mode
    //
    // Note: intentionally not setting `isInitialized` true here,
    // so the splash screen can continue loading the rest of the dependencies
    if (!isInitialized) {
      prefs = await SharedPreferences.getInstance();
    }
    // await Settings.initialize();

    // Let image caching be more verbose (useful when debugging network images)
    // CachedNetworkImage.logLevel = CacheManagerLogLevel.debug;

    // Register service locator dependencies
    Spot.logging = false;
    SpotModule.registerDependencies();

    // Initialize ObjectBox database
    await SimpleCurrencyStore.initializeStore();

    /*// Register Google Font licenses
    LicenseUtils.registerLicenses();

    // Initialize notifications service
    await spot<INotificationService>().initialize();

    // We can register a logger now that we've initialized
    final log = Logger('Application');
    final auth = spot<IAuth>();
  
    // Watch for auth changes and re-initialize the private GraphQL
    // instance, so it can add the correct auth header middleware
    auth.observableToken.addListener(() {
      log.i('** Auth listener re-initializing private GraphQL client, token = ${auth.token} **');
      // After auth changes, re-initialize both GraphQL clients
      // so they can properly send the X-Hasura-Id header
      spot<IPublicGraphQLInstance>().initialize();
      spot<IPrivateGraphQLInstance>().initialize();
    });*/
  }
}

