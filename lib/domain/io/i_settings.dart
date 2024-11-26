import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettings {
  DateTime? lastUpdated;
  int roundingDecimals = 4;
  
  ISettings copyWith({
    DateTime? lastUpdated,
    int? roundingDecimals,
  });

  Future<void> load();

  //region Utility Methods
  
  Future<SharedPreferences> getInstance();

  Future<String?> getString(String key, {String? defaultValue});
  Future<void> setString(String key, String value);
  Future<int?> getInt(String key, {int? defaultValue});
  Future<void> setInt(String key, int value);
  Future<DateTime?> getDateTime(String key, {DateTime? defaultValue});
  Future<void> setDateTime(String key, DateTime value);

  //endregion Utility Methods

  Future<DateTime?> getLastUpdated();
  Future<void> setLastUpdated(DateTime value);
  
  Future<int> getRoundingDecimals();
  Future<void> setRoundingDecimals(int value);
}
