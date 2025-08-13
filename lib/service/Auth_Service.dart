import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_config.dart';

class AuthService {
  static Future<http.Response> loginWithPhoneNumber({
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse(ApiConfig.getLoginUrl());

    final body = jsonEncode({'phoneNumber': phoneNumber, 'password': password});

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: body, headers: headers);
    return response;
  }

  static Future<http.Response> registerWithPhoneNumber({
    required String username,
    required String email,
    required String phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse(ApiConfig.getRegisterUrl());

    final body = jsonEncode({
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    });

    final headers = {'Content-Type': 'application/json'};

    final response = await http.post(url, body: body, headers: headers);
    return response;
  }
}