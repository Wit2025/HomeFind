class LanguageModel {
  final String code;
  final String name;
  final String flagAsset;

  const LanguageModel({
    required this.code,
    required this.name,
    required this.flagAsset,
  });

  /// รายการภาษาทั้งหมดที่รองรับ
  static List<LanguageModel> getAllLanguages() {
    return [
      const LanguageModel(
        code: 'lo',
        name: 'ລາວ (Lao)',
        flagAsset: 'assets/images/lao.png',
      ),
      const LanguageModel(
        code: 'en',
        name: 'English',
        flagAsset: 'assets/images/en.png',
      ),
      const LanguageModel(
        code: 'zh',
        name: '中文 (Chinese)',
        flagAsset: 'assets/images/ch.png',
      ),
      const LanguageModel(
        code: 'ko',
        name: '한국어 (Korean)',
        flagAsset: 'assets/images/ko.png',
      ),
      const LanguageModel(
        code: 'hi',
        name: 'हिंदी (Hindi)',
        flagAsset: 'assets/images/in.png',
      ),
      const LanguageModel(
        code: 'ja',
        name: '日本語 (Japanese)',
        flagAsset: 'assets/images/ja.png',
      ),
    ];
  }

  /// หาภาษาจาก code
  static LanguageModel? findByCode(String code) {
    try {
      return getAllLanguages().firstWhere((lang) => lang.code == code);
    } catch (e) {
      return null;
    }
  }

  /// ตรวจสอบว่า code นี้รองรับหรือไม่
  static bool isSupported(String code) {
    return getAllLanguages().any((lang) => lang.code == code);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LanguageModel &&
          runtimeType == other.runtimeType &&
          code == other.code;

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'LanguageModel(code: $code, name: $name)';
}