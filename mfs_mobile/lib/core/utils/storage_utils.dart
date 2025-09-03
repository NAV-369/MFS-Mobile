import 'package:shared_preferences/shared_preferences.dart';

class StorageUtils {
  static SharedPreferences? _prefs;

  // Initialize shared preferences
  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // Get string value
  static Future<String?> getString(String key) async {
    await init();
    return _prefs?.getString(key);
  }

  // Set string value
  static Future<bool> setString(String key, String value) async {
    await init();
    return await _prefs?.setString(key, value) ?? false;
  }

  // Remove value
  static Future<bool> remove(String key) async {
    await init();
    return await _prefs?.remove(key) ?? false;
  }

  // Clear all stored data
  static Future<bool> clear() async {
    await init();
    return await _prefs?.clear() ?? false;
  }

  // Check if key exists
  static Future<bool> containsKey(String key) async {
    await init();
    return _prefs?.containsKey(key) ?? false;
  }
}