import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_model.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_title.dart';

class LanguageListCard extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const LanguageListCard({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final languages = LanguageModel.getAllLanguages();

    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: languages.length,
          separatorBuilder: (context, index) => _buildDivider(),
          itemBuilder: (context, index) {
            final language = languages[index];
            return LanguageTile(
              language: language,
              isSelected: selectedLanguage == language.code,
              onTap: () => onLanguageChanged(language.code),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(
        height: 1, 
        thickness: 1, 
        color: Colors.grey[200],
      ),
    );
  }
}