class ApiConfig {
  static const String baseUrl =
      'https://new-server-homefind.onrender.com/api/v1';
  static const String loginUrl = '/user/loginPhoneNumber';
  static const String registerUrl = '/user/registor';

  static String getLoginUrl() {
    return baseUrl + loginUrl;
  }

  static String getRegisterUrl() {
    return baseUrl + registerUrl;
  }
}
