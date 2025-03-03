import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettings {
  DateTime? lastUpdated;
  abstract int roundingDecimals;
  abstract bool showDragReorderHandles;
  abstract bool showCopyToClipboardButtons;
  abstract bool showFullCurrencyNameLabel;
  abstract String inputsPosition;
  abstract String showCurrencyRate;

  ISettings copyWith({
    DateTime? lastUpdated,
    int? roundingDecimals,
  });

  Future<void> saveToPreferences(SharedPreferences prefs);
}
