import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';

class RegisterActionButtons extends StatelessWidget {
  final bool isSmallScreen;
  final bool isLoading;
  final VoidCallback onSubmitForm;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onNavigateToLogin;

  const RegisterActionButtons({
    super.key,
    required this.isSmallScreen,
    required this.isLoading,
    required this.onSubmitForm,
    required this.onSignInWithGoogle,
    required this.onNavigateToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Register button
        SizedBox(
          width: double.infinity,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.color1, AppColors.color2],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : onSubmitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      S.of(context).register,
                      style: TextStyle(
                        fontFamily: 'NotoSansLao',
                        fontSize: isSmallScreen ? 16 : 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Divider with "OR"
        Row(
          children: [
            const Expanded(
              child: Divider(thickness: 1, color: Colors.grey),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                S.of(context).or,
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ),
            const Expanded(
              child: Divider(thickness: 1, color: Colors.grey),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Google Sign-In Button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: isLoading ? null : onSignInWithGoogle,
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
                  S.of(context).register_with_google,
                  style: TextStyle(
                    fontFamily: 'NotoSansLao',
                    fontSize: isSmallScreen ? 14 : 16,
                    color: Colors.grey.shade800,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Already have an account? Login
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).already_have_account,
              style: TextStyle(
                fontFamily: 'NotoSansLao',
                fontSize: isSmallScreen ? 14 : 16,
              ),
            ),
            const SizedBox(width: 4),
            TextButton(
              onPressed: onNavigateToLogin,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                S.of(context).login,
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  fontSize: isSmallScreen ? 14 : 16,
                  color: AppColors.color1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}