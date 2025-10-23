// widgets/property_form_fields.dart
import 'package:flutter/material.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_translations.dart';

class PropertyFormFields {
  static Widget buildInputField({
    required String label,
    String hint = "",
    required TextEditingController controller,
    required IconData icon,
    required Color primaryColor,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
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
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
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
          prefixIcon: Icon(icon, color: primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }

  static Widget buildDropdownField(
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon,
    Color primaryColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            items: items.map((String item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }

  static Widget buildTranslatableDropdownField(
    BuildContext context,
    String label,
    String? value,
    List<String> items,
    void Function(String?) onChanged,
    IconData icon,
    Color primaryColor,
  ) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(icon, color: primaryColor),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 20,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: primaryColor),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item, // Keep original Lao value
                child: Text(
                  PropertyTranslations.translateValue(item, context),
                ), // Display translated text
              );
            }).toList(),
            onChanged: onChanged,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
