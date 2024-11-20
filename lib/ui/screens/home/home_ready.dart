import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/store/SimpleCurrencyStore.dart';
import 'package:simple_currency/ui/widgets/currencies_list.dart';
import 'package:simple_currency/ui/widgets/currency_inputs_list.dart';
import 'package:simple_currency/utils/logger.dart';

class HomeReady extends ConsumerWidget {
  const HomeReady({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = Logger('HomeReady');
    final state = ref.watch(currenciesProvider);
    final selectedItems = ref.read(currenciesProvider.notifier).selectedCurrencies;
    
    void debugCheckStorage() async {
      final currencyBox = store.box<Currency>();
      final items = await currencyBox.getAllAsync();
      log.d('Currency items: ${items.length}');
      log.d('Selected Currencies: $selectedItems');
    }
    
    void onFetchCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }
    
    return Column(children: [
      Text('todo'),
      ElevatedButton(
        onPressed: onFetchCurrenciesClick,
        child: const Text('Fetch Currencies'),
      ),
      ElevatedButton(
        onPressed: debugCheckStorage,
        child: const Text('Debug Check Storage'),
      ),
      Expanded(
        child: CurrenciesList(currencies: state.currencies ?? []),
      )]);
  }
}
