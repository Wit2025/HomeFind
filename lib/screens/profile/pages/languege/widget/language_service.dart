import 'package:flutter/material.dart';
import 'package:homefind/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String _languageKey = 'selected_language';
  static const String _defaultLanguage = 'lo';

  /// โหลดภาษาที่บันทึกไว้จาก SharedPreferences
  Future<String> getSelectedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_languageKey) ?? _defaultLanguage;
    } catch (e) {
      return _defaultLanguage;
    }
  }

  /// บันทึกภาษาและอัปเดตแอปทันที
  Future<void> saveAndUpdateLanguage(
    BuildContext context,
    String languageCode,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);

      // อัปเดตภาษาในแอปทันที
      HomeFind.of(context)?.setLocale(Locale(languageCode));
    } catch (e) {
      // จัดการ error หากจำเป็น
      debugPrint('Error saving language: $e');
    }
  }

  /// บันทึกภาษาโดยไม่อัปเดตทันที (สำหรับกรณีที่ต้องการแยก logic)
  Future<void> saveLanguage(String languageCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, languageCode);
    } catch (e) {
      debugPrint('Error saving language: $e');
    }
  }

  /// อัปเดตภาษาในแอป
  void updateAppLanguage(BuildContext context, String languageCode) {
    HomeFind.of(context)?.setLocale(Locale(languageCode));
  }
}
