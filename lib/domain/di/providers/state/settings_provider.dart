import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_currency/domain/constants/constants.dart';

class Settings {
  DateTime? lastUpdated;
  
  Settings({
    required this.lastUpdated,
  });

  Settings copyWith({
    DateTime? lastUpdated,
  }) => Settings(
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
}

class SettingsNotifier extends StateNotifier<Settings> {
  SettingsNotifier() : super(Settings(lastUpdated: null));
  
  Future<void> load() async {
    final lastUpdated = await getLastUpdated();
    state = Settings(lastUpdated: lastUpdated);
  }
  
  Future<String?> getString(String key, {String? defaultValue}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? defaultValue;
  }
  
  Future<DateTime?> getLastUpdated() async {
    final lastUpdated = await getString(Constants.keys.settings.lastUpdated);
    return lastUpdated != null ? DateTime.parse(lastUpdated) : null;
  }
  
  Future<void> setLastUpdated(DateTime value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lastUpdated', value.toIso8601String());
    state = state.copyWith(lastUpdated: value);
  }
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
