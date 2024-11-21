import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/ui/widgets/currencies_list.dart';
import 'package:simple_currency/utils/logger.dart';

class HomeReady extends ConsumerWidget {
  const HomeReady({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = Logger('HomeReady');
    final state = ref.watch(currenciesProvider);
    final selectedCurrencies = ref.watch(selectedCurrenciesProvider);

    log.d('HomeReady: ${state.currencies.length} total');
    log.d('HomeReady: ${selectedCurrencies.length} selected');
    
    void debugCheckStorage() async {
      final currencyBox = store.box<Currency>();
      final items = await currencyBox.getAllAsync();
      log.d('Currency items: ${items.length}');
      log.d('Selected Currencies: $selectedCurrencies');
    }
    
    void onFetchCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }

    void onClearCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }
    
    if (selectedCurrencies.isEmpty == true) {
      Column(children: [
          const Text('You don\'t have any currencies selected yet. \nAdd some by clicking the button below.'),
          ElevatedButton(
            onPressed: () => Application.router.navigateTo(context, '/currencies'),
            child: const Text('Manage Currencies'),
          ),
      ]);
    }
    
    return Column(children: [
      Text('todo - ${selectedCurrencies.length} selected'),
      Row(children: [
          ElevatedButton(
          onPressed: onFetchCurrenciesClick,
        child: const Text('Fetch Currencies'),
        ),
        ElevatedButton(
        onPressed: onClearCurrenciesClick,
        child: const Text('Clear Currencies'),
        ),
      ]),
      ElevatedButton(
        onPressed: debugCheckStorage,
        child: const Text('Debug Check Storage'),
      ),
      Expanded(
        child: CurrenciesList(currencies: state.currencies),
      )]);
  }
}
