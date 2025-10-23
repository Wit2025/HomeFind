import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:image_picker/image_picker.dart';

// Handles UI & logic for uploading personal and/or document images.
// You can pass only one of the callbacks to show just that section.
class ImageUploadSection extends StatelessWidget {
  final File? personalImage;
  final File? documentImage;

  // Make callbacks optional; show a section only if its callback is provided.
  final ValueChanged<File?>? onPersonalImageChanged;
  final ValueChanged<File?>? onDocumentImageChanged;

  const ImageUploadSection({
    super.key,
    this.personalImage,
    this.documentImage,
    this.onPersonalImageChanged,
    this.onDocumentImageChanged,
  }) : assert(
         onPersonalImageChanged != null || onDocumentImageChanged != null,
         'Provide at least one of the callbacks',
       );

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    if (onPersonalImageChanged != null) {
      children.addAll([
        _buildSectionTitle(S.of(context).upload_photo),
        const SizedBox(height: 12),
        Center(
          child: _buildImageUploader(
            context,
            imageFile: personalImage,
            onTap: () => _pickImage(context, ImageType.personal),
            onRemove: () => onPersonalImageChanged!(null),
            icon: Icons.image,
            title: S.of(context).tap_to_upload,
            subtitle: S.of(context).upload_current_photo,
            isDocument: false,
          ),
        ),
        const SizedBox(height: 14),
      ]);
    }

    if (onDocumentImageChanged != null) {
      children.addAll([
        _buildSectionTitle(S.of(context).document_photo),
        const SizedBox(height: 12),
        Center(
          child: _buildImageUploader(
            context,
            imageFile: documentImage,
            onTap: () => _pickImage(context, ImageType.document),
            onRemove: () => onDocumentImageChanged!(null),
            icon: Icons.credit_card_outlined,
            title: S.of(context).upload_document,
            subtitle: S.of(context).tap_to_upload_document,
            isDocument: true,
          ),
        ),
      ]);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  // Helper: pick an image from the gallery
  Future<void> _pickImage(BuildContext context, ImageType type) async {
    try {
      // If the relevant callback is missing, do nothing (defensive)
      if (type == ImageType.personal && onPersonalImageChanged == null) return;
      if (type == ImageType.document && onDocumentImageChanged == null) return;

      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: type == ImageType.personal ? 800 : 1200,
        maxHeight: type == ImageType.personal ? 800 : 1200,
        imageQuality: 90,
      );

      if (pickedFile != null) {
        final newFile = File(pickedFile.path);
        if (type == ImageType.personal) {
          onPersonalImageChanged?.call(newFile);
        } else {
          onDocumentImageChanged?.call(newFile);
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // ignore: use_build_context_synchronously
          content: Text('${S.of(context).image_selection_error}: $e'),
          backgroundColor: AppColors.color1,
        ),
      );
    }
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.color1,
      ),
    );
  }

  Widget _buildImageUploader(
    BuildContext context, {
    required File? imageFile,
    required VoidCallback onTap,
    required VoidCallback onRemove,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isDocument,
  }) {
    final primary = AppColors.color1;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: imageFile != null ? primary : Colors.grey[300]!,
            width: isDocument ? 2 : 3,
            style: BorderStyle.solid,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: imageFile == null
            ? _buildPlaceholder(icon, title, subtitle)
            : _buildImageDisplay(imageFile, onRemove),
      ),
    );
  }

  Widget _buildPlaceholder(IconData icon, String title, String subtitle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 50, color: AppColors.color1),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            color: AppColors.color1,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildImageDisplay(File imageFile, VoidCallback onRemove) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Image.file(
            imageFile,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: Colors.white, size: 18),
            ),
          ),
        ),
      ],
    );
  }
}

enum ImageType { personal, document }
