import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/di/providers/state/sorted_currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/utils/currency_utils.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrencyValuesNotifier extends StateNotifier<Map<String, double>> {
  final log = Logger('CurrencyValuesNotifier');
  final Ref ref;

  CurrencyValuesNotifier(List<Currency> initialCurrencies, this.ref)
      : super(
          // Initialize with the selected currencies and default values (e.g., 0.0)
          {for (var currency in initialCurrencies) currency.symbol: 0.0},
        );

  void clearValues() {
    for (var currency in state.keys) {
      state[currency] = 0.0;
    }
  }
  
  // Update the value for a specific currency
  Map<String, double> setValue(String symbol, String text) {
    log.d('setValue: $symbol = $text');
    final double value = double.tryParse(text) ?? 0.0;
    final sortedCurrencies = ref.read(sortedCurrenciesProvider);

    // Get the updated currency values
    state = convertCurrencies(symbol, value, sortedCurrencies);

    return state;
  }

  // Update the value for a specific currency
  // Uses a callback to allow the caller to read the existing value before returning the updated one
  String updateValue(String symbol, String Function(String prev) callback) {
    final prev = state[symbol] ?? 0.0;
    final next = callback(prev == 0.0 ? '' : prev.toString());
    
    log.d('updateValue: $symbol = $prev -> $next');
    setValue(symbol, next.toString());
    return next;
  }
}

final currencyValuesProvider = StateNotifierProvider<CurrencyValuesNotifier, Map<String, double>>(
  (ref) {
    // Get the list of selected currencies
    final selectedCurrencies = ref.watch(selectedCurrenciesProvider);

    // Create the notifier with the initial values
    return CurrencyValuesNotifier(selectedCurrencies, ref);
  },
);
