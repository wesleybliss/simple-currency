import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/config/routing/routes.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/providers/state/settings_provider.dart';
import 'package:simple_currency/domain/di/providers/state/theme_provider.dart';

class SimpleCurrencyApp extends ConsumerWidget {
  SimpleCurrencyApp({super.key}) {
    if (Application.isInitialized) return;

    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  Widget buildApp(BuildContext context, ThemeMode themeMode) {
    return MaterialApp(
      title: Constants.strings.appName,
      theme: ThemeData(
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        colorSchemeSeed: const Color.fromRGBO(178, 239, 155, 171),
      ),
      // darkTheme: ThemeData.dark(),
      darkTheme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: const Color.fromRGBO(178, 239, 155, 171),
          brightness: Brightness.dark),
      themeMode: themeMode,
      initialRoute: Routes.home,
      onGenerateRoute: Application.router.generator,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final settingsAsyncValue = ref.watch(settingsNotifierProvider);

    return settingsAsyncValue.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
        data: (settings) {
          //settings.darkMode ? Brightness.dark : Brightness.light,
          return buildApp(context, themeMode);
        });
  }
}
