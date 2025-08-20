import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static Future<void> savePersonalData(Map<String, String> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('ownerName', data['ownerName'] ?? '');
    await prefs.setString('ownerSurname', data['ownerSurname'] ?? '');
    await prefs.setString('ownerdob', data['ownerdob'] ?? '');
    await prefs.setString('village', data['village'] ?? '');
    await prefs.setString('district', data['district'] ?? '');
    await prefs.setString('city', data['city'] ?? '');
    await prefs.setString('documentType', data['documentType'] ?? '');
    await prefs.setString('documentNumber', data['documentNumber'] ?? '');
    await prefs.setString('documentImage', data['documentImage'] ?? '');
    await prefs.setString('personalImage', data['personalImage'] ?? '');
    await prefs.setBool('isPersonalInfoFilled', true);
  }

  static Future<Map<String, dynamic>> loadPersonalData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'ownerName': prefs.getString('ownerName') ?? '',
      'ownerSurname': prefs.getString('ownerSurname') ?? '',
      'ownerdob': prefs.getString('ownerdob') ?? '',
      'village': prefs.getString('village') ?? '',
      'district': prefs.getString('district') ?? '',
      'city': prefs.getString('city') ?? '',
      'documentType': prefs.getString('documentType') ?? '',
      'documentNumber': prefs.getString('documentNumber') ?? '',
      'documentImage': prefs.getString('documentImage') ?? '',
      'personalImage': prefs.getString('personalImage') ?? '',
    };
  }
}
