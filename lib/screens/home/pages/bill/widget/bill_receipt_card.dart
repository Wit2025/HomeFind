import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill/widget/dashed_divider.dart';
import 'package:homefind/screens/home/pages/bill/widget/frosted_card.dart';
import 'package:homefind/screens/home/pages/bill/widget/positions_oval_clipper.dart';
import 'package:homefind/screens/home/pages/bill/widget/service_detail_section.dart';
import 'package:intl/intl.dart';
import 'payment_summary_section.dart';

class BillReceiptCard extends StatelessWidget {
  final String title;
  final String bookingId;
  final String customerName;
  final DateTime createdAt;
  final double bookingFee;
  final String currency;
  final NumberFormat money;

  const BillReceiptCard({
    Key? key,
    required this.title,
    required this.bookingId,
    required this.customerName,
    required this.createdAt,
    required this.bookingFee,
    required this.currency,
    required this.money,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ClipPath(
        clipper: PositionedOvalClipper(positionY: 0.85, radius: 16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: FrostedCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    S.of(context).paymentReceipt,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  S.of(context).receiptNo(0001),
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 6),
                const DashedDivider(color: Colors.grey, height: 1.5),
                const SizedBox(height: 12),

                // Service Details Section
                ServiceDetailsSection(
                  title: title,
                  bookingId: bookingId,
                  customerName: customerName,
                  createdAt: createdAt,
                ),

                // Payment Summary Section
                PaymentSummarySection(
                  bookingFee: bookingFee,
                  currency: currency,
                  money: money,
                ),

                const SizedBox(height: 64),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const DashedDivider(color: Colors.grey, height: 1.5),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    S.of(context).thankYou,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
