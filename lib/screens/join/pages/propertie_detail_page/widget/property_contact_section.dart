// widgets/property_contact_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_fields.dart';

class PropertyContactSection extends StatelessWidget {
  final Color primaryColor;
  final TextEditingController locationController;
  final TextEditingController phoneController;

  const PropertyContactSection({
    super.key,
    required this.primaryColor,
    required this.locationController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).addressAndContact,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        PropertyFormFields.buildInputField(
          label: S.of(context).address,
          controller: locationController,
          icon: Icons.location_on_outlined,
          primaryColor: primaryColor,
          validator: (value) => value?.isEmpty ?? true
              ? S.of(context).please_enter_address
              : null,
        ),
        const SizedBox(height: 8),
        PropertyFormFields.buildInputField(
          label: S.of(context).phone,
          hint: '20xxxxxxxx',
          controller: phoneController,
          icon: Icons.phone_outlined,
          primaryColor: primaryColor,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return S.of(context).please_enter_phone;
            }
            if (!RegExp(r'^20[2579]\d{7}').hasMatch(value)) {
              return S.of(context).invalid_phone_number;
            }
            return null;
          },
        ),
      ],
    );
  }
}