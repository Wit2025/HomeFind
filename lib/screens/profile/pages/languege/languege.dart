import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_app_bar.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_list.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_service.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final LanguageService _languageService = LanguageService();
  String _selectedLanguage = '';

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  _loadSelectedLanguage() async {
    final language = await _languageService.getSelectedLanguage();
    setState(() {
      _selectedLanguage = language;
    });
  }

  _onLanguageChanged(String languageCode) async {
    await _languageService.saveAndUpdateLanguage(context, languageCode);
    setState(() {
      _selectedLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      backgroundColor: Colors.grey[50],
      appBar: LanguageAppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              S.of(context).selectLanguage,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: LanguageListCard(
              selectedLanguage: _selectedLanguage,
              onLanguageChanged: _onLanguageChanged,
            ),
          ),
        ],
      ),
    );
  }
}