import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/screens/home/pages/bill/widget/dashed_divider.dart';
import 'package:homefind/widgets/colors.dart';
import 'package:intl/intl.dart';

class PaymentSummarySection extends StatelessWidget {
  final double bookingFee;
  final String currency;
  final NumberFormat money;

  const PaymentSummarySection({
    super.key,
    required this.bookingFee,
    required this.currency,
    required this.money,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// --- Payment Summary ---
        Row(
          children: [
            Icon(
              Icons.credit_card,
              color: AppColors.color1,
              size: 24,
            ),
            const SizedBox(width: 12),
            Text(
              S.of(context).paymentSummary,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _amountRow(
          S.of(context).booking_fee,
          money.format(bookingFee),
          currency,
        ),
        _amountRow(
          S.of(context).serviceCharge,
          money.format(0),
          currency,
        ),
        const SizedBox(height: 12),
        const DashedDivider(
          color: Colors.grey,
          height: 1.5,
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).grandTotal,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                Text(
                  money.format(50000),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColors.color1,
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  currency,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.color1,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _amountRow(String label, String amount, String currency) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
          Row(
            children: [
              Text(amount, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(width: 6),
              Text(currency),
            ],
          ),
        ],
      ),
    );
  }
}