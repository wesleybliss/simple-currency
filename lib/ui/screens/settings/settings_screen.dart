import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(title: Constants.strings.appName),
      body: Column(
        children: [
          Text('todo'),
          ElevatedButton(
            onPressed: () {
              // Handle settings action
              print('Settings pressed');
              Application.router.navigateTo(context, '/currencies');
            },
            child: const Text('Currencies'),
          ),
        ],
      ),
    );
  }
}
