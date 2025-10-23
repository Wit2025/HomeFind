import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/colors.dart';
import 'points_action.dart';

class PointsSummaryCard extends StatelessWidget {
  final int totalPoints;
  final VoidCallback onRedeem;
  final VoidCallback onDetails;

  const PointsSummaryCard({
    super.key,
    required this.totalPoints,
    required this.onRedeem,
    required this.onDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.color1, AppColors.color2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            S.of(context).totalScore,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '$totalPoints',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 42,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              PointsAction(
                icon: Icons.card_giftcard,
                label: S.of(context).redeemPoints,
                onTap: onRedeem,
              ),
              PointsAction(
                icon: Icons.info_outline,
                label: S.of(context).details,
                onTap: onDetails,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
