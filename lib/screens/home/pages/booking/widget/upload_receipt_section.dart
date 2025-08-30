import 'dart:io';
import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';

class UploadReceiptSection extends StatelessWidget {
  final File? image;
  final VoidCallback onPickImage;

  const UploadReceiptSection({
    super.key,
    required this.image,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            S.of(context).upload_transfer_receipt,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),

          if (image != null) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.green.shade200),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    S.of(context).upload_completed,
                    style: TextStyle(
                      color: Colors.green.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          SizedBox(height: 12),
          GestureDetector(
            onTap: onPickImage,
            child: Container(
              height: 230,
              width: double.infinity,
              decoration: BoxDecoration(
                color: image != null ? Colors.transparent : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: image != null ? Colors.green : Colors.grey.shade300,
                  width: 2,
                  style: image != null ? BorderStyle.solid : BorderStyle.solid,
                ),
                image: image != null
                    ? DecorationImage(
                        image: FileImage(image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.cloud_upload_outlined,
                          size: 50,
                          color: Colors.grey[500],
                        ),
                        SizedBox(height: 12),
                        Text(
                          S.of(context).tap_to_select_image,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          S.of(context).file_formats,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}