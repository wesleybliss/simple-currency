import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/io/settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<Settings> build() async {
    final prefs = await SharedPreferences.getInstance();
    return Settings.fromPreferences(prefs);
  }

  Future<void> updateSettings(Settings newSettings) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await newSettings.saveToPreferences(prefs);
      return newSettings;
    });
  }

  Future<void> setRoundingDecimals(int value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(roundingDecimals: value);
    await updateSettings(newSettings);
  }

  Future<void> setDragReorderHandles(bool value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(
        showDragReorderHandles: !currentSettings.showDragReorderHandles);
    await updateSettings(newSettings);
  }

  Future<void> setShowCopyToClipboardButtons(bool value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(
        showCopyToClipboardButtons:
            !currentSettings.showCopyToClipboardButtons);
    await updateSettings(newSettings);
  }

  Future<void> setShowFullCurrencyNameLabel(bool value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(
        showFullCurrencyNameLabel: !currentSettings.showFullCurrencyNameLabel);
    await updateSettings(newSettings);
  }

  Future<void> setInputsPosition(String value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(inputsPosition: value);
    await updateSettings(newSettings);
  }

  Future<void> setShowCurrencyRate(String value) async {
    final currentSettings = await future;
    final newSettings = currentSettings.copyWith(showCurrencyRate: value);
    await updateSettings(newSettings);
  }
}
