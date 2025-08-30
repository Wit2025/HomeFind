// property_image_service.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'property_form_controller.dart';

class PropertyImageService {
  static Future<void> pickMainImage(
    BuildContext context,
    PropertyFormController controller,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        controller.setMainImage(File(pickedFile.path));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).image_selection_error}: $e'),
            backgroundColor: const Color.fromARGB(255, 12, 105, 122),
          ),
        );
      }
    }
  }

  static Future<void> pickPropertyImages(
    BuildContext context,
    PropertyFormController controller,
  ) async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> pickedFiles = await picker.pickMultiImage(
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (pickedFiles.isNotEmpty) {
        final int remainingSlots = 16 - controller.selectedPropertyImages.length;

        if (remainingSlots <= 0) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).full_16_images),
                backgroundColor: const Color.fromARGB(255, 12, 105, 122),
              ),
            );
          }
          return;
        }

        final List<File> newImages = pickedFiles
            .take(remainingSlots)
            .map((file) => File(file.path))
            .toList();

        controller.addPropertyImages(newImages);

        if (pickedFiles.length > remainingSlots && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).max_16_images),
              backgroundColor: const Color.fromARGB(255, 12, 105, 122),
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${S.of(context).image_selection_error}: $e'),
            backgroundColor: const Color.fromARGB(255, 12, 105, 122),
          ),
        );
      }
    }
  }
}