import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// This service class handles the local persistence of user data using SharedPreferences.
class LocalStorageService {
  static const _personalDataKey = 'personalData';

  // Saves a map of personal data to SharedPreferences.
  static Future<void> savePersonalData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(data);
    await prefs.setString(_personalDataKey, jsonString);
  }

  // Loads the saved personal data from SharedPreferences.
  static Future<Map<String, dynamic>> loadPersonalData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_personalDataKey);
    if (jsonString != null) {
      return Map<String, dynamic>.from(jsonDecode(jsonString));
    }
    return {};
  }
}
