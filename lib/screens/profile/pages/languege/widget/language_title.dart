import 'package:flutter/material.dart';
import 'package:homefind/screens/profile/pages/languege/widget/language_model.dart';
import 'package:homefind/widgets/colors.dart';

class LanguageTile extends StatelessWidget {
  final LanguageModel language;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: ClipOval(
          child: Image.asset(
            language.flagAsset,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[200],
                child: Icon(
                  Icons.language,
                  color: Colors.grey[400],
                  size: 20,
                ),
              );
            },
          ),
        ),
      ),
      title: Text(
        language.name,
        style: const TextStyle(
          fontSize: 16, 
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Radio<String>(
        value: language.code,
        // ignore: deprecated_member_use
        groupValue: isSelected ? language.code : null,
        // ignore: deprecated_member_use
        onChanged: (value) {
          if (value != null) {
            onTap();
          }
        },
        activeColor: AppColors.color1,
      ),
      onTap: onTap,
    );
  }
}