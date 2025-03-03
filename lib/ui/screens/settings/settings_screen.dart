import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_currency/config/application.dart';
import 'package:simple_currency/domain/di/providers/state/settings_provider.dart';
import 'package:simple_currency/io/settings.dart';
import 'package:simple_currency/ui/widgets/toolbar.dart';

import 'widgets/inputs_position_dropdown.dart';
import 'widgets/round_decimals_to_input.dart';
import 'widgets/show_copy_to_clipboard_buttons_switch.dart';
import 'widgets/show_currency_rate_dropdown.dart';
import 'widgets/show_drag_reorder_handles_switch.dart';
import 'widgets/show_full_currency_name_label_switch.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});
  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final settingsAsyncValue = ref.watch(settingsNotifierProvider);
    final Map<String, TextEditingController> _controllers = {
      "roundingDecimalsController": TextEditingController(),
    };

    for (var i = 0; i < 3; i++) {
      _controllers.putIfAbsent("controller-$i", () => TextEditingController());
    }

    @override
    void dispose() {
      for (var controller in _controllers.values) {
        controller.dispose();
      }
      super.dispose();
    }

    Widget renderBody(Settings settings) {
      return Column(
        children: [
          RoundDecimalsToInput(
              controller: _controllers["roundingDecimalsController"]),
          ShowDragReorderHandlesSwitch(value: settings.showDragReorderHandles),
          ShowCopyToClipboardButtonsSwitch(
              value: settings.showCopyToClipboardButtons),
          ShowFullCurrencyNameLabelSwitch(
              value: settings.showFullCurrencyNameLabel),
          InputsPositionDropdown(value: settings.inputsPosition),
          ShowCurrencyRateDropdown(value: settings.showCurrencyRate),
          ElevatedButton(
            onPressed: () {
              // Handle settings action
              print('Settings pressed');
              Application.router.navigateTo(context, '/currencies');
            },
            child: const Text('Currencies'),
          ),
        ],
      );
    }

    return settingsAsyncValue.when(
          loading: () => const CircularProgressIndicator(),
          error: (error, stackTrace) => Text('Error: $error'),
          data: (settings) {
            // Set initial values
            _controllers["roundingDecimalsController"]?.text =
                settings.roundingDecimals.toString();

            return renderBody(settings);
          });
  }
}
