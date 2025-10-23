import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class PhoneInputField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: S.of(context).phone,
        labelStyle: const TextStyle(fontFamily: 'NotoSansLao'),
        prefixIcon: const Icon(Icons.phone),
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
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return S.of(context).please_enter_phone;
        }
        if (!RegExp(r'^[0-9]{8,15}$').hasMatch(value)) {
          return S.of(context).invalid_phone_number;
        }
        return null;
      },
    );
  }
}