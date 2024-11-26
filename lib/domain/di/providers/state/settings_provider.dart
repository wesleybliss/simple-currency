import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/domain/constants/constants.dart';
import 'package:simple_currency/domain/io/i_settings.dart';

class Settings implements ISettings {
  @override
  DateTime? lastUpdated;
  @override
  int roundingDecimals = 4;
  
  Settings({
    this.lastUpdated,
    this.roundingDecimals = 4,
  });

  @override
  Settings copyWith({
    DateTime? lastUpdated,
    int? roundingDecimals,
  }) => Settings(
      lastUpdated: lastUpdated ?? this.lastUpdated,
      roundingDecimals: roundingDecimals ?? this.roundingDecimals,
    );
  
  @override
  Future<void> load() async {
    lastUpdated = await getLastUpdated();
  }

  //region Utility Methods
  
  @override
  Future<SharedPreferences> getInstance() async => await SharedPreferences.getInstance();
  
  @override
  Future<String?> getString(String key, {String? defaultValue}) async {
    final prefs = await getInstance();
    return prefs.getString(key) ?? defaultValue;
  }

  @override
  Future<void> setString(String key, String value) async {
    final prefs = await getInstance();
    await prefs.setString(key, value);
  }
  
  @override
  Future<int?> getInt(String key, {int? defaultValue}) async {
    final prefs = await getInstance();
    return prefs.getInt(key) ?? defaultValue;
  }
  
  @override
  Future<void> setInt(String key, int value) async {
    final prefs = await getInstance();
    await prefs.setInt(key, value);
  }

  @override
  Future<DateTime?> getDateTime(String key, {DateTime? defaultValue}) async {
    final lastUpdated = await getString(key);
    return lastUpdated != null ? DateTime.parse(lastUpdated) : defaultValue;
  }
  
  @override
  Future<void> setDateTime(String key, DateTime value) async {
    final prefs = await getInstance();
    await prefs.setString(key, value.toIso8601String());
  }

  //endregion Utility Methods
  
  @override
  Future<DateTime?> getLastUpdated() async => await getDateTime(Constants.keys.settings.lastUpdated);

  @override
  Future<void> setLastUpdated(DateTime value) async {
    lastUpdated = value;
    await setDateTime(Constants.keys.settings.lastUpdated, value);
  }
  
  @override
  Future<int> getRoundingDecimals() async => await getInt(Constants.keys.settings.roundingDecimals) ?? 4;
  
  @override
  Future<void> setRoundingDecimals(int value) async {
    roundingDecimals = value;
    await setInt(Constants.keys.settings.roundingDecimals, value);
  }
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings());
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  return SettingsNotifier();
});

// Load initial settings
// ref.read(settingsProvider.notifier).load();

// Watch for changes to settings
// final settings = ref.watch(settingsProvider);

// Update settings
// await ref.read(settingsProvider.notifier).setUsername(value);
