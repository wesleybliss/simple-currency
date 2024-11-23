import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/ui/screens/home/home_error.dart';
import 'package:simple_currency/ui/screens/home/home_loading.dart';
import 'package:simple_currency/ui/screens/home/home_ready.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the fetchCurrencies method when the screen loads
    ref.read(currenciesProvider.notifier).fetchCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currenciesProvider);

    return Scaffold(
        appBar: Toolbar(title: Constants.strings.appName),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(currenciesProvider.notifier).fetchCurrencies();
          },
          child: state.loading
              ? const HomeLoading()
              : state.error != null
                  ? const HomeError()
                  : const HomeReady(),
        ));
  }
}
