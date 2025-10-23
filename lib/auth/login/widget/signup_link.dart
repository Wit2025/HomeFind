import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';

class SignupLink extends StatelessWidget {
  final bool isSmallScreen;
  final VoidCallback onNavigateToRegister;

  const SignupLink({
    super.key,
    required this.isSmallScreen,
    required this.onNavigateToRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          S.of(context).no_account_yet,
          style: TextStyle(
            fontFamily: 'NotoSansLao',
            fontSize: isSmallScreen ? 14 : 16,
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onNavigateToRegister,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            S.of(context).register,
            style: TextStyle(
              fontFamily: 'NotoSansLao',
              fontSize: isSmallScreen ? 14 : 16,
              color: AppColors.color1,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}