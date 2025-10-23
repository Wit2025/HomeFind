import 'package:flutter/material.dart';
import 'package:homefind/auth/login/widget/google_signup_button.dart';
import 'login_title.dart';
import 'phone_input_field.dart';
import 'password_input_field.dart';
import 'remember_forgot_row.dart';
import 'login_button.dart';
import 'divider_or.dart';
import 'signup_link.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool obscurePassword;
  final bool rememberMe;
  final bool isSmallScreen;
  final VoidCallback onSubmitForm;
  final VoidCallback onSignInWithGoogle;
  final VoidCallback onTogglePasswordVisibility;
  final Function(bool?) onToggleRememberMe;
  final VoidCallback onNavigateToForgotPassword;
  final VoidCallback onNavigateToRegister;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.passwordController,
    required this.isLoading,
    required this.obscurePassword,
    required this.rememberMe,
    required this.isSmallScreen,
    required this.onSubmitForm,
    required this.onSignInWithGoogle,
    required this.onTogglePasswordVisibility,
    required this.onToggleRememberMe,
    required this.onNavigateToForgotPassword,
    required this.onNavigateToRegister,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoginTitle(isSmallScreen: isSmallScreen),
            const SizedBox(height: 16),
            PhoneInputField(controller: phoneController),
            const SizedBox(height: 16),
            PasswordInputField(
              controller: passwordController,
              obscurePassword: obscurePassword,
              onToggleVisibility: onTogglePasswordVisibility,
            ),
            const SizedBox(height: 8),
            RememberForgotRow(
              rememberMe: rememberMe,
              onToggleRememberMe: onToggleRememberMe,
              onNavigateToForgotPassword: onNavigateToForgotPassword,
            ),
            const SizedBox(height: 16),
            LoginButton(
              isLoading: isLoading,
              isSmallScreen: isSmallScreen,
              onPressed: onSubmitForm,
            ),
            const SizedBox(height: 24),
            const DividerOr(),
            const SizedBox(height: 24),
            GoogleSignInButton(
              isLoading: isLoading,
              isSmallScreen: isSmallScreen,
              onPressed: onSignInWithGoogle,
            ),
            const SizedBox(height: 24),
            SignupLink(
              isSmallScreen: isSmallScreen,
              onNavigateToRegister: onNavigateToRegister,
            ),
          ],
        ),
      ),
    );
  }
}
