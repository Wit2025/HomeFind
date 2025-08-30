import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class GoogleSignInButton extends StatelessWidget {
  final bool isLoading;
  final bool isSmallScreen;
  final VoidCallback onPressed;

  const GoogleSignInButton({
    Key? key,
    required this.isLoading,
    required this.isSmallScreen,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/google.png',
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).login_with_google,
              style: TextStyle(
                fontFamily: 'NotoSansLao',
                fontSize: isSmallScreen ? 14 : 16,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}