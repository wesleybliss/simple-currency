import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/domain/di/providers/state/currencies_provider.dart';
import 'package:simple_currency/domain/di/providers/state/currency_values_provider.dart';
import 'package:simple_currency/ui/widgets/numeric_keyboard_grid/numeric_keyboard_grid_button.dart';

class NumericKeyboardGrid extends ConsumerStatefulWidget {
  const NumericKeyboardGrid({super.key});

  @override
  ConsumerState<NumericKeyboardGrid> createState() => _NumericKeyboardGridState();
}

class _NumericKeyboardGridState extends ConsumerState<NumericKeyboardGrid> {
  String input = '';

  @override
  Widget build(BuildContext context) {
    int buttonLabelIndex = 1;
    final focusedCurrencyInputSymbol = ref.watch(focusedCurrencyInputSymbolProvider);
    
    // Get the bottom padding to account for safe area
    final bottomPadding = MediaQuery
        .of(context)
        .padding
        .bottom;
    
    int nextButtonIndex() {
      if (buttonLabelIndex == 10) buttonLabelIndex = 0;
      return buttonLabelIndex++;
    }

    void updateInput(String value) {
      setState(() {
        input += value; // Update the input string
      });

      final next = double.tryParse(input) ?? 0.0;
      
      ref.read(currencyValuesProvider.notifier)
          .setValue(input, input);

      /*if (focusedCurrencyInputSymbol != null) {
        ref.read(currencyValuesProvider.notifier).updateValue(focusedCurrencyInputSymbol, (prev) => '${prev}${next}');
      }*/
    }
    
    void onAddPressed() {
      
    }
    
    void onSubtractPressed() {
      
    }
    
    void onMultiplyPressed() {
      
    }
    
    void onDividePressed() {
      
    }
    
    void onCommaPressed() {
      
    }
    
    void onBackspacePressed() {
      setState(() {
        if (input.isNotEmpty) {
          // Remove last character
          input = input.substring(0, input.length - 1);
        }
      });
    }
    
    void onBackspaceLongPressed() {
      setState(() {
        input = ''; // Clear the input string
      });
    }
    
    return Container(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 16,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 columns
              crossAxisSpacing: 8.0, // Spacing between columns
              mainAxisSpacing: 8.0, // Spacing between rows
              childAspectRatio: 2.0, // Width is 2x the height
            ),
            itemBuilder: (context, index) {
              
              if (index == 3) {
                return NumericKeyboardGridButton(
                  label: '+',
                  onPressed: onAddPressed,
                );
              } else if (index == 7) {
                return NumericKeyboardGridButton(
                  label: '-',
                  onPressed: onSubtractPressed,
                );
              } else if (index == 11) {
                return NumericKeyboardGridButton(
                  label: '*',
                  onPressed: onMultiplyPressed,
                );
              } else if (index == 12) {
                return NumericKeyboardGridButton(
                  label: ',',
                  onPressed: onCommaPressed,
                );
              } else if (index == 14) {
                return NumericKeyboardGridButton(
                  label: '/',
                  onPressed: onBackspacePressed,
                  onLongPress: onBackspaceLongPressed,
                );
              } else if (index == 15) {
                return NumericKeyboardGridButton(
                  label: '/',
                  onPressed: onDividePressed,
                );
              } else {
                final buttonIndex = nextButtonIndex();
                return NumericKeyboardGridButton(
                  label: '$buttonIndex',
                  onPressed: () {
                    updateInput(buttonIndex.toString());
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
