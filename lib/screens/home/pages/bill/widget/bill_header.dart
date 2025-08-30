import 'package:flutter/material.dart';
import 'package:homefind/generated/l10n.dart';
import 'package:homefind/widgets/Colors.dart';

class BillHeader extends StatelessWidget {
  final Animation<double> scale;
  final String customerName;

  const BillHeader({
    Key? key,
    required this.scale,
    required this.customerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Big success icon with bounce-in animation
        ScaleTransition(
          scale: scale,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 44,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.check_rounded,
                size: 48,
                color: AppColors.color1,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          S.of(context).bookingSuccess,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '${S.of(context).thankYou}, $customerName',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}