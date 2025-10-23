import 'package:flutter/material.dart';
import 'package:homefind/screens/service/techView/widget/service_request_model.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:intl/intl.dart';

class CounterDialog extends StatefulWidget {
  final ServiceRequestModel request;

  const CounterDialog({super.key, required this.request});

  @override
  State<CounterDialog> createState() => _CounterDialogState();
}

class _CounterDialogState extends State<CounterDialog> {
  late TextEditingController priceController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    priceController = TextEditingController(
      text: (widget.request.offeredPrice ?? 0).toStringAsFixed(0),
    );
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          Icon(
            Icons.currency_exchange_rounded,
            color: AppColors.color2,
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            'ສະເໜີລາຄາໃໝ່',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.price_check, size: 18, color: AppColors.color1),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'ລາຄາສະເໜີເດີມ: ${NumberFormat().format(widget.request.offeredPrice ?? 0)}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'ລາຄາສະເໜີໃໝ່',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: priceController,
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.grey[800], fontSize: 16),
            decoration: InputDecoration(
              hintText: 'ປ້ອນຈຳນວນເງິນ...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.color1, width: 2),
              ),
              prefixIcon: Icon(Icons.attach_money, color: AppColors.color2),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'ຄຳອະທິບາຍ (ບໍ່ບັງຄັບ)',
            style: TextStyle(
              color: Colors.grey[700],
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: descriptionController,
            maxLines: 3,
            style: TextStyle(color: Colors.grey[800], fontSize: 14),
            decoration: InputDecoration(
              hintText: 'ປ້ອນຄຳອະທິບາຍເພີ່ມເຕີມ...',
              hintStyle: TextStyle(color: Colors.grey[500]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.color1, width: 2),
              ),
              filled: true,
              fillColor: Colors.grey[50],
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, null),
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey[600],
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'ຍົກເລີກ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            final price = double.tryParse(
              priceController.text.replaceAll(',', ''),
            );
            if (price != null && price > 0) {
              Navigator.pop(context, {
                'price': price,
                'description': descriptionController.text.trim(),
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.color1,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 1,
            shadowColor: Colors.black12,
          ),
          child: Text(
            'ສົ່ງລາຄາສະເໜີ',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
      actionsPadding: const EdgeInsets.only(bottom: 20, right: 20, left: 20),
      contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
    );
  }
}
