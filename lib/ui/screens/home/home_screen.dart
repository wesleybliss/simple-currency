import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/ui/screens/home/home_error.dart';
import 'package:simple_currency/ui/screens/home/home_loading.dart';
import 'package:simple_currency/ui/screens/home/home_ready.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currenciesProvider);
    final tag = state.loading ? 'Loading' : state.error != null ? 'Error' : 'Ready';
    
    return Scaffold(
      appBar: AppBar(title: Text('${Constants.strings.appName} - Home $tag')),
      body: state.loading
          ? const HomeLoading()
          : state.error != null
            ? const HomeError()
            : const HomeReady(),
    );
  }
}
