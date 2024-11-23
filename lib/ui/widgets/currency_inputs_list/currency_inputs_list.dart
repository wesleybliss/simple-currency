import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/extensions/extensions.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/utils/currency_utils.dart';
import 'package:simple_currency/utils/logger.dart';

import 'currency_text_field.dart';

class CurrenciesInputsList extends ConsumerStatefulWidget {
  final List<Currency> currencies;
  
  const CurrenciesInputsList({super.key, required this.currencies});

  @override
  ConsumerState<CurrenciesInputsList> createState() => _CurrenciesInputsListState();
}

class _CurrenciesInputsListState extends ConsumerState<CurrenciesInputsList> {
  final log = Logger('CurrenciesInputsList');
  final Map<String, TextEditingController> _controllers = {};
  List<Currency> sortedCurrencies = [];

  // Track the focused input so we can clear them all when it changes
  String? _focusedSymbol;

  @override
  void initState() {
    super.initState();

    // Sort first by order, then alphabetically by symbol
    sortedCurrencies = List<Currency>.from(widget.currencies);
    sortedCurrencies.sort((a, b) {
      final orderComparison = a.order.compareTo(b.order);
      if (orderComparison != 0) return orderComparison;
      return a.symbol.compareTo(b.symbol);
    });

    // Initialize controllers for each currency
    for (var currency in sortedCurrencies) {
      _controllers[currency.symbol] = TextEditingController();
    }
  }

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

  void _onFocusChanged(String symbol) {
    if (_focusedSymbol == symbol) return;
    
    clearAllInputs();
    _focusedSymbol = symbol;
  }

  void _onTextChanged(String symbol, String text) {
    // If the text is empty, clear all controllers
    if (text.isEmpty) {
      clearAllInputs();
      return;
    }

    // Convert the input text to a double
    final double inputValue = double.tryParse(text) ?? 0.0;

    // Get the updated currency values
    final Map<String, double> updatedValues = convertCurrencies(symbol, inputValue, sortedCurrencies);

    // Update the controllers with the new values
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
  
  Widget buildItem(Currency item, TextEditingController? controller) {
    return Row(children: [
          Expanded(
              child: Focus(
                onFocusChange: (hasFocus) {
                  if (hasFocus) {
                    _onFocusChanged(item.symbol);
                  }
                },
                child: CurrencyTextField(item: item, controller: controller, onTextChanged: _onTextChanged),
              )),
          IconButton(
            icon: const Icon(Icons.content_copy),
            onPressed: () {
              context.copyToClipboard(controller?.text ?? '');
            },
          ),
        ]);
  }
  
  Widget itemBuilder(BuildContext context, int index) {
    final item = sortedCurrencies[index];
    final controller = _controllers[item.symbol];

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: buildItem(item, controller));
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
      onReorder: onReorderCurrency,
      children: sortedCurrencies.map((e) => ListTile(
        key: ValueKey(e.symbol),
        title: buildItem(e, _controllers[e.symbol]),
      )).toList(),
    );
    
    /*return ListView.builder(
      itemCount: sortedCurrencies.length ?? 0,
      itemBuilder: itemBuilder,
    );*/
  }
}
