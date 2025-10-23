import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerModal extends StatefulWidget {
  final ImagePicker picker;
  final bool isPickingImage;
  final Function(bool) onImagePicking;

  const ImagePickerModal({
    super.key,
    required this.picker,
    required this.isPickingImage,
    required this.onImagePicking,
  });

  @override
  State<ImagePickerModal> createState() => _ImagePickerModalState();
}

class _ImagePickerModalState extends State<ImagePickerModal> {
  bool _isPickingImage = false;

  @override
  void initState() {
    super.initState();
    _isPickingImage = widget.isPickingImage;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: ValueKey(Localizations.localeOf(context).languageCode),
      child: Container(
        height: 200,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 8),
            Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 8),
            Text(
              S.of(context).select_image,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (_isPickingImage) return;
                        setState(() {
                          _isPickingImage = true;
                        });
                        widget.onImagePicking(true);
                        final picked = await widget.picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 80,
                        );
                        setState(() {
                          _isPickingImage = false;
                        });
                        widget.onImagePicking(false);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, picked);
                      },
                      child: AbsorbPointer(
                        absorbing: _isPickingImage,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.color1.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.color1,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.photo,
                                size: 30,
                                color: AppColors.color1,
                              ),
                              Text(
                                S.of(context).gallery,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (_isPickingImage) return;
                        setState(() {
                          _isPickingImage = true;
                        });
                        widget.onImagePicking(true);
                        final picked = await widget.picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 80,
                        );
                        setState(() {
                          _isPickingImage = false;
                        });
                        widget.onImagePicking(false);
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, picked);
                      },
                      child: AbsorbPointer(
                        absorbing: _isPickingImage,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.color2.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: AppColors.color2,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: AppColors.color2,
                              ),
                              Text(
                                S.of(context).camera,
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
