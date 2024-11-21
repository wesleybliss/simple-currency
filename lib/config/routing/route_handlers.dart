
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency/ui/screens/currencies/currencies_screen.dart';
import 'package:simple_currency/ui/screens/error/ErrorScreen.dart';
import 'package:simple_currency/ui/screens/home/home_screen.dart';
import 'package:simple_currency/ui/screens/settings/settings_screen.dart';

typedef ParamsHandler = Widget Function(Map<String, dynamic> params);

Widget _render(Widget child) => child;

/*Handler handlerFor(Widget child, [RouteWrapper wrapper = RouteWrapper.normal]) {
  return Handler(handlerFunc: (context, params) {
    return _render(child, wrapper);
  });
}

Handler paramsHandlerFor(ParamsHandler childFn, [RouteWrapper wrapper = RouteWrapper.normal]) {
  return Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    final child = childFn(params);
    return _render(child, wrapper);
  });
}*/

Handler handlerFor(Widget child) {
  return Handler(handlerFunc: (context, params) {
    return _render(child);
  });
}

Handler paramsHandlerFor(ParamsHandler childFn) {
  return Handler(handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    final child = childFn(params);
    return _render(child);
  });
}

final errorHandler = handlerFor(const ErrorScreen(message: '@todo Error'));
//final splashHandler = handlerFor(SplashScreen(), RouteWrapper.none);

final homeHandler = handlerFor(const HomeScreen());
final settingsHandler = handlerFor(const SettingsScreen());
final currenciesHandler = handlerFor(const CurrenciesScreen());
