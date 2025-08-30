// widgets/property_images_section.dart
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'dart:io';

class PropertyImagesSection extends StatelessWidget {
  final Color primaryColor;
  final List<File> selectedPropertyImages;
  final VoidCallback onPickImages;
  final Function(int index) onRemoveImage;

  const PropertyImagesSection({
    super.key,
    required this.primaryColor,
    required this.selectedPropertyImages,
    required this.onPickImages,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).accommodation_photos,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 12, 105, 122),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: selectedPropertyImages.isEmpty
              ? _buildEmptyPropertyImagePlaceholder(context)
              : _buildPropertyImageList(context),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onPickImages,
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: primaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: Icon(
              Icons.add_photo_alternate_outlined,
              color: primaryColor,
            ),
            label: Text(
              S.of(context).add_photo,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyPropertyImagePlaceholder(BuildContext context) {
    return GestureDetector(
      onTap: onPickImages,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey[300]!,
            width: 2,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.collections_outlined, size: 50, color: primaryColor),
            const SizedBox(height: 8),
            Text(
              S.of(context).upload_main_image,
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              S.of(context).max_16_images,
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyImageList(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:
            selectedPropertyImages.length +
            (selectedPropertyImages.length < 16 ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == selectedPropertyImages.length) {
            return GestureDetector(
              onTap: onPickImages,
              child: Container(
                width: 120,
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey[300]!,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30, color: primaryColor),
                    const SizedBox(height: 4),
                    Text(
                      S.of(context).add_photo,
                      style: TextStyle(color: primaryColor, fontSize: 12),
                    ),
                  ],
                ),
              ),
            );
          }

          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    selectedPropertyImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () => onRemoveImage(index),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}