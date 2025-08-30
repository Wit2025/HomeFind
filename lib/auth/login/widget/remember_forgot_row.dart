import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class RememberForgotRow extends StatelessWidget {
  final bool rememberMe;
  final Function(bool?) onToggleRememberMe;
  final VoidCallback onNavigateToForgotPassword;

  const RememberForgotRow({
    Key? key,
    required this.rememberMe,
    required this.onToggleRememberMe,
    required this.onNavigateToForgotPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me checkbox
        Row(
          children: [
            Checkbox(
              value: rememberMe,
              onChanged: onToggleRememberMe,
              activeColor: const Color(0xFF008B8B),
            ),
            Text(
              S.of(context).remember_user,
              style: const TextStyle(
                fontFamily: 'NotoSansLao',
                fontSize: 14,
              ),
            ),
          ],
        ),

        // Forgot password
        TextButton(
          onPressed: onNavigateToForgotPassword,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            S.of(context).forgot_password,
            style: const TextStyle(
              fontFamily: 'NotoSansLao',
              color: AppColors.color1,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}