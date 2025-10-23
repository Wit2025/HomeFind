import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:image_picker/image_picker.dart';
// intl import no longer needed here
import 'package:homefind/screens/service/widget/service_location.dart';

class Step2DetailsPrice extends StatefulWidget {
  final List<MediaAttachment>? attachments;
  final ServiceLocation? selectedLocation;
  final String description;
  final TextEditingController descriptionController;
  final Function(double?) onPriceChanged;
  final Function(List<MediaAttachment>) onAttachmentsChanged;
  final Function(String) onDescriptionChanged;
  final PaymentMethod? paymentMethod;
  final Function(PaymentMethod?) onPaymentMethodChanged;
  final Function() onPreviousStep;
  final Function() onSubmit;

  const Step2DetailsPrice({
    Key? key,
    required this.attachments,
    required this.selectedLocation,
    required this.description,
    required this.descriptionController,
    required this.onPriceChanged,
    required this.onAttachmentsChanged,
    required this.onDescriptionChanged,
    required this.paymentMethod,
    required this.onPaymentMethodChanged,
    required this.onPreviousStep,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<Step2DetailsPrice> createState() => _Step2DetailsPriceState();
}

class _Step2DetailsPriceState extends State<Step2DetailsPrice> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      final newAttachments = images
          .map((x) => MediaAttachment(path: x.path, type: MediaType.image))
          .toList();
      final combined = [...?widget.attachments, ...newAttachments];
      widget.onAttachmentsChanged(combined.cast<MediaAttachment>());
    }
  }

  Future<void> _pickVideo() async {
    final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      final newAttachments = [
        MediaAttachment(path: video.path, type: MediaType.video),
      ];
      final combined = [...?widget.attachments, ...newAttachments];
      widget.onAttachmentsChanged(combined.cast<MediaAttachment>());
    }
  }

  // number formatting removed; not used in this widget

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
                  'ວິທີຈ່າຍເງິນ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                DropdownButton<PaymentMethod>(
                  value: widget.paymentMethod,
                  hint: const Text('ເລືອກວິທີຈ່າຍ'),
                  dropdownColor: Colors.white, // 👈 เพิ่มบรรทัดนี้
                  items: const [
                    DropdownMenuItem(
                      value: PaymentMethod.cash,
                      child: Text('ຈ່າຍເງິນສົດ'),
                    ),
                    DropdownMenuItem(
                      value: PaymentMethod.bankTransfer,
                      child: Text('ໂອນທະນາຄານ'),
                    ),
                    DropdownMenuItem(
                      value: PaymentMethod.online,
                      child: Text('ຈ່າຍອອນໄລນ'),
                    ),
                  ],
                  onChanged: widget.onPaymentMethodChanged,
                ),

                const SizedBox(height: 16),
                const Text(
                  'ປ້ອນລາຍລະອຽດ ແລະ ສະເໜີລາຄາ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                  'ແນບຮູບພາບ & ວິດີໂອ',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      onPressed: _pickImages,
                      icon: const Icon(
                        Icons.photo_library,
                        color: Colors.black87,
                      ),
                      label: const Text(
                        'ເລືອກຮູບພາບ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: AppColors.color1,
                          width: 2,
                        ), // 🔲 กรอบสีเทาอ่อน
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                    OutlinedButton.icon(
                      onPressed: _pickVideo,
                      icon: const Icon(Icons.videocam, color: Colors.black87),
                      label: const Text(
                        'ເລືອກວິດີໂອ',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: AppColors.color2,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // thumbnails
                if (widget.attachments != null &&
                    widget.attachments!.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.attachments!.length,
                      itemBuilder: (context, index) {
                        final MediaAttachment a = widget.attachments![index];
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: 100,
                          height: 100,
                          child: a.type == MediaType.image
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(a.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Center(child: Icon(Icons.videocam)),
                        );
                      },
                    ),
                  ),
                const SizedBox(height: 20),

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
  }

  @override
  void dispose() {
    super.dispose();
  }
}
