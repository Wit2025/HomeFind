// widgets/property_main_image_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'dart:io';

class PropertyMainImageSection extends StatelessWidget {
  final Color primaryColor;
  final File? selectedMainImage;
  final VoidCallback onPickImage;
  final VoidCallback onRemoveImage;

  const PropertyMainImageSection({
    super.key,
    required this.primaryColor,
    required this.selectedMainImage,
    required this.onPickImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).upload_main_image,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: GestureDetector(
            onTap: onPickImage,
            child: Container(
              width: 280,
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: selectedMainImage != null
                      ? primaryColor
                      : Colors.grey[300]!,
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: selectedMainImage == null
                  ? _buildEmptyMainImagePlaceholder(context)
                  : _buildMainImageDisplay(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text(
            S.of(context).upload_current_photo_1,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyMainImagePlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.image, size: 50, color: primaryColor),
        const SizedBox(height: 8),
        Text(
          S.of(context).tap_to_upload,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildMainImageDisplay() {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.file(selectedMainImage!, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: onRemoveImage,
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}