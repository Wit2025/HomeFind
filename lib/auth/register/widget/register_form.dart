import 'package:flutter/material.dart';
import 'package:homefind/auth/register/widget/register_button.dart';
import 'package:homefind/auth/register/widget/register_form_field.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isSmallScreen;
  final bool isLoading;
  final bool obscurePassword;
  final bool acceptTerms;
  final VoidCallback onSubmitForm;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onTogglePasswordVisibility;
  final Function(bool?) onToggleAcceptTerms;
  final VoidCallback onNavigateToLogin;

  const RegisterForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.isSmallScreen,
    required this.isLoading,
    required this.obscurePassword,
    required this.acceptTerms,
    required this.onSubmitForm,
    required this.onSignInWithGoogle,
    required this.onTogglePasswordVisibility,
    required this.onToggleAcceptTerms,
    required this.onNavigateToLogin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
      padding: EdgeInsets.all(isSmallScreen ? 20 : 25),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 15,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
                ),
              ),
              child: Text(
                S.of(context).register,
                style: TextStyle(
                  fontFamily: 'NotoSansLao',
                  fontSize: isSmallScreen ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.color1,
                ),
              ),
            ),
            const SizedBox(height: 20),

            RegisterFormFields(
              usernameController: usernameController,
              emailController: emailController,
              phoneController: phoneController,
              passwordController: passwordController,
              obscurePassword: obscurePassword,
              onTogglePasswordVisibility: onTogglePasswordVisibility,
            ),

            const SizedBox(height: 2),

            // Terms and conditions checkbox
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: acceptTerms,
                  onChanged: onToggleAcceptTerms,
                  activeColor: const Color(0xFF008B8B),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Text(
                      S.of(context).accept_terms_conditions,
                      style: TextStyle(fontFamily: 'NotoSansLao', fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),

            RegisterActionButtons(
              isSmallScreen: isSmallScreen,
              isLoading: isLoading,
              onSubmitForm: onSubmitForm,
              onSignInWithGoogle: onSignInWithGoogle,
              onNavigateToLogin: onNavigateToLogin,
            ),
          ],
        ),
      ),
    );
  }
}
