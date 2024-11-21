import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/extensions/extensions.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/utils/currency_utils.dart';
import 'package:simple_currency/utils/logger.dart';

import 'currency_text_field.dart';

class CurrenciesInputsList extends ConsumerStatefulWidget {
  const CurrenciesInputsList({super.key, required this.currencies});

  final List<Currency> currencies;

  @override
  ConsumerState<CurrenciesInputsList> createState() => _CurrenciesInputsListState();
}

class _CurrenciesInputsListState extends ConsumerState<CurrenciesInputsList> {
  final log = Logger('CurrenciesInputsList');
  final Map<String, TextEditingController> _controllers = {};

  // Track the focused input so we can clear them all when it changes
  String? _focusedSymbol;

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers for each currency
    for (var currency in widget.currencies) {
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
    final Map<String, double> updatedValues = convertCurrencies(symbol, inputValue, widget.currencies);

    // Update the controllers with the new values
    updatedValues.forEach((key, value) {
      _controllers[key]?.text = value.toStringAsFixed(2);
    });
  }
  
  Widget itemBuilder(BuildContext context, int index) {
    final item = widget.currencies[index];
    final controller = _controllers[item.symbol];

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(children: [
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
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.currencies.length ?? 0,
      itemBuilder: itemBuilder,
    );
  }
}
