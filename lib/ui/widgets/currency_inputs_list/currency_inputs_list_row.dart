import 'package:flutter/material.dart';
import 'package:simple_currency/domain/extensions/extensions.dart';
import 'package:simple_currency/domain/models/currency.dart';
import 'package:simple_currency/ui/widgets/currency_inputs_list/currency_text_field.dart';

class CurrencyInputsListRow extends StatelessWidget{
  final Currency item;
  final TextEditingController? controller;
  final void Function(String) onFocusChanged;
  final void Function(String, String) onTextChanged;
  
  const CurrencyInputsListRow({super.key, 
    required this.item,
    required this.controller,
    required this.onFocusChanged,
    required this.onTextChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Focus(
            onFocusChange: (hasFocus) {
              if (hasFocus) {
                onFocusChanged(item.symbol);
              }
            },
            child: CurrencyTextField(item: item, controller: controller, onTextChanged: onTextChanged),
          )),
      IconButton(
        icon: const Icon(Icons.content_copy),
        onPressed: () {
          context.copyToClipboard(controller?.text ?? '');
        },
      ),
    ]);
  }
}
