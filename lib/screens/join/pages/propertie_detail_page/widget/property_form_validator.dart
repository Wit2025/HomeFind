// property_form_validator.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'property_form_controller.dart';

class PropertyFormValidator {
  static bool validateForm(
    BuildContext context,
    GlobalKey<FormState> formKey,
    PropertyFormController controller,
  ) {
    // Check form fields validation
    if (!formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).pleaseEnterCompleteData),
          backgroundColor: const Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return false;
    }

    // Check main image
    if (controller.selectedMainImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_upload_main_image),
          backgroundColor: const Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return false;
    }

    // Check property images
    if (controller.selectedPropertyImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_add_min_1_photo),
          backgroundColor: const Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return false;
    }

    // Check rental period for rent properties
    if (controller.selectedStatus == 'ເຊົ່າ' && controller.selectedRentalPeriod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).please_select_rental_period),
          backgroundColor: const Color.fromARGB(255, 12, 105, 122),
        ),
      );
      return false;
    }

    return true;
  }
}