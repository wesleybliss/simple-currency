import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/ui/screens/currencies/currencies_screen.dart';
import 'package:simple_currency/ui/screens/debug/debug_screen.dart';
import 'package:simple_currency/ui/screens/error/ErrorScreen.dart';
import 'package:simple_currency/ui/screens/home/home_screen.dart';
import 'package:simple_currency/ui/screens/settings/settings_screen.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';

typedef ParamsHandler = Widget Function(Map<String, dynamic> params);

Widget _render(Widget child, String title, {withScaffold = true}) => withScaffold
    ? Scaffold(
        appBar: Toolbar(title: title),
        body: child,
      )
    : child;

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

Handler handlerFor(Widget child, String title, {withScaffold = true}) {
  return Handler(handlerFunc: (context, params) {
    return _render(child, title, withScaffold: withScaffold);
  });
}

Handler paramsHandlerFor(ParamsHandler childFn, String title, {withScaffold = true}) {
  return Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    final child = childFn(params);
    return _render(child, title, withScaffold: withScaffold);
  });
}

final errorHandler = handlerFor(const ErrorScreen(message: '@todo Error'), Constants.strings.appName);
//final splashHandler = handlerFor(SplashScreen(), RouteWrapper.none);

final debugHandler = handlerFor(const DebugScreen(), "Debug");

final homeHandler = handlerFor(const HomeScreen(), Constants.strings.appName);
final settingsHandler = handlerFor(const SettingsScreen(), "Settings");
final currenciesHandler = handlerFor(const CurrenciesScreen(), "Currencies");
