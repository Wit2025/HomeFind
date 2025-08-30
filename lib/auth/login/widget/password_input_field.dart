import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscurePassword;
  final VoidCallback onToggleVisibility;

  const PasswordInputField({
    Key? key,
    required this.controller,
    required this.obscurePassword,
    required this.onToggleVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: S.of(context).password,
        labelStyle: const TextStyle(fontFamily: 'NotoSansLao'),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Colors.grey,
          ),
          onPressed: onToggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 16,
        ),
      ),
      style: const TextStyle(fontFamily: 'NotoSansLao'),
      obscureText: obscurePassword,
      validator: (value) => null, // No validation for password in OTP flow
    );
  }
}