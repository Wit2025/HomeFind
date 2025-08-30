import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill/widget/dashed_divider.dart';
import 'package:homefind/widgets/Colors.dart';
import 'package:intl/intl.dart';

class ServiceDetailsSection extends StatelessWidget {
  final String title;
  final String bookingId;
  final String customerName;
  final DateTime createdAt;

  const ServiceDetailsSection({
    Key? key,
    required this.title,
    required this.bookingId,
    required this.customerName,
    required this.createdAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// --- Service Details ---
        Row(
          children: [
            Icon(
              Icons.receipt_long,
              color: AppColors.color1,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).serviceDetails,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _titleRow(S.of(context).serviceName, title),
        _titleRow(S.of(context).bookingId, bookingId),
        _titleRow(S.of(context).customer, customerName),
        _titleRow(
          S.of(context).date,
          DateFormat('dd/MM/yyyy HH:mm').format(createdAt),
        ),
        const SizedBox(height: 12),
        const DashedDivider(
          color: Colors.grey,
          height: 1.5,
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _titleRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(value, overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    );
  }
}