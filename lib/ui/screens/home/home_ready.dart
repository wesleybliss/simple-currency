import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/ui/widgets/currency_inputs_list.dart';

class HomeReady extends ConsumerWidget {
  const HomeReady({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(currenciesProvider);

    void onFetchCurrenciesClick() {
      ref.read(currenciesProvider.notifier).fetchCurrencies();
    }
    
    return Column(children: [
      Text('todo'),
      ElevatedButton(
        onPressed: onFetchCurrenciesClick,
        child: const Text('Fetch Currencies'),
      ),
      Expanded(
        child: CurrencyInputsList(currencies: state.currencies ?? []),
      )]);
  }
}
