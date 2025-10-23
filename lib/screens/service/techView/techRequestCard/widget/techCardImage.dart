import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/Colors.dart';

class TechRequestCardImage extends StatelessWidget {
  final ServiceRequestModel request;

  const TechRequestCardImage({Key? key, required this.request})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.color1.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: AspectRatio(aspectRatio: 16 / 9, child: _buildImageWidget()),
      ),
    );
  }

  Widget _buildImageWidget() {
    final imageAttachments = request.attachments
        .where((a) => a.type == MediaType.image)
        .toList();
    if (imageAttachments.isEmpty) return _buildImagePlaceholder();

    final path = imageAttachments.first.path;

    try {
      if (path.startsWith('assets/') || path.startsWith('packages/')) {
        return Image.asset(path, fit: BoxFit.cover, width: double.infinity);
      } else {
        final file = File(path);
        if (file.existsSync()) {
          return Image.file(file, fit: BoxFit.cover, width: double.infinity);
        } else {
          return _buildImagePlaceholder();
        }
      }
    } catch (e) {
      return _buildImagePlaceholder();
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.color1.withOpacity(0.1),
            AppColors.color2.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.photo_camera_outlined,
        color: AppColors.color1.withOpacity(0.5),
        size: 40,
      ),
    );
  }
}
