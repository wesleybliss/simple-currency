import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/di/providers/state/currency_values_provider.dart';
import 'package:simple_currency/domain/di/providers/state/sorted_currencies_provider.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/ui/widgets/currency_inputs_list/currency_inputs_list_row.dart';
import 'package:simple_currency/utils/currency_utils.dart';
import 'package:simple_currency/utils/logger.dart';

class CurrenciesInputsList extends ConsumerStatefulWidget {
  final List<Currency> currencies;

  const CurrenciesInputsList({super.key, required this.currencies});

  @override
  ConsumerState<CurrenciesInputsList> createState() => _CurrenciesInputsListState();
}

class _CurrenciesInputsListState extends ConsumerState<CurrenciesInputsList> {
  final log = Logger('CurrenciesInputsList');
  final Map<String, TextEditingController> _controllers = {};

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Clear all controllers when the focused input changes
  void clearAllInputs() {
    // Clear all controllers when the focused input changes
    for (var controller in _controllers.values) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final sortedCurrencies = ref.watch(sortedCurrenciesProvider);
    final currencyValues = ref.watch(currencyValuesProvider);
    
    // Track the focused input so we can clear them all when it changes
    final focusedCurrencyInputSymbol = ref.watch(focusedCurrencyInputSymbolProvider);

    for (var currency in sortedCurrencies) {
      _controllers.putIfAbsent(currency.symbol, () => TextEditingController());
    }

    void onFocusChanged(String symbol) {
      if (focusedCurrencyInputSymbol == symbol) return;

      clearAllInputs();
      ref.read(focusedCurrencyInputSymbolProvider.notifier).setSymbol(symbol);
    }

    void updateControllers(Map<String, double> currencyValues) {
      for (var entry in currencyValues.entries) {
        final symbol = entry.key;
        final value = entry.value;

        if (_controllers.containsKey(symbol) && focusedCurrencyInputSymbol != symbol) {
          final controller = _controllers[symbol]!;
          final valueAsString = value.toStringAsFixed(2);

          // Update controller only if the value has changed
          if (controller.text != valueAsString) {
            controller.text = valueAsString;
          }
        }
      }
    }
    
    // Update the controllers with the latest currency values
    updateControllers(currencyValues);
    

    void onTextChanged(String symbol, String text) {
      // If the text is empty, clear all controllers
      if (text.isEmpty) {
        clearAllInputs();
        return;
      }
      
      /*// Convert the input text to a double
      final double inputValue = double.tryParse(text) ?? 0.0;

      // Get the updated currency values
      final Map<String, double> updatedValues = convertCurrencies(symbol, inputValue, sortedCurrencies);

      // Update the controllers with the new values
      updatedValues.forEach((key, value) {
        _controllers[key]?.text = value.toStringAsFixed(2);
        // Update the currency values provider
        ref.read(currencyValuesProvider.notifier).setValue(symbol, value);
      });*/

      
      //
      
      final updatedValues = ref.read(currencyValuesProvider.notifier).setValue(symbol, text);

      updatedValues.forEach((key, value) {
        _controllers[key]?.text = value.toStringAsFixed(2);
      });
    }

    void onReorderCurrency(int oldIndex, int newIndex) {
      setState(() {
        if (newIndex > oldIndex) newIndex -= 1; // Adjust for removal
        final item = sortedCurrencies.removeAt(oldIndex);
        sortedCurrencies.insert(newIndex, item);

        // Update the order property and save to ObjectBox
        for (int i = 0; i < sortedCurrencies.length; i++) {
          sortedCurrencies[i].order = i;
          ref.read(currenciesProvider.notifier).setCurrency(sortedCurrencies[i]);
        }
      });
    }

    return ReorderableListView(
      onReorder: onReorderCurrency,
      children: sortedCurrencies
          .map((e) => ListTile(
                key: ValueKey(e.symbol),
                title: CurrencyInputsListRow(item: e, controller: _controllers[e.symbol], onFocusChanged: onFocusChanged, onTextChanged: onTextChanged),
              ))
          .toList(),
    );
  }
}
