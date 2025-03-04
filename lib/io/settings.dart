import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/io/i_settings.dart';

class Settings implements ISettings {
  @override
  String theme = "system";
  @override
  DateTime? lastUpdated;
  @override
  int roundingDecimals = 4;
  @override
  bool showDragReorderHandles = true;
  @override
  bool showCopyToClipboardButtons = true;
  @override
  bool showFullCurrencyNameLabel = true;
  @override
  String inputsPosition = "center";
  @override
  String showCurrencyRate = "selected";

  Settings({
    this.theme = "system",
    this.lastUpdated,
    this.roundingDecimals = 4,
    this.showDragReorderHandles = true,
    this.showCopyToClipboardButtons = true,
    this.showFullCurrencyNameLabel = true,
    this.inputsPosition = "center",
    this.showCurrencyRate = "selected",
  });

  @override
  Settings copyWith({
    String? theme,
    DateTime? lastUpdated,
    int? roundingDecimals,
    bool? showDragReorderHandles,
    bool? showCopyToClipboardButtons,
    bool? showFullCurrencyNameLabel,
    String? inputsPosition,
    String? showCurrencyRate,
  }) =>
      Settings(
        theme: theme ?? this.theme,
        lastUpdated: lastUpdated ?? this.lastUpdated,
        roundingDecimals: roundingDecimals ?? this.roundingDecimals,
        showDragReorderHandles:
            showDragReorderHandles ?? this.showDragReorderHandles,
        showCopyToClipboardButtons:
            showCopyToClipboardButtons ?? this.showCopyToClipboardButtons,
        showFullCurrencyNameLabel:
            showFullCurrencyNameLabel ?? this.showFullCurrencyNameLabel,
        inputsPosition: inputsPosition ?? this.inputsPosition,
        showCurrencyRate: showCurrencyRate ?? this.showCurrencyRate,
      );

  // Factory method to create a Settings object from SharedPreferences
  factory Settings.fromPreferences(SharedPreferences prefs) {
    return Settings(
      theme: prefs.getString(Constants.keys.settings.theme) ?? "system",
      lastUpdated: prefs.getString(Constants.keys.settings.lastUpdated) != null
          ? DateTime.parse(
              prefs.getString(Constants.keys.settings.lastUpdated)!)
          : null,
      roundingDecimals:
          prefs.getInt(Constants.keys.settings.roundingDecimals) ?? 4,
      showDragReorderHandles:
          prefs.getInt(Constants.keys.settings.showDragReorderHandles) == 1,
      showCopyToClipboardButtons:
          prefs.getInt(Constants.keys.settings.showCopyToClipboardButtons) == 1,
      showFullCurrencyNameLabel:
          prefs.getInt(Constants.keys.settings.showFullCurrencyNameLabel) == 1,
      inputsPosition:
          prefs.getString(Constants.keys.settings.inputsPosition) ?? "center",
      showCurrencyRate:
          prefs.getString(Constants.keys.settings.showCurrencyRate) ??
              "selected",
    );
  }

  // Method to save the settings to SharedPreferences
  @override
  Future<void> saveToPreferences(SharedPreferences prefs) async {
    await prefs.setString(Constants.keys.settings.theme, theme);
    if (lastUpdated != null) {
      await prefs.setString(
          Constants.keys.settings.lastUpdated, lastUpdated!.toIso8601String());
    }
    await prefs.setInt(
        Constants.keys.settings.roundingDecimals, roundingDecimals);
    await prefs.setInt(Constants.keys.settings.showDragReorderHandles,
        showDragReorderHandles ? 1 : 0);
    await prefs.setInt(Constants.keys.settings.showCopyToClipboardButtons,
        showCopyToClipboardButtons ? 1 : 0);
    await prefs.setInt(Constants.keys.settings.showFullCurrencyNameLabel,
        showFullCurrencyNameLabel ? 1 : 0);
    await prefs.setString(
        Constants.keys.settings.inputsPosition, inputsPosition);
    await prefs.setString(
        Constants.keys.settings.showCurrencyRate, showCurrencyRate);
  }
}
