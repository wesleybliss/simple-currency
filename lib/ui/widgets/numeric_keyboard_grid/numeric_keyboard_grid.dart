import 'package:flutter/material.dart';
import 'package:simple_currency/ui/widgets/numeric_keyboard_grid/numeric_keyboard_grid_button.dart';

class NumericKeyboardGrid extends StatefulWidget {
  const NumericKeyboardGrid({super.key});

  @override
  State<NumericKeyboardGrid> createState() => _NumericKeyboardGridState();
}

class _NumericKeyboardGridState extends State<NumericKeyboardGrid> {
  String input = '';

  void _updateInput(String value) {
    setState(() {
      input += value; // Update the input string
    });
  }

  void _clearInput() {
    setState(() {
      input = ''; // Clear the input string
    });
  }

  void _backspace() {
    setState(() {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1); // Remove last character
      }
    });
  }

  // @override
  Widget build1(BuildContext context) {
    // Get the bottom padding to account for safe area
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
        padding: const EdgeInsets.all(10),
    height: 200, // Set a fixed height for the grid
    child: GridView.builder(
        padding: const EdgeInsets.all(10),
      physics: NeverScrollableScrollPhysics(), // Prevent scrolling
      shrinkWrap: true, // Allow it to take only the space it needs
        itemCount: 12, // Total buttons (0-9 + Clear + Backspace)
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Three buttons per row
          childAspectRatio: 1, // Square buttons
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          if (index < 9) {
            return NumericKeyboardGridButton(
              label: (index + 1).toString(),
              onPressed: () => _updateInput((index + 1).toString()),
            );
          } else if (index == 9) {
            return NumericKeyboardGridButton(
              label: '0',
              onPressed: () => _updateInput('0'),
            );
          } else if (index == 10) {
            return NumericKeyboardGridButton(
              label: 'C',
              onPressed: _clearInput,
            );
          } else {
            // index == 11
            return NumericKeyboardGridButton(
              label: '<',
              onPressed: _backspace,
            );
          }
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    int buttonLabelIndex = 1;
    
    // Get the bottom padding to account for safe area
    final bottomPadding = MediaQuery
        .of(context)
        .padding
        .bottom;
    
    int nextButtonLabel() {
      if (buttonLabelIndex == 10) buttonLabelIndex = 0;
      return buttonLabelIndex++;
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
                );
              } else if (index == 15) {
                return NumericKeyboardGridButton(
                  label: '/',
                  onPressed: onDividePressed,
                );
              } else {
                return NumericKeyboardGridButton(
                  label: '${nextButtonLabel()}',
                  onPressed: () {},
                );
              }
            },
          );
        },
      ),
    );
  }
}
