import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrencyValuesNotifier extends StateNotifier<Map<String, double>> {
  final log = Logger('CurrencyValuesNotifier');

  CurrencyValuesNotifier({required List<Currency> initialCurrencies})
      : super(
          // Initialize with the selected currencies and default values (e.g., 0.0)
          {for (var currency in initialCurrencies) currency.symbol: 0.0},
        );

  // Update the value for a specific currency
  void updateValue(String symbol, double value) {
    log.d('Updating currency value: $symbol = $value');
    state = {
      ...state,
      symbol: value, // Update the specific currency
    };
  }
}

final currencyValuesProvider = StateNotifierProvider<CurrencyValuesNotifier, Map<String, double>>(
  (ref) {
    // Get the list of selected currencies
    final selectedCurrencies = ref.watch(selectedCurrenciesProvider);

    // Create the notifier with the initial values
    return CurrencyValuesNotifier(initialCurrencies: selectedCurrencies);
  },
);
