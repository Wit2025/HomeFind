import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:homefind/screens/service/widget/service_location.dart';

class Step2DetailsPrice extends StatefulWidget {
  final double? offerPrice;
  final File? selectedImage;
  final ServiceLocation? selectedLocation;
  final String description;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final Function(double?) onPriceChanged;
  final Function(File?) onImageChanged;
  final Function(String) onDescriptionChanged;
  final Function() onPreviousStep;
  final Function() onSubmit;

  const Step2DetailsPrice({
    Key? key,
    required this.offerPrice,
    required this.selectedImage,
    required this.selectedLocation,
    required this.description,
    required this.priceController,
    required this.descriptionController,
    required this.onPriceChanged,
    required this.onImageChanged,
    required this.onDescriptionChanged,
    required this.onPreviousStep,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<Step2DetailsPrice> createState() => _Step2DetailsPriceState();
}

class _Step2DetailsPriceState extends State<Step2DetailsPrice> {
  final ImagePicker _picker = ImagePicker();
  late FocusNode _priceFocusNode;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      widget.onImageChanged(File(image.path));
    }
  }

  String _formatNumber(double number) {
    final formatter = NumberFormat('#,###.00', 'en_US');
    return formatter.format(number.toInt());
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7 - 100,
      ),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'ປ້ອນລາຍລະອຽດ ແລະ ສະເໜີລາຄາ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // ราคาพร้อมปุ่ม + -
                const Text(
                  'ລາຄາທີ່ສະເໜີ (ກີບ)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.color1, width: 1),
                  ),
                  child: Row(
                    children: [
                      // ปุ่มลด (-)
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            double currentPrice = widget.offerPrice ?? 0;
                            if (currentPrice >= 1000) {
                              double newPrice = currentPrice - 1000;
                              widget.onPriceChanged(newPrice);
                              widget.priceController.text = _formatNumber(
                                newPrice,
                              );
                            }
                          },
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.color1.withOpacity(0.1),
                                  AppColors.color2.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: AppColors.color1,
                              size: 24,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: TextField(
                          controller: widget.priceController,
                          focusNode: _priceFocusNode,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.00 ກີບ',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 16,
                            ),
                          ),
                          onChanged: (value) {
                            // Do not reformat on every keystroke to avoid jumping cursor.
                            String cleanValue = value.replaceAll(',', '');
                            double? newPrice = double.tryParse(cleanValue);
                            widget.onPriceChanged(newPrice);
                          },
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            double currentPrice = widget.offerPrice ?? 0;
                            double newPrice = currentPrice + 1000;
                            widget.onPriceChanged(newPrice);
                            widget.priceController.text = _formatNumber(
                              newPrice,
                            );
                          },
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.color1.withOpacity(0.1),
                                  AppColors.color2.withOpacity(0.1),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                              ),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: AppColors.color1,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Note: selectedLocation is accepted but intentionally not shown here
                TextField(
                  controller: widget.descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: 'ອະທິບາຍບັນຫາ ແລະ ອາການ',
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.color1,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.color1,
                        width: 1,
                      ),
                    ),
                  ),
                  onChanged: widget.onDescriptionChanged,
                ),

                const SizedBox(height: 16),

                // รูปภาพ
                const Text(
                  'ແນບຮູບພາບ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.color1),
                    ),
                    child: widget.selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              widget.selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate,
                                size: 50,
                                color: AppColors.color1,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'ແຕະເພື່ອເລືອກຮູບພາບ',
                                style: TextStyle(
                                  color: AppColors.color1,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 30),

                // ปุ่มย้อนกลับ / ส่ง
                Row(
                  children: [
                    // ปุ่มย้อนกลับ
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onPreviousStep,
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: AppColors.color1, width: 2),
                        ),
                        child: const Text(
                          'ກັບຄືນ',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.color1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // ปุ่มส่งด้วย gradient
                    Expanded(
                      child: InkWell(
                        onTap: widget.onSubmit,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: const LinearGradient(
                              colors: [AppColors.color1, AppColors.color2],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'ສະເໜີລາຄາ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _priceFocusNode = FocusNode();
    _priceFocusNode.addListener(() {
      if (!_priceFocusNode.hasFocus) {
        // When focus is lost, format the value for display
        String text = widget.priceController.text.replaceAll(',', '');
        double? value = double.tryParse(text);
        if (value != null) {
          String formatted = _formatNumber(value);
          widget.priceController.text = formatted;
          widget.onPriceChanged(value);
        }
      }
    });
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    super.dispose();
  }
}
