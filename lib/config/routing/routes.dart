
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency/config/routing/route_handlers.dart';
import 'package:simple_currency/domain/constants/routing.dart';
import 'package:simple_currency/utils/logger.dart';

class Routes {
  static final log = Logger('Routes');
  
  static const String home = '/';
  static const String settings = '/settings';
  static const String currencies = '/currencies';

  static Function defineDefault(FluroRouter router) =>
          (String routePath, Handler handler, [TransitionType transitionType = defaultTransition]) {
        log.i('Define route: $routePath');

        router.define(routePath, handler: handler, transitionType: transitionType);
      };

  static void configureRoutes(FluroRouter router) {
    Function define = defineDefault(router);

    router.notFoundHandler = Handler(handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      log.w('ROUTE NOT FOUND');
      // return loginHandler.handlerFunc(context, params);
      return errorHandler.handlerFunc(context, params);
    });

    define(home, homeHandler, TransitionType.fadeIn);
    define(settings, settingsHandler, TransitionType.fadeIn);
    define(currencies, currenciesHandler, TransitionType.fadeIn);
  }

}
