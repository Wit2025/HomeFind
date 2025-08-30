import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final bool isVisible;
  final VoidCallback onToggleVisibility;
  final String? Function(String?) validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputAction? textInputAction;

  const CustomPasswordField({
    Key? key,
    this.controller,
    required this.label,
    required this.isVisible,
    required this.onToggleVisibility,
    required this.validator,
    this.contentPadding,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: !isVisible,
      textInputAction: textInputAction ?? TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0C697A)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: onToggleVisibility,
        ),
      ),
      validator: validator,
    );
  }
}