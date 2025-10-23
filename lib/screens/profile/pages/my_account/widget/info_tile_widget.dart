import 'package:flutter/material.dart';
import 'package:homefind/widgets/colors.dart';

class InfoTileWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool lastItem;

  const InfoTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.lastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColors.color1, size: 24),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}