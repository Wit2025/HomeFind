import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class RegisterFormFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback onTogglePasswordVisibility;

  const RegisterFormFields({
    super.key,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Full name field
        TextFormField(
          controller: usernameController,
          decoration: InputDecoration(
            labelText: S.of(context).full_name,
            labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
            prefixIcon: const Icon(Icons.badge_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          style: TextStyle(fontFamily: 'NotoSansLao'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_full_name;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Email field
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: S.of(context).email,
            labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
            prefixIcon: const Icon(Icons.email_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          style: TextStyle(fontFamily: 'NotoSansLao'),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_email;
            }
            final emailRegExp = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            );
            if (!emailRegExp.hasMatch(value)) {
              return S.of(context).invalid_email;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Phone field
        TextFormField(
          controller: phoneController,
          decoration: InputDecoration(
            labelText: S.of(context).phone,
            labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
            prefixIcon: const Icon(Icons.phone_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          style: TextStyle(fontFamily: 'NotoSansLao'),
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_phone;
            }
            if (value.length < 8) {
              return S.of(context).invalid_phone_number;
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Password field
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: S.of(context).password,
            labelStyle: TextStyle(fontFamily: 'NotoSansLao'),
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onTogglePasswordVisibility,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 14,
              horizontal: 16,
            ),
          ),
          style: TextStyle(fontFamily: 'NotoSansLao'),
          obscureText: obscurePassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_password;
            }
            if (value.length < 6) {
              return S.of(context).password_min_length;
            }
            return null;
          },
        ),
      ],
    );
  }
}