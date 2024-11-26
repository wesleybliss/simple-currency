import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/ui/screens/home/home_error.dart';
import 'package:simple_currency/ui/screens/home/home_loading.dart';
import 'package:simple_currency/ui/screens/home/home_ready.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';
import 'package:simple_currency/utils/logger.dart';
import 'package:simple_currency/utils/utils.dart';

class DebugScreen extends ConsumerStatefulWidget {
  const DebugScreen({super.key});

  @override
  ConsumerState<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends ConsumerState<DebugScreen> {
  
  final log = Logger('DebugScreen');
  
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(currenciesProvider);
    final selectedCurrencies = ref.watch(selectedCurrenciesProvider);

    void debugCheckStorage() async {
      final currencyBox = store.box<Currency>();
      final items = await currencyBox.getAllAsync();
      log.d('Currency items: ${items.length}');
      log.d('Selected Currencies: $selectedCurrencies');
    }

    void debugAutoSelectDefaults() async {
      final currencyBox = store.box<Currency>();
      final items = await currencyBox.getAllAsync();
      final symbols = ['USD', 'COP', 'MXN'];

      for (var symbol in symbols) {
        final it = items.firstWhereOrNull((e) => e.symbol == symbol);
        if (it != null) {
          currencyBox.put(it.copyWith(selected: true));
        } else {
          log.e('Symbol not found: $symbol');
        }
      }
      
      ref.read(currenciesProvider.notifier).readCurrencies();
    }

    void debugReportStatus() async {
      log.d('HomeReady: ${state.currencies.length} total');
      log.d('HomeReady: ${selectedCurrencies.length} selected');
    }

    void onFetchCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }

    void onClearCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }

    final debugButton = ElevatedButton(
      onPressed: debugCheckStorage,
      child: Text('Debug Check Storage: ${state.currencies.length}'),
    );

    return Scaffold(
        appBar: Toolbar(title: Constants.strings.appName),
        body: Center(child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          TextButton(
            onPressed: () => Application.router.navigateTo(context, '/currencies'),
            child: const Text('Manage Currencies'),
          ),
          TextButton(
            onPressed: onFetchCurrenciesClick,
            child: const Text('Fetch Currencies'),
          ),
          ElevatedButton(
            onPressed: debugCheckStorage,
            child: Text('Debug Check Storage: ${state.currencies.length}'),
          ),
          ElevatedButton(
            onPressed: onClearCurrenciesClick,
            child: const Text('Clear Currencies'),
          ),
          ElevatedButton(
            onPressed: debugAutoSelectDefaults,
            child: const Text('Debug auto select defaults'),
          ),
          ElevatedButton(
            onPressed: debugReportStatus,
            child: const Text('Debug report status'),
          ),
    ])));
  }
}
