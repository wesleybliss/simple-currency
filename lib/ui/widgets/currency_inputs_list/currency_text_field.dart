import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_currency/domain/models/currency.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow only digits and one decimal point
    if (newValue.text.isEmpty) {
      return newValue; // Allow empty input
    }

    // Regular expression to match valid decimal numbers
    final RegExp regex = RegExp(r'^\d*\.?\d*$');

    if (regex.hasMatch(newValue.text)) {
      return newValue; // If valid, return the new value
    }

    return oldValue; // If invalid, return the old value
  }
}

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
    
    final prefix = Padding(
        padding: const EdgeInsets.only(right: 12.0), // Add space to the right of the prefix
        child: Text(item.symbol,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6), // Dimmer text
          )));
    
    final label = Align(
      alignment: Alignment.centerRight,
      child: Column(children: [
        // Align(alignment: Alignment.centerRight, child: Text(item.symbol, textAlign: TextAlign.end)),
        Align(
            alignment: Alignment.centerRight,
            child: Text(item.name,
                textAlign: TextAlign.end, style: const TextStyle(fontSize: 12, color: Colors.grey))),
      ]),
    );
    
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefix: prefix,
        label: label,
        border: const OutlineInputBorder(),
      ),
      textAlign: TextAlign.end,
      keyboardType: TextInputType.number,
      inputFormatters: [
        // FilteringTextInputFormatter.digitsOnly,
        DecimalTextInputFormatter(),
        // CurrencyInputFormatter(item.symbol),
      ],
      onChanged: (text) {
        onTextChanged(item.symbol, text);
      },
    );
  }
}
