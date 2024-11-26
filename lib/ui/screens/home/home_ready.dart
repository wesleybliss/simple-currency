import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/di/providers/state/currency_values_provider.dart';
import 'package:simple_currency/ui/widgets/currency_inputs_list/currency_inputs_list.dart';
import 'package:simple_currency/ui/widgets/numeric_keyboard_grid/numeric_keyboard_grid.dart';
import 'package:simple_currency/utils/logger.dart';

class HomeReady extends ConsumerWidget {
  const HomeReady({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = Logger('HomeReady');
    final state = ref.watch(currenciesProvider);
    final selectedCurrencies = ref.watch(selectedCurrenciesProvider);
    
    // @debug
    final focusedCurrencyInputSymbol = ref.watch(focusedCurrencyInputSymbolProvider);
    final Map<String, double> currencyValues = ref.watch(currencyValuesProvider);

    log.d('HomeReady: ${state.currencies.length} total');
    log.d('HomeReady: ${selectedCurrencies.length} selected');
    
    if (selectedCurrencies.isEmpty == true) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (state.error != null)
            Text(state.error!),
          const Center(
            child: Text('You don\'t have any currencies selected yet. \nAdd some by clicking the button below.')
          ),
          const SizedBox(height: 24.0),
          TextButton(
            onPressed: () => Application.router.navigateTo(context, '/currencies'),
            child: const Text('Manage Currencies'),
          ),
        ]
      );
    }
    
    return Column(children: [
      Text('focused: $focusedCurrencyInputSymbol'),
      Text(currencyValues.entries.map((e) => '${e.key}: ${e.value}').join('\n')),
      Expanded(
        child: CurrenciesInputsList(currencies: selectedCurrencies),
      ),
      const NumericKeyboardGrid(),
    ]);
  }
}
