// property_form_submit_service.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_controller.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_form_validator.dart';
import 'package:homefind/screens/join/pages/propertie_detail_page/widget/property_translations.dart';

class AddFormSubmitService {
  static Future<void> submitForm(
    BuildContext context,
    GlobalKey<FormState> formKey,
    PropertyFormController controller,
  ) async {
    if (!PropertyFormValidator.validateForm(context, formKey, controller)) {
      return;
    }

    controller.setLoading(true);

    try {
      // Simulate network request
      await Future.delayed(const Duration(seconds: 2));

      if (context.mounted) {
        _showSuccessDialog(context, controller);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).error}: $e'),
            backgroundColor: const Color.fromARGB(255, 12, 105, 122),
          ),
        );
      }
    } finally {
      if (context.mounted) {
        controller.setLoading(false);
      }
    }
  }

  static void _showSuccessDialog(
    BuildContext context,
    PropertyFormController controller,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color.fromARGB(255, 87, 167, 177),
                Color.fromARGB(255, 12, 105, 122),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 40, color: Colors.green),
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).submit_success,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                '${S.of(context).you_posted_data}${PropertyTranslations.translateValue(controller.selectedCategoryButton, context)}${S.of(context).submit_success}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: 170,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    S.of(context).understood,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
