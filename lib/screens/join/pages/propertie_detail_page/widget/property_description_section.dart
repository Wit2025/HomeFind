// widgets/property_description_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class PropertyDescriptionSection extends StatelessWidget {
  final Color primaryColor;
  final TextEditingController descriptionController;

  const PropertyDescriptionSection({
    super.key,
    required this.primaryColor,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).additional_details,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
              labelText: S.of(context).additional_details_optional,
              hintText: S.of(context).description_placeholder,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: primaryColor, width: 2),
              ),
              filled: true,
              fillColor: Colors.white,
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.all(20),
            ),
            maxLines: 5,
          ),
        ),
      ],
    );
  }
}
