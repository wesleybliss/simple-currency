import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/config/routing/routes.dart';
import 'package:simple_currency/domain/constants/constants.dart';

class SimpleCurrencyApp extends StatefulWidget {
  
  SimpleCurrencyApp({super.key}) {
    
    if (Application.isInitialized) return;
    
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

  }

  @override
  State<SimpleCurrencyApp> createState() => SimpleCurrencyAppState();
  
}

class SimpleCurrencyAppState extends State<SimpleCurrencyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.strings.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: Application.router.generator,
    );
  }
}
