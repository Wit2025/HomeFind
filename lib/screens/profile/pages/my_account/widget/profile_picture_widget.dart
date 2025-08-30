import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';
import 'dart:io';

class ProfilePictureWidget extends StatelessWidget {
  final File? profileImage;
  final VoidCallback onTap;

  const ProfilePictureWidget({
    super.key,
    required this.profileImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFFE0F2F1),
              border: Border.all(color: AppColors.color1, width: 2),
              image: profileImage != null
                  ? DecorationImage(
                      image: FileImage(profileImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profileImage == null
                ? const Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.color1,
                  )
                : null,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.color1,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Icon(
              Icons.camera_enhance_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}