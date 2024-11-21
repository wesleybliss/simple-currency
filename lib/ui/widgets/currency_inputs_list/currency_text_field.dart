import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/utils/currency_input_formatter.dart';

class CurrencyTextField extends StatelessWidget {
  final Currency item;
  final TextEditingController? controller;
  final void Function(String, String) onTextChanged;

  const CurrencyTextField({
    super.key,
    required this.item,
    required this.controller,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: '${item.symbol} - ${item.name}',
        border: const OutlineInputBorder(),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        // CurrencyInputFormatter(item.symbol),
      ],
      onChanged: (text) {
        onTextChanged(item.symbol, text);
      },
    );
  }
}
